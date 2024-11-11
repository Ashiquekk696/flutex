import 'dart:async';
import 'dart:convert';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/data/model/authorization/authorization_response_model.dart';
import 'package:flutex_admin/data/model/customer/customer_model.dart';
import 'package:flutex_admin/data/model/global/currencies_model.dart';
import 'package:flutex_admin/data/model/proposal/proposal_details_model.dart';
import 'package:flutex_admin/data/model/proposal/proposal_item_model.dart';
import 'package:flutex_admin/data/model/proposal/proposal_model.dart';
import 'package:flutex_admin/data/model/proposal/proposal_post_model.dart';
import 'package:flutex_admin/data/repo/proposal/proposal_repo.dart';
import 'package:flutex_admin/domain/currency_repository.dart';
import 'package:flutex_admin/domain/customer_repository.dart';
import 'package:flutex_admin/domain/proposals_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutex_admin/data/model/global/response_model/response_model.dart';
import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

class ProposalController extends GetxController {
  ProposalsRepository proposalRepo;
  CustomerRepository customerRepo;
  ProposalController(
      {required this.proposalRepo,
      required this.customerRepo,
      required this.currencyRepo});

  CurrencyRepository currencyRepo;
  bool isLoading = false;
  bool isSubmitLoading = false;
  ProposalsModel proposalsModel = ProposalsModel();
  ProposalDetailsModel proposalDetailsModel = ProposalDetailsModel();
  CustomersModel customersModel = CustomersModel();
  CurrenciesModel currenciesModel = CurrenciesModel();
  List<ProposalItemModel> proposalItemList = [];

  final Map<String, String> proposalStatus = {
    '1': LocalStrings.open.tr,
    '2': LocalStrings.declined.tr,
    '3': LocalStrings.accepted.tr,
    '4': LocalStrings.sent.tr,
    '5': LocalStrings.revised.tr,
    '6': LocalStrings.draft.tr,
  };

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = true;
    update();

    await loadProposals();
    isLoading = false;
    update();
  }

  Future<void> loadProposals() async {
    proposalRepo.getPropsalsData().listen((data) {
      proposalsModel = data;
      update();
    });
    // ResponseModel responseModel = await proposalRepo.getAllProposals();
    // proposalsModel =
    //     ProposalsModel.fromJson(jsonDecode(responseModel.responseJson));
    // isLoading = false;
    // update();
  }

  Future<void> loadProposalDetails(proposalId) async {
    // ResponseModel responseModel =
    //     await proposalRepo.getProposalDetails(proposalId);
    // if (responseModel.statusCode == 200) {
    //   proposalDetailsModel =
    //       ProposalDetailsModel.fromJson(jsonDecode(responseModel.responseJson));
    // } else {
    //   CustomSnackBar.error(errorList: [responseModel.message]);
    // }

    // isLoading = false;
    // update();
  }

  Future<void> loadProposalCreateData() async {
    currencyRepo.getCurrencyData().listen((currenciesResponseModel) {
      currenciesModel = currenciesResponseModel;
      update();
    });
    customerRepo.getCustomerData().listen((data) {
      customersModel = data;
      isLoading = false;
      update();
    });
    // ResponseModel customersResponseModel = await proposalRepo.getAllCustomers();
    // customersModel = CustomersModel.fromJson(
    //     jsonDecode(customersResponseModel.responseJson));
    // ResponseModel currenciesResponseModel = await proposalRepo.getCurrencies();
    // currenciesModel = CurrenciesModel.fromJson(
    //     jsonDecode(currenciesResponseModel.responseJson));
    // isLoading = false;
    // update();
  }

  TextEditingController subjectController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientEmailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController openTillController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  TextEditingController itemController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  FocusNode subjectFocusNode = FocusNode();
  FocusNode clientNameFocusNode = FocusNode();
  FocusNode clientEmailFocusNode = FocusNode();
  FocusNode clientFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode openTillFocusNode = FocusNode();

  FocusNode itemFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode qtyFocusNode = FocusNode();
  FocusNode unitFocusNode = FocusNode();
  FocusNode rateFocusNode = FocusNode();

  void increaseItemField() {
    proposalItemList.add(ProposalItemModel(
      itemNameController: TextEditingController(),
      descriptionController: TextEditingController(),
      qtyController: TextEditingController(),
      unitController: TextEditingController(),
      rateController: TextEditingController(),
    ));
    update();
  }

  void decreaseItemField(int index) {
    proposalItemList.removeAt(index);
    calculateProposalAmount();
    update();
  }

  String totalProposalAmount = '';

  void calculateProposalAmount() {
    double totalAmount = 0;

    double firstProposalAmount =
        double.tryParse(rateController.text.toString()) ?? 0;
    double firstProposalQty =
        double.tryParse(qtyController.text.toString()) ?? 0;

    totalAmount = totalAmount + (firstProposalAmount * firstProposalQty);

    for (var proposal in proposalItemList) {
      double proposalAmount =
          double.tryParse(proposal.rateController.text) ?? 0;
      double proposalQty = double.tryParse(proposal.qtyController.text) ?? 0;
      totalAmount = totalAmount + (proposalAmount * proposalQty);
    }

    totalProposalAmount = totalAmount.toString();

    update();
  }

  Future<void> submitProposal(BuildContext context) async {
    String subject = subjectController.text.toString();
    String client = clientController.text.toString();
    String clientName = clientNameController.text.toString();
    String clientEmail = clientEmailController.text.toString();
    String date = dateController.text.toString();
    String openTill = openTillController.text.toString();
    String currency = currencyController.text.toString();
    String status = statusController.text.toString();

    if (subject.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterSubject.tr]);
      return;
    }

    if (clientName.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterName.tr]);
      return;
    }

    if (clientEmail.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterEmail.tr]);
      return;
    }

    if (client.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.selectClient.tr]);
      return;
    }

    if (date.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterStartDate.tr]);
      return;
    }

    if (status.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.selectStatus.tr]);
      return;
    }

    if (currency.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.selectCurrency.tr]);
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

    ProposalPostModel proposalModel = ProposalPostModel(
      subject: subject,
      related: 'customer',
      relId: client,
      proposalTo: clientName,
      email: clientEmail,
      date: date,
      openTill: openTill,
      status: status,
      currency: currency,
      firstItemName: firstItemName,
      firstItemDescription: firstItemDescription,
      firstItemQty: firstItemQty,
      firstItemRate: firstItemRate,
      firstItemUnit: firstItemUnit,
      newItems: proposalItemList,
      subtotal: totalProposalAmount,
      total: totalProposalAmount,
    );

    await proposalRepo.addProposalsDataToFirestore(proposalModel);
    submittedSuccessful();
  
  }

  void submittedSuccessful() {
    CustomSnackBar.success(successList: ["Customer Added successfully"]);
    isSubmitLoading = false;
    update();
  }

  void clearData() {
    isLoading = false;
    isSubmitLoading = false;
    subjectController.text = '';
    clientNameController.text = '';
    clientEmailController.text = '';
    clientController.text = '';
    dateController.text = '';
    openTillController.text = '';
    statusController.text = '';
    currencyController.text = '';

    itemController.text = '';
    descriptionController.text = '';
    qtyController.text = '';
    unitController.text = '';
    rateController.text = '';

    proposalItemList.clear();
  }
}
