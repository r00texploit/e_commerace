import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';
import 'custom_image.dart';

class FeatureItem extends StatelessWidget {
  FeatureItem(
      {Key? key,
      required this.data,
      this.width = 280,
      this.height = 350,
      this.onTap,
      this.onTapFavorite})
      : super(key: key);
  final dynamic data;
  final double width;
  final double height;
  final GestureTapCallback? onTapFavorite;
  final GestureTapCallback? onTap;
  MainController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              data.image,
              fit: BoxFit.contain,
              width: double.infinity,
              height: 190,
              radius: 15,
            ),
            Container(
              width: width - 20,
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.type,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xFF8A8989), fontSize: 13),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            data.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xFF8A8989), fontSize: 13),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${data.price}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xFFe6b56c),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            controller.editProduct(data.id);
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            controller.deleteProduct(data.id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // List<Color> listColors = [
  //   green,
  //   purple,
  //   yellow,
  //   orange,
  //   sky,
  //   secondary,
  //   red,
  //   blue,
  //   pink,
  //   yellow,
  // ];
}
