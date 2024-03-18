import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landmark_assignment/app/consts/string_consts.dart';
import 'package:landmark_assignment/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConsts.newsTitle,style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 1.0,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  key: Key('progress-indicator'),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                      ),
                      itemCount: controller.newsList.value?.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = controller.newsList.value?.data?[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.NEWS_DETAILS,
                                arguments: [index]);
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(data?.imageUrl ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                            clipBehavior: Clip.hardEdge,
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  child: Text(
                                    data?.title ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ));
      }),
    );
  }
}
