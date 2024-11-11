import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutex_admin/data/controller/customer/customer_controller.dart';
import 'package:flutex_admin/data/controller/localization/localization_controller.dart';
import 'package:flutex_admin/data/datasource/contracts_remote_datasource.dart';
import 'package:flutex_admin/data/datasource/currency_remote_data_sorce.dart';
import 'package:flutex_admin/data/datasource/estimates_remote_datasource.dart';
import 'package:flutex_admin/data/datasource/invoice_remote_data_sorce.dart';
import 'package:flutex_admin/data/datasource/leads_remote_datasource.dart';
import 'package:flutex_admin/data/datasource/payment_methods_remote_datasource.dart';
import 'package:flutex_admin/data/datasource/project_remote_datsource.dart';
import 'package:flutex_admin/data/datasource/proposal_remote_datasource.dart';
import 'package:flutex_admin/data/datasource/statuses_remote_datasource.dart';
import 'package:flutex_admin/data/datasource/tickets_remote_datasource.dart';
import 'package:flutex_admin/data/repo/splash/splash_repo.dart';
import 'package:flutex_admin/data/repository/contracts_repo_impl.dart';
import 'package:flutex_admin/data/repository/customer_repo_impl.dart';
import 'package:flutex_admin/data/repository/estimates_repo_impl.dart';
import 'package:flutex_admin/data/repository/invoice_repo_impl.dart';
import 'package:flutex_admin/data/repository/leads_repository_impl.dart';
import 'package:flutex_admin/data/repository/payment_method_repository_impl.dart';
import 'package:flutex_admin/data/repository/project_repository_impl.dart';
import 'package:flutex_admin/data/repository/propsal_repo_Impl.dart';
import 'package:flutex_admin/data/repository/statuses_repo_impl.dart';
import 'package:flutex_admin/data/repository/ticket_repository_impl.dart';
import 'package:flutex_admin/domain/contracts_repository.dart';
import 'package:flutex_admin/domain/currency_repository.dart';
import 'package:flutex_admin/domain/customer_repository.dart';
import 'package:flutex_admin/domain/estimates_repository.dart';
import 'package:flutex_admin/domain/invoice_repository.dart';
import 'package:flutex_admin/domain/leads_repository.dart';
import 'package:flutex_admin/domain/proposals_repository.dart';
import 'package:flutex_admin/domain/statuses_repository.dart';
import 'package:flutex_admin/domain/ticket_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutex_admin/data/controller/common/theme_controller.dart';
import 'package:flutex_admin/data/controller/splash/splash_controller.dart';
import 'package:flutex_admin/data/services/api_service.dart';

import '../../data/datasource/customer_remote_data_source.dart';
import '../../data/datasource/home_remote_datasource.dart';
import '../../data/repository/currency_repo_impl.dart';
import '../../data/repository/home_repo_impl.dart';
import '../../domain/home_repository.dart';
import '../../domain/payment_method_repository.dart';
import '../../domain/project_repository.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(
      apiClient: Get.find(), localizationController: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));

  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));

  Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance);
  Get.lazyPut<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(Get.find()));

  Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(Get.find()));

  Get.lazyPut<CustomerRemoteDataSource>(
      () => CustomerRemoteDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<CustomerRepository>(() => CustomerRepositoryImpl(Get.find()),
      fenix: true);

  Get.lazyPut<ProjectRemoteDataSource>(
      () => ProjectRemoteDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<ProjectRepository>(() => ProjectRepositoryImpl(Get.find()),
      fenix: true);
 
  Get.lazyPut<InvoiceRemoteDataSource>(
      () => InvoiceRemoteDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<InvoiceRepository>(() => InvoiceRepositoryImpl(Get.find()),
      fenix: true);

        Get.lazyPut<PaymentMethodRemoteDataSource>(
      () => PaymentMethodRemoteDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<PaymentMethodRepository>(() => PaymentMethodRepositoryImpl(Get.find()),
      fenix: true);

        Get.lazyPut<ContractsRemoteDataSource>(
      () => ContractsRemoteDatasourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<ContractsRepository>(() => ContractsRepositoryImpl(Get.find()),
      fenix: true);

  Get.lazyPut<TicketsRemoteDataSource>(
      () => TicketRemoteDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<TicketRepository>(() => TicketRepositoryImpl(Get.find()),
      fenix: true);

Get.lazyPut<LeadsRemoteDataSource>(
      () => LeadsRemoteDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<LeadsRepository>(() => LeadsRepositoryImpl(Get.find()),
      fenix: true);
      Get.lazyPut<CurrencyRemoteDataSource>(
      () => CurrencyRemoteDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<CurrencyRepository>(() => CurrencyRepositoryImpl(Get.find()),
      fenix: true);
      Get.lazyPut<EstimatesRemoteDataSource>(
      () => EstimatesRemoteDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<EstimatesRepository>(() => EstimatesRepositoryImpl(Get.find()),
      fenix: true);

         Get.lazyPut<StatusRemoteDataSource>(
      () => StatusesRemoteDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<StatusRepository>(() => StatusRepositoryImpl(Get.find()),
      fenix: true);

          Get.lazyPut<ProposalRemoteDatasource>(
      () => ProposalRemoteDataSourceImpl(Get.find()),
      fenix: true);
      Get.lazyPut<ProposalsRepository>(() =>  PropsalRepositoryImpl(Get.find()),
      fenix: true);

  Map<String, Map<String, String>> language = {};
  language['en_US'] = {'': ''};

  return language;
}
