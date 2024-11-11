import 'dart:async';

import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/data/model/lead/lead_create_model.dart';
import 'package:flutex_admin/data/model/lead/lead_details_model.dart';
import 'package:flutex_admin/data/model/lead/lead_model.dart';
import 'package:flutex_admin/data/model/lead/sources_model.dart';
import 'package:flutex_admin/data/model/lead/statuses_model.dart';
import 'package:flutex_admin/domain/leads_repository.dart';
import 'package:flutex_admin/domain/statuses_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

class LeadController extends GetxController {
  LeadsRepository leadRepo;
  StatusRepository statusRepository;
  LeadController({required this.leadRepo,required this.statusRepository});

  bool isLoading = false;
  bool isSubmitLoading = false;
  LeadsModel leadsModel = LeadsModel();
  LeadDetailsModel leadDetailsModel = LeadDetailsModel();

  StatusesModel statusesModel = StatusesModel();
  SourcesModel sourcesModel = SourcesModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = true;
    update();

    await loadLeads();
    isLoading = false;
    update();
  }

  Future<void> loadLeads() async { 
    leadRepo.getLeadsData().listen((data) {
      leadsModel = data;
      isLoading = false;
      update();
    });

    isLoading = false;
    update();
  }


  Future<void> loadLeadCreateData() async {
    leadRepo.getLeadsSources().listen((data) {
      sourcesModel = data;
      update();
    });
    statusRepository.getStatuses().listen((data) {
      statusesModel = data;
      update();
    });
    isLoading = false; 
  }

  TextEditingController sourceController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController assignedController = TextEditingController();
  TextEditingController clientIdController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController defaultLanguageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController customContactDateController = TextEditingController();

  TextEditingController leadValueController = TextEditingController();
  TextEditingController contactedTodayController = TextEditingController();
  TextEditingController isPublicController = TextEditingController();

  FocusNode sourceFocusNode = FocusNode();
  FocusNode statusFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode assignedFocusNode = FocusNode();
  FocusNode clientIdFocusNode = FocusNode();
  FocusNode tagsFocusNode = FocusNode();
  FocusNode contactFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode websiteFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode companyFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode defaultLanguageFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode customContactDateFocusNode = FocusNode();
  FocusNode contactedTodayFocusNode = FocusNode();
  FocusNode isPublicFocusNode = FocusNode();
  FocusNode leadValueFocusNode = FocusNode();

  Future<void> submitLead(BuildContext context) async {
    String source = sourceController.text.toString();
    String status = statusController.text.toString();
    String name = nameController.text.toString();
    String assigned = assignedController.text.toString();
    String clientId = clientIdController.text.toString();
    String tags = tagsController.text.toString();
    String contact = contactController.text.toString();
    String title = titleController.text.toString();
    String email = emailController.text.toString();
    String leadValue = leadValueController.text.toString();
    String website = websiteController.text.toString();
    String phoneNumber = phoneNumberController.text.toString();
    String company = companyController.text.toString();
    String address = addressController.text.toString();
    String city = cityController.text.toString(); 
    String country = countryController.text.toString();
    String defaultLanguage = defaultLanguageController.text.toString();
    String description = descriptionController.text.toString();
    String customContactDate = customContactDateController.text.toString();
    String contactedToday = contactedTodayController.text.toString();
    String isPublic = isPublicController.text.toString();

    if (source.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.pleaseSelectSource.tr]);
      return;
    }
    if (status.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterStatus.tr]);
      return;
    }
    if (name.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterName.tr]);
      return;
    }

    isSubmitLoading = true;
    update();

    LeadCreateModel leadModel = LeadCreateModel(
      source: source,
      status: status,
      name: name,
      assigned: assigned,
      clientId: clientId,
      tags: tags,
      contact: contact,
      title: title,
      email: email,
      website: website,
      phoneNumber: phoneNumber,
      company: company,
      address: address,
      city: city,
      leadValue: leadValue,
      country: country,
      defaultLanguage: defaultLanguage,
      description: description,
      customContactDate: customContactDate,
      contactedToday: contactedToday,
      isPublic: isPublic,
    );
    await leadRepo.addLeadsDataToFirestore(leadModel);
    leadAddeddSuccesfully();
     
    isSubmitLoading = false;
    update();
  }

  void leadAddeddSuccesfully() {
    isSubmitLoading = false;
    update();
    CustomSnackBar.success(successList: [LocalStrings.submitSuccessMsg]);
  }

  void clearData() {
    isLoading = false;
    isSubmitLoading = false;
    sourceController.text = '';
    statusController.text = '';
    nameController.text = '';
    assignedController.text = '';
    clientIdController.text = '';
    tagsController.text = '';
    contactController.text = '';
    titleController.text = '';
    emailController.text = '';
    websiteController.text = '';
    phoneNumberController.text = '';
    companyController.text = '';
    addressController.text = '';
    cityController.text = '';
    stateController.text = '';
    countryController.text = '';
    defaultLanguageController.text = '';
    descriptionController.text = '';
    customContactDateController.text = '';
    contactedTodayController.text = '';
    isPublicController.text = '';
  }
}
