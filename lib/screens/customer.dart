import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';

class CustomerManagement extends StatelessWidget {
  CustomerManagement({Key? key}) : super(key: key);
  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return controller.users.isEmpty
              ? const Center(
                  child: Text('no data founded'),
                )
              : ListView.builder(
                  itemCount: controller.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('${controller.users[index].name}'),
                              subtitle:
                                  Text('${controller.users[index].email}'),
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
                                      controller.deleteUser(
                                          controller.users[index].id!);
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
