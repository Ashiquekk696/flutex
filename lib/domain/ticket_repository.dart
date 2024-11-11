import 'package:flutex_admin/data/model/ticket/departments_model.dart';
import 'package:flutex_admin/data/model/ticket/services_model.dart';
import 'package:flutex_admin/data/model/ticket/ticket_create_model.dart';
import '../data/model/ticket/priorities_model.dart';
import '../data/model/ticket/ticket_model.dart';

abstract class TicketRepository {
  Stream<TicketsModel> getTicketsData();
  Future<void> addTicket(TicketCreateModel ticketsModel);
  Stream<DepartmentModel> getTicketDepartmentsData();
  Stream<PriorityModel> getTicketPriorityData();
  Stream<ServiceModel> getTicketsServicesData();
}
