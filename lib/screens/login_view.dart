import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_button.dart';

import '../controller/auth_controller.dart';
import '../widgets/constants.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.find();

  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Welcome,",
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Sign in to Continue',
                fontSize: 14,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 30,
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
              const SizedBox(
                height: 40,
              ),
              CustomTextField(
                  controller: controller.password,
                  validator: (value) {
                    return controller.validatePassword(value!);
                  },
                  lable: 'Password',
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  input: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextButton(
                ontap: () {
                  controller.login();
                },
                lable: 'SIGN IN',
                color: primaryColor,
              ),
              const SizedBox(
                height: 40,
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
