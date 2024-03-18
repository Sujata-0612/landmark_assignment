import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:landmark_assignment/app/consts/string_consts.dart';
import 'package:landmark_assignment/app/data/api_call.dart';
import 'package:landmark_assignment/app/data/model/news_list_model.dart';
import 'package:landmark_assignment/app/modules/home/controllers/home_controller.dart';
import 'package:landmark_assignment/app/modules/home/views/home_view.dart';
import 'package:mocktail/mocktail.dart';
import 'static_data.dart';

class MockNewsService extends Mock implements ApiCall {}

void main() {
  late MockNewsService apiCall;

  setUp(() {
    Get.put(HomeController());
    apiCall = MockNewsService();
  });

  /// Static Data as we don't depend upon server in unit test
  final newsList = NewsListResponse.fromJson(StaticData.staticJson);

  void arrangeNews() {
    when(() => apiCall.getNewsList()).thenAnswer((_) async => newsList);
  }

  void arrangeNewsWithDelayed() {
    when(() => apiCall.getNewsList()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return newsList;
    });
  }

  Widget createWidgetUnderTest() {
    return const GetMaterialApp(
      home: HomeView(),
    );
  }

  testWidgets(
    'title is displayed',
    (WidgetTester tester) async {
      arrangeNews();
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text(StringConsts.newsTitle), findsOneWidget);
    },
  );

  testWidgets(
    'loading widget is displayed when waiting for news',
    (WidgetTester tester) async {
      arrangeNewsWithDelayed();
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key('progress-indicator')), findsOneWidget);
    },
  );
}
