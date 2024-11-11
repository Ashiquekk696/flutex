
import 'package:flutex_admin/data/model/item/item_details_model.dart';
import 'package:flutex_admin/data/model/item/item_model.dart';
 
import 'package:get/get.dart'; 

class ItemController extends GetxController {
 
  ItemController( );

  bool isLoading = true;
  bool isSubmitLoading = false;
  ItemsModel itemsModel = ItemsModel();
  ItemDetailsModel itemDetailsModel = ItemDetailsModel();

 
 
}
