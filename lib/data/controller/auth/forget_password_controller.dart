import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'; 
import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

class ForgetPasswordController extends GetxController {
 

  ForgetPasswordController( );

  bool submitLoading = false;
  TextEditingController emailController = TextEditingController();

  void submitForgetPassword() async {
    String email = emailController.text;

    if (email.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterEmail]);
      return;
    }


    submitLoading = false;
    update();
  }
}
