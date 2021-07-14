import 'package:cloud/app/controller/auth.controller.dart';
import 'package:cloud/app/data/repository/AuthRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPageController extends GetxController {
  AuthController auth = Get.find();
  AuthRepository repo = AuthRepository();
  var signInLoading = false.obs;
  var signUpLoading = false.obs;

  // sign in
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> signInForm = GlobalKey();

  // sign up
  var signUpEmailController = TextEditingController();
  var signUpUsernameController = TextEditingController();
  var signUpPasswordController = TextEditingController();

  String? validateEmail(String value) {
    if (!value.isEmail)
      return 'Enter a valid email address';
    else
      return null;
  }

  signInValidation() {
    if (!emailController.text.isEmail || passwordController.text.isEmpty) {
      signInForm.currentState?.validate();

      return false;
    }
    return true;
  }

  doSignIn() {
    if (!signInValidation()) {
      return;
    }

    repo
        .signIn(emailController.text, passwordController.text)
        .then((value) => {})
        .catchError((_) {
      Get.showSnackbar(GetBar(
        duration: Duration(milliseconds: 1500),
        message: "error in sign in",
      ));
    });

    signInLoading.value = !signInLoading.value;
  }

  signUpValidation() {}

  doSignUp() {}
}
