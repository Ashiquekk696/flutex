import 'package:flutex_admin/data/model/customer/customer_post_model.dart';
import 'package:flutex_admin/data/model/customer/groups_model.dart';
import 'package:flutex_admin/data/model/global/countries_model.dart';

import '../../domain/customer_repository.dart';
import '../datasource/customer_remote_data_source.dart';
import '../model/customer/customer_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;

  CustomerRepositoryImpl(this.remoteDataSource);

  @override
  Stream<CustomersModel> getCustomerData() {
    return remoteDataSource.getCustomerDataStream().map((data) {
      final customerResponseModel = CustomersModel.fromJson(data['data']);
      return customerResponseModel;
    });
  }

  @override
  Stream<GroupsModel> getGroupData() {
    return remoteDataSource.getGroupsDataStream().map((data) {
      final groupsDataModel = GroupsModel.fromJson(data['data']);
      return groupsDataModel;
    });
  }

  @override
  Stream<CountriesModel> getCountriesData() {
    return remoteDataSource.getCountriesDataStream().map((data) {
      final countriesDataModel = CountriesModel.fromJson(data['data']);
      return countriesDataModel;
    });
  }

  @override
  Future<void> addCustomerDataToFirestore(
      CustomerPostModel customerData) async {
    Map<String, dynamic> customerJson = customerData.toJson();
    await remoteDataSource.addCustomerDataToFirestore(customerJson);
  }
}
