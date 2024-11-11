import 'package:flutex_admin/data/model/customer/customer_model.dart';
import 'package:flutex_admin/data/model/customer/customer_post_model.dart';
import 'package:flutex_admin/data/model/global/countries_model.dart';

import '../data/model/customer/groups_model.dart';

abstract class CustomerRepository {
  Stream<CustomersModel> getCustomerData();
  Stream<GroupsModel> getGroupData();
  Stream<CountriesModel> getCountriesData();
  Future<void> addCustomerDataToFirestore(CustomerPostModel customerData);
}
