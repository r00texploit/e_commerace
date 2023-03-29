import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../controller/main_controller.dart';
import '../screens/add_product.dart';
import '../screens/add_product_type.dart';
import '../screens/product_page.dart';
import 'package:simple_list_tile/simple_list_tile.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              GetBuilder<MainController>(
                builder: (logic) {
                  return SimpleListTile(
                    onTap: () {
                      Get.to(const AddProductType());
                    },
                    title: const Text(
                      'Add product type',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    leading: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    tileColor: Color(0xFFF67952),
                    circleColor: Color(0xFFF67952),
                    circleDiameter: 200,
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.indigo],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              SimpleListTile(
                onTap: () {
                  Get.to(AllProduct());
                },
                title: const Text(
                  'Show all product',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
                leading: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
                tileColor: Color(0xFFF67952),
                circleColor: Color(0xFFF67952),
                circleDiameter: 200,
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.indigo],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GetBuilder<MainController>(
                builder: (logic) {
                  return SimpleListTile(
                    onTap: () async {
                      await logic.getAllType();
                      Get.to(AddProduct());
                    },
                    title: const Text(
                      'add new product',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    leading: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    tileColor: Color(0xFFF67952),
                    circleColor: Color(0xFFF67952),
                    circleDiameter: 200,
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.indigo],
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
