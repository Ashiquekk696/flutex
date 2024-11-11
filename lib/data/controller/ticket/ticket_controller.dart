import 'dart:async';
import 'dart:convert';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/data/model/authorization/authorization_response_model.dart';
import 'package:flutex_admin/data/model/contact/contact_model.dart';
import 'package:flutex_admin/data/model/customer/customer_model.dart';
import 'package:flutex_admin/data/model/ticket/departments_model.dart';
import 'package:flutex_admin/data/model/ticket/priorities_model.dart';
import 'package:flutex_admin/data/model/ticket/services_model.dart';
import 'package:flutex_admin/data/model/ticket/ticket_create_model.dart';
import 'package:flutex_admin/data/model/ticket/ticket_details_model.dart';
import 'package:flutex_admin/data/model/ticket/ticket_model.dart';
import 'package:flutex_admin/data/repo/ticket/ticket_repo.dart';
import 'package:flutex_admin/domain/ticket_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutex_admin/data/model/global/response_model/response_model.dart';
import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../domain/customer_repository.dart';

class TicketController extends GetxController {
  TicketRepository ticketRepo;
  TicketController({required this.ticketRepo, required this.customerRepo});
  CustomerRepository customerRepo;
  bool isLoading = true;
  bool isSubmitLoading = false;
  TicketsModel ticketsModel = TicketsModel();
  TicketDetailsModel ticketDetailsModel = TicketDetailsModel();
  CustomersModel customersModel = CustomersModel();
  ContactsModel contactsModel = ContactsModel();
  DepartmentModel departmentModel = DepartmentModel();
  PriorityModel priorityModel = PriorityModel();
  ServiceModel serviceModel = ServiceModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadTickets();
    isLoading = false;
    update();
  }

  Future<void> loadTickets() async {
    isLoading = true;
    ticketRepo.getTicketsData().listen((data) {
      ticketsModel = data;
      update();
    });
    ticketRepo.getTicketDepartmentsData().listen((data) {
      departmentModel = data;
      update();
    });
    ticketRepo.getTicketPriorityData().listen((data) {
      priorityModel = data;
      update();
    });
    ticketRepo.getTicketsServicesData().listen((data) {
      serviceModel = data;
      update();
    });
    isLoading = false;
    update();
  }

  TextEditingController subjectController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController statusController = TextEditingController();
  FocusNode subjectFocusNode = FocusNode();
  FocusNode departmentFocusNode = FocusNode();
  FocusNode priorityFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();
  FocusNode serviceFocusNode = FocusNode();
  FocusNode userFocusNode = FocusNode();
  FocusNode contactFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode statusFocusNode = FocusNode();

  Future<void> submitTicket(BuildContext context) async {
    String subject = subjectController.text.toString();
    String message = messageController.text.toString();
    String department = departmentController.text.toString();
    String priority = priorityController.text.toString();
    String status = statusController.text.toString();
    String service = serviceController.text.toString();
    String user = userController.text.toString();
    String contact = contactController.text.toString();
    String description = descriptionController.text.toString();

    if (subject.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterSubject.tr]);
      return;
    }
    if (user.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.pleaseSelectClient.tr]);
      return;
    }
    if (contact.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.pleaseSelectContact.tr]);
      return;
    }
    if (description.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterDescription.tr]);
      return;
    }

    isSubmitLoading = true;
    update();

    TicketCreateModel ticketModel = TicketCreateModel(
      priority_name: priority,
      message: message,
      status_name: status,
      subject: subject,
      department: department,
      userId: user,
      contactId: contact,
      priority: priority,
      service: service,
      company: user,
      description: description,
    );
    await ticketRepo.addTicket(ticketModel);
    await ticketAddedSuccesfull();

    // ResponseModel responseModel = await ticketRepo.createTicket(ticketModel);
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

  ticketAddedSuccesfull() {
    CustomSnackBar.success(successList: ["Ticket added successfully"]);
    isSubmitLoading = false;
    clearData();
    update();
  }

  Future<void> loadTicketCreateData() async {
    customerRepo.getCustomerData().listen((data) {
      customersModel = data;
      isLoading = false;
      update();
    });
    // ResponseModel customersResponseModel = await ticketRepo.getAllCustomers();
    // customersModel = CustomersModel.fromJson(
    //     jsonDecode(customersResponseModel.responseJson));

    // ResponseModel departmentsResponseModel =
    //     await ticketRepo.getTicketDepartments();
    // departmentModel = DepartmentModel.fromJson(
    //     jsonDecode(departmentsResponseModel.responseJson));

    // ResponseModel prioritiesResponseModel =
    //     await ticketRepo.getTicketPriorities();
    // priorityModel = PriorityModel.fromJson(
    //     jsonDecode(prioritiesResponseModel.responseJson));

    // ResponseModel servicesResponseModel = await ticketRepo.getTicketServices();
    // serviceModel =
    //     ServiceModel.fromJson(jsonDecode(servicesResponseModel.responseJson));
    // isLoading = false;
    // update();
  }

  Future<void> loadTicketCustomerContacts(userId) async {
    // ResponseModel contactsResponseModel =
    //     await ticketRepo.getCustomerContacts(userId);
    // contactsModel =
    //     ContactsModel.fromJson(jsonDecode(contactsResponseModel.responseJson));
    // isLoading = false;
    // update();
  }

  Future<void> loadTicketDetails(ticketId) async {
    // ResponseModel responseModel = await ticketRepo.getTicketDetails(ticketId);
    // if (responseModel.statusCode == 200) {
    //   ticketDetailsModel =
    //       TicketDetailsModel.fromJson(jsonDecode(responseModel.responseJson));
    // } else {
    //   CustomSnackBar.error(errorList: [responseModel.message]);
    // }

    // isLoading = false;
    // update();
  }

  void clearData() {
    isLoading = false;
    subjectController.text = '';
    departmentController.text = '';
    userController.text = '';
    contactController.text = '';
    messageController.clear();
    statusController.clear();
    descriptionController.text = '';
  }
}