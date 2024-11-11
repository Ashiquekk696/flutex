import 'dart:async';
import 'dart:convert';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/data/model/authorization/authorization_response_model.dart';
import 'package:flutex_admin/data/model/customer/customer_model.dart';
import 'package:flutex_admin/data/model/estimate/estimate_details_model.dart';
import 'package:flutex_admin/data/model/estimate/estimate_item_model.dart';
import 'package:flutex_admin/data/model/estimate/estimate_model.dart';
import 'package:flutex_admin/data/model/estimate/estimate_post_model.dart';
import 'package:flutex_admin/data/model/global/currencies_model.dart';
import 'package:flutex_admin/domain/customer_repository.dart';
import 'package:flutex_admin/domain/estimates_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../domain/currency_repository.dart';

class EstimateController extends GetxController {
  EstimatesRepository estimateRepo;
   CurrencyRepository currencyRepo;
    CustomerRepository customerRepo;
  EstimateController({required this.estimateRepo,required this.currencyRepo,required this.customerRepo});

  bool isLoading = false;
  bool isSubmitLoading = false;
  EstimatesModel estimatesModel = EstimatesModel();
  EstimateDetailsModel estimateDetailsModel = EstimateDetailsModel();
  CustomersModel customersModel = CustomersModel();
  CurrenciesModel currenciesModel = CurrenciesModel();
  List<EstimateItemsModel> estimateItemList = [];

  final Map<String, String> estimateStatus = {
    '1': LocalStrings.draft.tr,
    '2': LocalStrings.sent.tr,
    '3': LocalStrings.declined.tr,
    '4': LocalStrings.accepted.tr,
    '5': LocalStrings.expired.tr,
  };

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = true;
    update();

    await loadEstimates();
    isLoading = false;
    update();
  }

  Future<void> loadEstimates() async {
    estimateRepo.getEstimatesData().listen((data) {
      estimatesModel = data;
      update();
    }); 
    isLoading = false;
    update();
  }

  Future<void> loadEstimateCreateData() async {
    isLoading = false;
    update();
    currencyRepo.getCurrencyData().listen((currenciesResponseModel) {
      currenciesModel = currenciesResponseModel;
      update();
    });
     customerRepo.getCustomerData().listen((data) {
      customersModel = data;
      update();
    });
  }

  TextEditingController numberController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController billingStreetController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  TextEditingController itemController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController clientNoteController = TextEditingController();
  TextEditingController termsController = TextEditingController();

  FocusNode numberFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode dueDateFocusNode = FocusNode();
  FocusNode billingStreetFocusNode = FocusNode();
  FocusNode clientNoteFocusNode = FocusNode();
  FocusNode termsFocusNode = FocusNode();

  FocusNode itemFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode qtyFocusNode = FocusNode();
  FocusNode unitFocusNode = FocusNode();
  FocusNode rateFocusNode = FocusNode();

  void increaseItemField() {
    estimateItemList.add(EstimateItemsModel(
      itemNameController: TextEditingController(),
      descriptionController: TextEditingController(),
      qtyController: TextEditingController(),
      unitController: TextEditingController(),
      rateController: TextEditingController(),
    ));
    update();
  }

  void decreaseItemField(int index) {
    estimateItemList.removeAt(index);
    calculateEstimateAmount();
    update();
  }

  String totalEstimateAmount = '';

  void calculateEstimateAmount() {
    double totalAmount = 0;

    double firstEstimateAmount =
        double.tryParse(rateController.text.toString()) ?? 0;
    double firstEstimateQty =
        double.tryParse(qtyController.text.toString()) ?? 0;

    totalAmount = totalAmount + (firstEstimateAmount * firstEstimateQty);

    for (var estimate in estimateItemList) {
      double estimateAmount =
          double.tryParse(estimate.rateController.text) ?? 0;
      double estimateQty = double.tryParse(estimate.qtyController.text) ?? 0;
      totalAmount = totalAmount + (estimateAmount * estimateQty);
    }

    totalEstimateAmount = totalAmount.toString();

    update();
  }

  Future<void> submitEstimate(BuildContext context) async {
    String number = numberController.text.toString();
    String client = clientController.text.toString();
    String date = dateController.text.toString();
    String dueDate = dueDateController.text.toString();
    String currency = currencyController.text.toString();
    String billingStreet = billingStreetController.text.toString();
    String status = statusController.text.toString();
    String clientNote = clientNoteController.text.toString();
    String terms = termsController.text.toString();

    if (number.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterNumber.tr]);
      return;
    }
    if (client.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.selectClient.tr]);
      return;
    }
    if (date.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.pleaseEnterDate.tr]);
      return;
    }

    String firstItemName = itemController.text.toString();
    String firstItemDescription = descriptionController.text.toString();
    String firstItemQty = qtyController.text.toString();
    String firstItemRate = rateController.text.toString();
    String firstItemUnit = unitController.text.toString();

    if (firstItemName.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterItemName.tr]);
      return;
    }
    if (firstItemQty.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterItemQty.tr]);
      return;
    }
    if (firstItemRate.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterRate.tr]);
      return;
    }

    isSubmitLoading = true;
    update();

    EstimatePostModel estimateModel = EstimatePostModel(
      clientId: client,
      number: number,
      date: date,
      duedate: dueDate,
      currency: currency,
      firstItemName: firstItemName,
      firstItemDescription: firstItemDescription,
      firstItemQty: firstItemQty,
      firstItemRate: firstItemRate,
      firstItemUnit: firstItemUnit,
      newItems: estimateItemList,
      subtotal: totalEstimateAmount,
      total: totalEstimateAmount,
      billingStreet: billingStreet,
      status: status,
      clientNote: clientNote,
      terms: terms,
    );

 
  }

  void clearData() {
    isLoading = false;
    isSubmitLoading = false;
    numberController.text = '';
    clientController.text = '';
    dateController.text = '';
    dueDateController.text = '';
    billingStreetController.text = '';
    statusController.text = '';
    currencyController.text = '';
    billingStreetController.text = '';
    clientNoteController.text = '';
    termsController.text = '';

    itemController.text = '';
    descriptionController.text = '';
    qtyController.text = '';
    unitController.text = '';
    rateController.text = '';

    estimateItemList.clear();
  }
}
