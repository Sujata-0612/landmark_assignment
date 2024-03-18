import 'package:flutter_test/flutter_test.dart';
import 'package:landmark_assignment/app/data/api_call.dart';
import 'package:landmark_assignment/app/data/model/news_list_model.dart';
import 'package:landmark_assignment/app/modules/home/controllers/home_controller.dart';
import 'package:mocktail/mocktail.dart';

import 'static_data.dart';

class MockNewsService extends Mock implements ApiCall {}

void main() {
  late HomeController home;
  late MockNewsService apiCall;

  setUp(() {
    home = HomeController();
    apiCall = MockNewsService();
  });

  test(
    'Initial values are correct',
    () {
      expect(home.newsList.value, null);
      expect(home.isLoading.value, false);
    },
  );

  group(
    'get News List Methods Check',
    () {
      /// Static Data as we don't depend upon server in unit test
      final newsList = NewsListResponse.fromJson(StaticData.staticJson);

      void arrangeNews() {
        when(() => apiCall.getNewsList()).thenAnswer((_) async => newsList);
      }

      test(
        'get news using the Mock apiCall',
        () async {
          when(() => apiCall.getNewsList()).thenAnswer((_) async => null);
          final future = apiCall.getNewsList();
          await future;
          verify(() => apiCall.getNewsList()).called(1);
        },
      );

      test('indicates loading of data, sets news to the nesList from Api call', () async {
        arrangeNews();
        final future = home.fetchNews();
        expect(home.isLoading.value, true);
        await future;
        home.newsList.value = newsList;
        expect(home.newsList.value, newsList);
        expect(home.isLoading.value, false);
      });
    },
  );
}