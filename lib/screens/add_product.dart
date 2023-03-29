import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../controller/main_controller.dart';
import '../widgets/custom_textfield.dart';

import '../widgets/custom_button.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GetX<MainController>(
          builder: (logic) {
            return logic.types.isEmpty
                ? const Center(
                    child: Text('No Type available to add'),
                  )
                : Form(
                    key: logic.formKey,
                    child: ListView(
                      children: [
                        GetBuilder<MainController>(
                          id: 'image',
                          builder: (logic) {
                            return GestureDetector(
                              onTap: () {
                                logic.imageSelect();
                              },
                              child: Container(
                                height: height * 0.35,
                                width: width * 0.65,
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(46),
                                ),
                                child: logic.image == null
                                    ? const Center(
                                        child: Icon(Icons.add_a_photo_outlined))
                                    : Image.file(
                                        File(logic.image!.path),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            );
                          },
                        ),
                        DropdownSearch<String>(
                          mode: Mode.BOTTOM_SHEET,
                          showSelectedItems: true,
                          items: logic.types,
                          dropdownSearchDecoration: const InputDecoration(
                            labelText: "Product type",
                            hintText: "select product type",
                          ),
                          onChanged: (value) {
                            logic.type.text = value!;
                          },
                          selectedItem: logic.types[0],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            controller: logic.name,
                            validator: (validator) {
                              return logic.validate(validator!);
                            },
                            lable: 'product name',
                            icon: const Icon(Icons.shopping_cart),
                            input: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            controller: logic.price,
                            validator: (validator) {
                              return logic.validate(validator!);
                            },
                            lable: 'product price',
                            icon: const Icon(Icons.money),
                            input: TextInputType.number),
                        CustomTextField(
                            controller: logic.number,
                            validator: (validator) {
                              return logic.validate(validator!);
                            },
                            lable: 'product Number',
                            icon: const Icon(Icons.description),
                            input: TextInputType.number),
                        CustomTextField(
                            controller: logic.desc,
                            validator: (validator) {
                              return logic.validate(validator!);
                            },
                            lable: 'product Description',
                            icon: const Icon(Icons.description),
                            input: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownSearch<String>.multiSelection(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: const [
                            "Green",
                            "White",
                            "Black",
                            "Yellow",
                            "Red",
                            "Brown"
                          ],
                          dropdownSearchDecoration: const InputDecoration(
                            labelText: "Color Menu",
                          ),
                          onChanged: (value) {
                            logic.color = value;
                          },
                          // selectedItems: ["white"],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextButton(
                            lable: 'add',
                            ontap: () async {
                              if (logic.type.text.isEmpty) {
                                logic.type.text = logic.types[0];
                                await logic.addProduct();
                              } else {
                                await logic.addProduct();
                              }
                            },
                            color: Colors.indigo),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
