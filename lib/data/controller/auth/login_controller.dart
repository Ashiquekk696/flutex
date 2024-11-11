import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutex_admin/core/route/route.dart';
import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

import '../../services/auth_service.dart';

class LoginController extends GetxController {

  final AuthService authService;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  User? user;
  TextEditingController emailController =
      TextEditingController(text: 'admin@demo.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');

  List<String> errors = [];
  String? email;
  String? password;
  bool remember = false;

  LoginController({ required this.authService});
 
  bool isSubmitLoading = false;

  void loginUser() async {
    isSubmitLoading = true;
    update();
    user =
        await authService.signIn(emailController.text, passwordController.text);
    if (user != null) {
      Get.offAndToNamed(RouteHelper.dashboardScreen);
    } else {
      CustomSnackBar.error(errorList: ["User Not found"]);
    }
    isSubmitLoading = false;
    update();
  }
 
  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearTextField() {
    passwordController.text = '';
    emailController.text = '';
    if (remember) {
      remember = false;
    }
    update();
  }
}
