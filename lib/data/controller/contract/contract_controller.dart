import 'dart:async';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/data/model/contract/contract_details_model.dart';
import 'package:flutex_admin/data/model/contract/contract_model.dart';
import 'package:flutex_admin/data/model/contract/contract_post_model.dart';
import 'package:flutex_admin/data/model/customer/customer_model.dart';
import 'package:flutex_admin/domain/contracts_repository.dart';
import 'package:flutex_admin/domain/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

class ContractController extends GetxController {
  ContractsRepository contractRepo;
  ContractController({required this.contractRepo, required this.customerRepo});
  CustomerRepository customerRepo;
  bool isLoading = false;
  bool isSubmitLoading = false;
  ContractsModel contractsModel = ContractsModel();
  ContractDetailsModel contractDetailsModel = ContractDetailsModel();
  CustomersModel customersModel = CustomersModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = true;
    update();

    await loadContracts();
    isLoading = false;
    update();
  }

  Future<void> loadContracts() async {
    isLoading = true;
    contractRepo.getContractsData().listen((data) {
      contractsModel = data;
      update();
    });
    customerRepo.getCustomerData().listen((data) {
      customersModel = data;
      update();
    });
    isLoading = false;
 
  }
 

  Future<void> loadContractCreateData() async {
    // ResponseModel customersResponseModel = await contractRepo.getAllCustomers();
    // customersModel = CustomersModel.fromJson(
    //     jsonDecode(customersResponseModel.responseJson));
    // isLoading = false;
    // update();
  }

  TextEditingController subjectController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController dateStartController = TextEditingController();
  TextEditingController dateEndController = TextEditingController();
  TextEditingController contractValueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode subjectFocusNode = FocusNode();
  FocusNode clientFocusNode = FocusNode();
  FocusNode dateStartFocusNode = FocusNode();
  FocusNode dateEndFocusNode = FocusNode();
  FocusNode contractValueFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  Future<void> submitContract(BuildContext context) async {
    String subject = subjectController.text.toString();
    String client = clientController.text.toString();
    String dateStart = dateStartController.text.toString();
    String dateEnd = dateEndController.text.toString();
    String contractValue = contractValueController.text.toString();
    String description = descriptionController.text.toString();
    String content = contentController.text.toString();

    if (subject.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterSubject]);
      return;
    }
    if (dateStart.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterStartDate]);
      return;
    }
    if (client.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.client]);
      return;
    }

    // isSubmitLoading = true;
    // update();

    ContractPostModel contractModel = ContractPostModel(
      subject: subject,
      client: client,
      startDate: dateStart,
      endDate: dateEnd,
      dateadded: dateStart,
      contractValue: contractValue,
      description: description,
      content: content,
    );
    await contractRepo.addContractaDataToFirestore(contractModel);
    CustomSnackBar.success(successList: ["Contract added successfully"]);
    // ResponseModel responseModel =
    //     await contractRepo.createContract(contractModel);
    // if (responseModel.statusCode == 200) {
    //   AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
    //       jsonDecode(responseModel.responseJson));
    //   if (model.status!) {
    //     if (context.mounted) Navigator.pop(context);
    //     await initialData();
    //     CustomSnackBar.success(successList: [model.message!]);
    //   } else {
    //     CustomSnackBar.error(errorList: [model.message!]);
    //   }
    // } else {
    //   CustomSnackBar.error(errorList: [responseModel.message]);
    //   return;
    // }

    // isSubmitLoading = false;
    // update();
  }

  void clearData() {
    isLoading = false;
    subjectController.text = '';
    clientController.text = '';
    dateStartController.text = '';
    dateEndController.text = '';
    contractValueController.text = '';
    descriptionController.text = '';
    contentController.text = '';
  }
}
