import 'package:get/get.dart';
import 'package:landmark_assignment/app/data/api_call.dart';
import 'package:landmark_assignment/app/data/model/news_list_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController



  Rxn<NewsListResponse> newsList = Rxn<NewsListResponse>();
  RxBool isLoading = RxBool(false);

  Future<void> fetchNews() async{
    isLoading.value = true;
    newsList.value = await ApiCall.instance.getNewsList();
    isLoading.value = false;
  }

  @override
  void onInit() async{
    await fetchNews();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
