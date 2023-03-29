import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';

class DeliveryManagement extends StatelessWidget {
  DeliveryManagement({Key? key}) : super(key: key);
  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Management'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addDelivery();
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return controller.delivery.isEmpty
              ? const Center(
                  child: Text('no data founded'),
                )
              : ListView.builder(
                  itemCount: controller.delivery.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('${controller.delivery[index].name}'),
                              leading: CircleAvatar(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.amber.shade700,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.editDelivery(
                                            controller.delivery[index].id!);
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                    onPressed: () {
                                      controller.deleteDelivery(
                                          controller.delivery[index].id!);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  },
                );
        }),
      ),
    );
  }
}
