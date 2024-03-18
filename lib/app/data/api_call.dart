import 'package:landmark_assignment/app/data/model/news_list_model.dart';

import 'network_client.dart';

class ApiCall extends NetworkClient {
  ApiCall._();

  static ApiCall instance = ApiCall._();

  static String apiToken = 'CjJ6OCZxYOVz15bry0unhKyItz25ZWGSuNfmtMQm';
  String newsUrl =
      'https://api.thenewsapi.com/v1/news/top?api_token=$apiToken&locale=us&limit=3';

  Future<NewsListResponse?> getNewsList() async {
    Map<String, dynamic>? response = await getApi(
      newsUrl,
      showResponse: true,
    );
    return response == null ? null : NewsListResponse.fromJson(response);
  }
}
