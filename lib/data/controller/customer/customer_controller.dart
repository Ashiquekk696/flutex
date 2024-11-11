import 'dart:async';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/data/model/contact/contact_model.dart';
import 'package:flutex_admin/data/model/customer/customer_details.dart';
import 'package:flutex_admin/data/model/customer/customer_model.dart';
import 'package:flutex_admin/data/model/customer/customer_post_model.dart';
import 'package:flutex_admin/data/model/customer/groups_model.dart';
import 'package:flutex_admin/data/model/global/countries_model.dart';
import 'package:flutex_admin/domain/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

class CustomerController extends GetxController {
  CustomerRepository customerRepo;
  CustomerController({required this.customerRepo});

  bool isLoading = false;
  bool submitLoading = false;
  CustomersModel customersModel = CustomersModel();
  CustomerDetailsModel customerDetailsModel = CustomerDetailsModel();
  ContactsModel customerContactsModel = ContactsModel();
  GroupsModel groupsModel = GroupsModel();
  CountriesModel countriesModel = CountriesModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = true; 
    update();

    await loadCustomers(); 
    isLoading = false;
    update();
  }

  Future<void> loadCustomers() async {
    customerRepo.getCustomerData().listen((data) {
      customersModel = data;
      isLoading = false;
      update();
    }); 
  }

 

  Future<void> loadCustomerCreateData() async {
      customerRepo.getGroupData().listen((data) {
      groupsModel = data;
      update();
    });
    customerRepo.getCountriesData().listen((data) {
      countriesModel = data; 
      update();
    });
    
    isLoading = false;
    update(); 
  }

  TextEditingController companyController = TextEditingController();
  TextEditingController vatController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  TextEditingController billingStreetController = TextEditingController();
  TextEditingController billingCityController = TextEditingController();
  TextEditingController billingStateController = TextEditingController();
  TextEditingController billingZipController = TextEditingController();
  TextEditingController billingCountryController = TextEditingController();
  TextEditingController shippingStreetController = TextEditingController();
  TextEditingController shippingCityController = TextEditingController();
  TextEditingController shippingStateController = TextEditingController();
  TextEditingController shippingZipController = TextEditingController();
  TextEditingController shippingCountryController = TextEditingController();

  FocusNode companyFocusNode = FocusNode();
  FocusNode vatFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode websiteFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode groupFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  FocusNode billingStreetFocusNode = FocusNode();
  FocusNode billingCityFocusNode = FocusNode();
  FocusNode billingStateFocusNode = FocusNode();
  FocusNode billingZipFocusNode = FocusNode();
  FocusNode billingCountryFocusNode = FocusNode();
  FocusNode shippingStreetFocusNode = FocusNode();
  FocusNode shippingCityFocusNode = FocusNode();
  FocusNode shippingStateFocusNode = FocusNode();
  FocusNode shippingZipFocusNode = FocusNode();
  FocusNode shippingCountryFocusNode = FocusNode();

  Future<void> submitCustomer(BuildContext context) async {
    String company = companyController.text.toString();
    String vat = vatController.text.toString();
    String phoneNumber = phoneNumberController.text.toString();
    String website = websiteController.text.toString();
    String address = addressController.text.toString();
    String group = groupController.text.toString();
    String city = cityController.text.toString();
    String state = stateController.text.toString();
    String zip = zipController.text.toString();
    String country = countryController.text.toString();

    String billingStreet = billingStreetController.text.toString();
    String billingCity = billingCityController.text.toString();
    String billingState = billingStateController.text.toString();
    String billingZip = billingZipController.text.toString();
    String billingCountry = billingCountryController.text.toString();
    String shippingStreet = shippingStreetController.text.toString();
    String shippingCity = shippingCityController.text.toString();
    String shippingState = shippingStateController.text.toString();
    String shippingZip = shippingZipController.text.toString();
    String shippingCountry = shippingCountryController.text.toString();

   

    CustomerPostModel customerModel = CustomerPostModel(
      company: company,
      vat: vat,
      phoneNumber: phoneNumber,
      website: website,
      address: address,
      groupsIn: group,
      city: city,
      state: state,
      zip: zip,
      country: country,
      billingStreet: billingStreet,
      billingCity: billingCity,
      billingState: billingState,
      billingZip: billingZip,
      billingCountry: billingCountry,
      shippingStreet: shippingStreet,
      shippingCity: shippingCity,
      shippingState: shippingState,
      shippingZip: shippingZip,
      shippingCountry: shippingCountry,
    );
    await customerRepo.addCustomerDataToFirestore(customerModel);
    CustomSnackBar.success(successList: [LocalStrings.submitSuccessMsg]);
  
  }

 
  Future<void> loadContactCreateData() async { 
    isLoading = false;
    update();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  void clearCustomerData() {
    isLoading = false;
    submitLoading = false;
    companyController.text = '';
    vatController.text = '';
    phoneNumberController.text = '';
    websiteController.text = '';
    addressController.text = '';
    billingStreetController.text = '';
    billingCityController.text = '';
    billingStateController.text = '';
    billingZipController.text = '';
    billingCountryController.text = '';
    shippingStreetController.text = '';
    shippingCityController.text = '';
    shippingStateController.text = '';
    shippingZipController.text = '';
    shippingCountryController.text = '';
  }

  void clearData() {
    isLoading = false;
    submitLoading = false;
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    titleController.text = '';
    phoneController.text = '';
  }
}
