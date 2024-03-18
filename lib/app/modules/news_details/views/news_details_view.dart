import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landmark_assignment/app/consts/string_consts.dart';
import 'package:landmark_assignment/app/modules/home/controllers/home_controller.dart';

import '../../../graphics/pinch_zoom_image.dart';
import '../controllers/news_details_controller.dart';

class NewsDetailsView extends GetView<NewsDetailsController> {
  NewsDetailsView({Key? key}) : super(key: key);

  final double minScale = 1;
  final double maxScale = 4;

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConsts.newsTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PinchZoomImage(
              imageUrl: homeController.newsList.value?.data?[controller.index].imageUrl ?? '',
            ),
          ],
        ),
      ),
    );
  }
}



