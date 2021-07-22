import 'package:cloud/app/controllers/auth.controller.dart';
import 'package:cloud/app/data/services/auth.dart';
import 'package:cloud/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPageController extends GetxController {
  AuthController auth = Get.find();
  AuthService repo = AuthService();
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
    signInLoading.value = true;

    repo.signIn(emailController.text, passwordController.text).then((res) {
      if (isSuccess(res)) {}

      signInLoading.value = false;
    }).catchError((_) {
      signInLoading.value = false;
    });
  }

  signUpValidation() {}

  doSignUp() {}
}
