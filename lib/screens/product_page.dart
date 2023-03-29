import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/feature_item.dart';

import '../controller/main_controller.dart';

class AllProduct extends StatelessWidget {
  AllProduct({Key? key}) : super(key: key);
  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return controller.products.isEmpty
              ? const Center(
                  child: Text('no products founded'),
                )
              : ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FeatureItem(data: controller.products[index]);
                  },
                );
        }),
      ),
    );
  }
}
