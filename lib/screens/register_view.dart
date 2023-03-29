import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/constants.dart';
import '../widgets/custom_button.dart';

import '../controller/auth_controller.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';
import 'login_view.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  final AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Get.off(LoginView());
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: controller.formKey2,
          child: ListView(
            children: [
              CustomText(
                text: "Sign Up,",
                fontSize: 30,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: controller.name,
                  validator: (validator) {
                    return controller.validate(validator!);
                  },
                  lable: 'Name',
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  input: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: controller.email,
                  validator: (validator) {
                    return controller.validateEmail(validator!);
                  },
                  lable: 'Email',
                  icon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  input: TextInputType.emailAddress),
              CustomTextField(
                  controller: controller.number,
                  validator: (validator) {
                    return controller.validateNumber(validator!);
                  },
                  lable: 'Phone Number',
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  input: TextInputType.number),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                  controller: controller.password,
                  validator: (validator) {
                    return controller.validatePassword(validator!);
                  },
                  lable: 'Password',
                  icon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  input: TextInputType.number),
              const SizedBox(
                height: 15,
              ),
              CustomTextButton(
                lable: 'SIGN Up',
                ontap: () {
                  controller.register();
                },
                color: primaryColor,
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
