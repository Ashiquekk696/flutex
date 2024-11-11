import 'package:flutex_admin/data/datasource/tickets_remote_datasource.dart';
import 'package:flutex_admin/data/model/ticket/departments_model.dart';
import 'package:flutex_admin/data/model/ticket/priorities_model.dart';
import 'package:flutex_admin/data/model/ticket/services_model.dart';
import 'package:flutex_admin/data/model/ticket/ticket_model.dart';

import '../../domain/ticket_repository.dart';
import '../model/ticket/ticket_create_model.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketsRemoteDataSource remoteDataSource;

  TicketRepositoryImpl(this.remoteDataSource);
 
  @override
  Stream<TicketsModel> getTicketsData() {
    return remoteDataSource.getTicketsDataStream().map((data) {
      final ticketsResponseModel = TicketsModel.fromJson(data['data']);
      return ticketsResponseModel;
    });
  }
   @override
  Stream<DepartmentModel> getTicketDepartmentsData() {
    return remoteDataSource.getTicketsDepartmentStream().map((data) {
      final departmentResponseModel = DepartmentModel.fromJson(data['data']);
      return departmentResponseModel;
    });
  } 
  @override
  Future<void> addTicket(TicketCreateModel ticketsModel) async {
    Map<String, dynamic> ticketsJson = ticketsModel.toJson();
    await remoteDataSource.addTicketToFirestore(ticketsJson);
  }

  @override
  Stream<PriorityModel> getTicketPriorityData() { 
  return remoteDataSource.getTicketsPriorityStream().map((data) {
      final priorityResponseModel = PriorityModel.fromJson(data['data']);
      return priorityResponseModel;
    });
  }
    @override
  Stream<ServiceModel> getTicketsServicesData() { 
  return remoteDataSource.getTicketsServicesStream().map((data) {
      final serviceResponseModel = ServiceModel.fromJson(data['data']);
      return serviceResponseModel;
    });
  }
}
