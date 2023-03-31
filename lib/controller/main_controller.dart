import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../model/images_model.dart';
import '../model/product_model.dart';
import '../model/product_type_model.dart';
import '../model/user_model.dart';
import '../widgets/custom_button.dart';
import 'package:path/path.dart';

import '../model/delivery_model.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/loading.dart';
import '../widgets/snackbar.dart';

class MainController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<Product> products = RxList<Product>([]);
  RxList<Delivery> delivery = RxList<Delivery>([]);
  RxList<ProductType> productType = RxList<ProductType>([]);
  RxList<Users> users = RxList<Users>([]);
  RxList<String> types = RxList<String>([]);
  RxList<Images> images = RxList<Images>([]);
  late TextEditingController name, type, price, desc, number;
  late dynamic company;
  String selectedImage = '';
  DateTime time = DateTime.now();
  late CollectionReference collectionReference;
  late CollectionReference collectionReference2;
  late CollectionReference collectionReference3;
  late CollectionReference collectionReference4;
  late CollectionReference collectionReference5;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  @override
  void onInit() {
    collectionReference = firebaseFirestore.collection("product");
    collectionReference2 = firebaseFirestore.collection("delivery");
    collectionReference3 = firebaseFirestore.collection("productType");
    collectionReference4 = firebaseFirestore.collection("users");
    collectionReference5 = firebaseFirestore.collection("images");
    name = TextEditingController();
    price = TextEditingController();
    type = TextEditingController();
    desc = TextEditingController();
    number = TextEditingController();
    products.bindStream(getAllProduct());
    delivery.bindStream(getAllDelivery());
    productType.bindStream(getAllProductType());
    users.bindStream(getAllUser());
    images.bindStream(getAllImages());
    // getAllType();
    super.onInit();
  }

  Stream<List<Product>> getAllProduct() => collectionReference
      .snapshots()
      .map((query) => query.docs.map((item) => Product.fromMap(item)).toList());
  Stream<List<Delivery>> getAllDelivery() =>
      collectionReference2.snapshots().map(
          (query) => query.docs.map((item) => Delivery.fromMap(item)).toList());
  Stream<List<ProductType>> getAllProductType() =>
      collectionReference3.snapshots().map((query) =>
          query.docs.map((item) => ProductType.fromMap(item)).toList());

  Stream<List<Users>> getAllUser() => collectionReference4
      .snapshots()
      .map((query) => query.docs.map((item) => Users.fromMap(item)).toList());
  Stream<List<Images>> getAllImages() => collectionReference5
      .snapshots()
      .map((query) => query.docs.map((item) => Images.fromMap(item)).toList());

  Future getAllType() async {
    types.clear();
    for (var element in productType) {
      types.add(element.type!);
      log("${element.type!}");
    }
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "please enter the filed";
    }

    return null;
  }

  void selectImage() {
    Get.defaultDialog(
        content: SizedBox(
            height: 200,
            child:
                // GridView.builder(
                // itemCount: images.length,
                // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                //     maxCrossAxisExtent: 200,
                //     childAspectRatio: 3 / 2,
                //     crossAxisSpacing: 20,
                //     mainAxisSpacing: 20),
                // itemBuilder: (BuildContext context, int index) {
                //   return
                GestureDetector(
              onTap: () {
                imageSelect();
                // selectedImage = images[index].image!;
                update(['image']);

                // Get.back();
              },
              child: CircleAvatar(
                // ignore: unnecessary_null_comparison
                backgroundImage: NetworkImage(images[0].image!),
                child: Icon(Icons.add_a_photo),
              ),
            )));
  }
  //   ),
  // ));
  // }

  void imageSelect() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage!.path.isNotEmpty) {
      image = selectedImage;
      log("message: ${image!.path}");
      update(['image']);
      update();
    }
  }

  late String image_url;
  Future uploadImageToFirebase() async {
    String fileName = basename(image!.path);

    var _imageFile = File(image!.path);

    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('myshop/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    await taskSnapshot.ref.getDownloadURL().then(
          (value) => image_url = value,
        );
  }

  addProduct() async {
    if (formKey.currentState!.validate()) {
      if (image!.path.isNotEmpty) {
        try {
          showdilog();
          await uploadImageToFirebase();
          var re = <String, dynamic>{
            "name": name.text,
            "type": type.text,
            "description": desc.text,
            "image": image_url,
            "company": company,
            "price": int.tryParse(price.text.toString()),
            "number": int.tryParse(number.text.toString()),
          };
          collectionReference.doc().set(re).whenComplete(() {
            name.clear();
            type.clear();
            desc.clear();
            price.clear();
            number.clear();
            Get.back();
            showbar("Product Added", "Product Added", "Product added", true);
          });
        } catch (e) {
          Get.back();
          showbar("Product Added", "Product Added", e.toString(), false);
        }
      } else {
        showbar("Product Added", "Product Added", 'please select image', false);
      }
    }
  }

  addProductType() async {
    if (formKey.currentState!.validate()) {
      if (image!.path.isNotEmpty) {
        showdilog();
        try {
          showdilog();
          uploadImageToFirebase();
          var re = <String, dynamic>{"type": name.text, "image": image!.name};
          collectionReference3.doc().set(re).whenComplete(() {
            name.clear();
            Get.back();
            Get.back();
            showbar(
                "Product Added", "Product  Added", "Product Type added", true);
          });
        } catch (e) {
          Get.back();
          showbar("Product Added", "Product Type Added", e.toString(), false);
        }
      } else {
        Get.back();
        showbar("Product Added", "Product Type Added", 'please select image',
            false);
      }
    }
  }

  addDelivery() {
    Get.dialog(AlertDialog(
      content: Form(
        key: formKey,
        child: CustomTextField(
            controller: name,
            input: TextInputType.text,
            validator: (val) {
              if (val!.isEmpty) {
                return "please enter filed";
              }
              return null;
            },
            lable: 'Delivery name',
            icon: const Icon(
              Icons.delivery_dining,
            )),
      ),
      actions: [
        CustomTextButton(
          ontap: () async {
            showdilog();
            if (formKey.currentState!.validate()) {
              showdilog();
              try {
                var re = <String, dynamic>{
                  "name": name.text,
                };
                collectionReference2.doc().set(re).whenComplete(() {
                  name.clear();
                  Get.back();
                  Get.back();
                  showbar("Delivery Added", "Delivery Added", "Delivery added",
                      true);
                });
              } catch (e) {
                Get.back();
                showbar(
                    "Delivery Added", "Delivery Added", e.toString(), false);
              }
            }
          },
          lable: 'Save',
          color: Colors.green,
        ),
        CustomTextButton(
          color: Colors.indigo,
          ontap: () {
            Get.back();
          },
          lable: 'Back',
        )
      ],
    ));
  }

  deleteDelivery(String id) async {
    Get.dialog(AlertDialog(
      content: const Text('Are You Sure'),
      actions: [
        CustomTextButton(
          ontap: () async {
            showdilog();
            try {
              await collectionReference2.doc(id).delete();
              update();
              Get.back();
              Get.back();
              showbar('delete', 'delete', 'Delivery deleted', true);
            } catch (e) {
              Get.back();
              Get.snackbar('error', e.toString(), backgroundColor: Colors.red);
            }
          },
          lable: 'Yes',
          color: Colors.green,
        ),
        CustomTextButton(
          color: Colors.indigo,
          ontap: () {
            Get.back();
          },
          lable: 'Back',
        )
      ],
    ));
  }

  deleteProduct(String id) async {
    Get.dialog(AlertDialog(
      content: const Text('Are You Sure'),
      actions: [
        CustomTextButton(
          ontap: () async {
            showdilog();
            try {
              await collectionReference.doc(id).delete();
              update();
              Get.back();
              Get.back();
              showbar('delete', 'delete', 'Product deleted', true);
            } catch (e) {
              Get.back();
              Get.snackbar('error', e.toString(), backgroundColor: Colors.red);
            }
          },
          lable: 'Yes',
          color: Colors.green,
        ),
        CustomTextButton(
          color: Colors.indigo,
          ontap: () {
            Get.back();
          },
          lable: 'Back',
        )
      ],
    ));
  }

  deleteUser(String id) async {
    Get.dialog(AlertDialog(
      content: const Text('Are You Sure'),
      actions: [
        CustomTextButton(
          ontap: () async {
            showdilog();
            try {
              await collectionReference4.doc(id).delete();
              update();
              Get.back();
              Get.back();
              showbar('delete', 'delete', 'User deleted', true);
            } catch (e) {
              Get.back();
              Get.snackbar('error', e.toString(), backgroundColor: Colors.red);
            }
          },
          lable: 'Yes',
          color: Colors.green,
        ),
        CustomTextButton(
          color: Colors.indigo,
          ontap: () {
            Get.back();
          },
          lable: 'Back',
        )
      ],
    ));
  }

  editProduct(String id) async {
    Get.defaultDialog(
        content: SizedBox(
      height: 200,
      child: ListView(
        children: [
          CustomTextField(
              controller: price,
              validator: (v) {
                if (v!.isEmpty) {
                  return "please add new price";
                }
                return null;
              },
              lable: 'add new price',
              icon: const Icon(Icons.numbers),
              input: TextInputType.number),
          CustomTextButton(
              lable: 'save',
              ontap: () async {
                try {
                  showdilog();
                  await collectionReference
                      .doc(id)
                      .update({"price": int.tryParse(price.text.toString())!});
                  price.clear();
                  update();
                  Get.back();
                  Get.back();
                  showbar('Edit', 'delete', 'Product Edited', true);
                } catch (e) {
                  Get.back();
                  Get.snackbar('error', e.toString(),
                      backgroundColor: Colors.red);
                }
              },
              color: Colors.green),
          CustomTextButton(
              lable: 'back',
              ontap: () {
                Get.back();
              },
              color: Colors.indigo)
        ],
      ),
    ));
  }

  editDelivery(String id) async {
    Get.defaultDialog(
        content: SizedBox(
      height: 200,
      child: ListView(
        children: [
          CustomTextField(
              controller: name,
              validator: (v) {
                if (v!.isEmpty) {
                  return "please add new name";
                }
                return null;
              },
              lable: 'add new name',
              icon: const Icon(Icons.numbers),
              input: TextInputType.number),
          CustomTextButton(
              lable: 'save',
              ontap: () async {
                try {
                  showdilog();
                  await collectionReference2
                      .doc(id)
                      .update({"name": name.text});
                  name.clear();
                  update();
                  Get.back();
                  Get.back();
                  showbar('Edit', 'delete', 'Delivery Edited', true);
                } catch (e) {
                  Get.back();
                  Get.snackbar('error', e.toString(),
                      backgroundColor: Colors.red);
                }
              },
              color: Colors.green),
          CustomTextButton(
              lable: 'back',
              ontap: () {
                Get.back();
              },
              color: Colors.indigo)
        ],
      ),
    ));
  }
}
