import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutex_admin/data/model/about/privacy_response_model.dart';
import 'package:flutex_admin/data/model/global/response_model/response_model.dart';

import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

class PrivacyController extends GetxController {
  int selectedIndex = 1;

  bool isLoading = true;

  List<PolicyPages> list = [];
  late var selectedHtml = '';
  PrivacyController();
 
     
  void changeIndex(int index) {
    selectedIndex = index;
    selectedHtml = list[index].dataValues?.details ?? '';
    update();
  }

  updateLoading(bool status) {
    isLoading = status;
    update();
  }
}
