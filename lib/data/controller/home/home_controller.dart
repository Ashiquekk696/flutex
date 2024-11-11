import 'dart:async';
import 'package:flutex_admin/core/route/route.dart';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/domain/home_repository.dart';
import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:flutex_admin/data/model/home/home_response_model.dart';
import '../../services/auth_service.dart';

class HomeController extends GetxController {
  HomeRepository homeRepo;
  HomeController({required this.homeRepo});
  late AuthService authService;
  bool isLoading = true;
  bool logoutLoading = false;
 HomeResponseModel homeModel =HomeResponseModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadData();
    isLoading = false;
    update();
  }

  Future<dynamic> loadData() async {
    isLoading = true;
    update();
    homeRepo.getHomeData().listen((homeResponseModel) {
      homeModel = homeResponseModel;
      update();
    });
    isLoading = false;
    update();
  }

  Future<void> logout() async {
    logoutLoading = true;
    update();
    await authService.signOut();
    CustomSnackBar.success(successList: [LocalStrings.logoutSuccessMsg.tr]);
    logoutLoading = false;
    update();
    Get.offAllNamed(RouteHelper.loginScreen);
  }
}
