import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../graphics/snackbar/custom_snackbar.dart';

enum RestApiMethod { get, post }

class NetworkClient {

  Dio dio = Dio();

  showError(DioException e) {
    try {
      log(e.toString(), name: 'try check');
      showSnackBar(jsonDecode(e.response.toString())['message'] ?? e.message, isError: true);
    } catch (error) {
      showSnackBar(e.message ?? '', isError: true);
    }
  }

  Future<Map<String, dynamic>> getHeader() async {
    // String? bToken = LocalStorage.instance.readString(LocalStorageKeys.token);
    final Map<String, dynamic> headers = {
      'Authorization': 'Bearer ',
      'Access-Control-Allow-Headers': true,
      'Content-Type': 'application/json',
    };
    return headers;
  }

  Future<Map<String, dynamic>?> _restApi<T>(
      String path, {
        required RestApiMethod apiMethod,
        Map<String, dynamic>? headers,
        dynamic body = const {},
        bool isBearerToken = false,
        bool showError = true,
        bool attachHeader = true,
        bool showResponseLog = true,
      }) async {
    try {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
      HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      ///logging the POST endpoint and PAYLOAD
      log(path, name: '$apiMethod');
      if (body is! FormData) log(body.toString(), name: "PAYLOAD");
      String checkToken = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiIxIiwiVXNlclJvbGVJZCI6IjEiLCJVc2VyRnVsbE5hbWUiOiJBZG1pbiIsIm5iZiI6MTcwMTY4NDQ1MywiZXhwIjoxNzAxNjg4MDUzLCJpYXQiOjE3MDE2ODQ0NTN9.jvHjpCy2Ww2ZbcWNGqAOZOqdLLja5g3cP8Hoj2J8-Z0';
      final bool res = headers?['Authorization'] == checkToken;
      log('$res', name: 'Token Equality');
      log('${headers?['Authorization']}', name: 'Apu');

      ///Hitting the POST request
      Response<T>? response;
      switch (apiMethod) {
        case RestApiMethod.post:
          response = await dio.post(
            path,
            data: body,
            options: attachHeader ? Options(headers: headers ?? await getHeader()) : null,
          );
          break;
        case RestApiMethod.get:
          response = await dio.get(
            path,
            data: body,
            options:  attachHeader ? Options(headers: await getHeader()) : null,
          );
          break;
        default:
          break;
      }

      ///logging the RESPONSE details
      if (showResponseLog) {
        log('${response?.data}', name: "RESPONSE");
        log('${response?.statusCode}', name: "RESPONSE STATUS CODE");
      }

      ///if nor error then return response else return NUll
      if (response?.data is Map?) {
        Map<String, dynamic>? x = response?.data as Map<String, dynamic>?;
        if (x != null && (x['status'] != false)) {
          return x;
        } else {
          if (showError) {
            String errorMessage = '${x?['message'].toString()}';
            if (!errorMessage.contains('SocketException') && !errorMessage.contains('HttpException')) {
              showSnackBar(errorMessage, isError: true);
            } else {
              showSnackBar('Something went wrong!', isError: true);
            }
          }
        }
      }
    } on DioException catch (e) {
      ///if exception show the error
      log('${e.message}', name:'Dio Message');
      log('${e.type}', name:'Dio Type');
      log('${e.error}', name:'Dio Error');
      log('${e.requestOptions}', name:'Dio request options');
      log('${e.response}', name: 'DIO EXCEPTION');
      if (showError) {
        if (!e.toString().contains('SocketException') && !e.toString().contains('HttpException')) {
          this.showError(e);
        } else {
          // showSnackBar('Something went wrong!', isError: true);
        }
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> postApi<T>(
      String path, {
        required dynamic body,
        bool showError = true,
        Map<String, dynamic>? header,
        required bool showResponse,
        bool attachToken = true,
      }) async {
    return await _restApi(
        path,
        body: body,
        apiMethod: RestApiMethod.post,
        showError: showError,
        headers: header,
        showResponseLog: showResponse,
        attachHeader: attachToken
    );
  }

  Future<Map<String, dynamic>?> getApi<T>(
      String path, {
        bool showError = true,
        Map<String, dynamic>? header,
        required bool showResponse,
      }) async {
    return await _restApi(
      path,
      apiMethod: RestApiMethod.get,
      showError: showError,
      headers: header,
      showResponseLog: showResponse,
    );
  }
}
