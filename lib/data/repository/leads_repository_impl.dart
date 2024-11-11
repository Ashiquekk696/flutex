import 'package:flutex_admin/data/datasource/leads_remote_datasource.dart';
import 'package:flutex_admin/data/model/lead/sources_model.dart';
import 'package:flutex_admin/data/model/lead/statuses_model.dart';
import '../../domain/leads_repository.dart';
import '../model/lead/lead_create_model.dart';
import '../model/lead/lead_model.dart';

class LeadsRepositoryImpl implements LeadsRepository {
  final LeadsRemoteDataSource remoteDataSource;

  LeadsRepositoryImpl(this.remoteDataSource);

  @override
  Stream<LeadsModel> getLeadsData() {
    return remoteDataSource.getLeadsDataStream().map((data) {
      final leadsResponseModel = LeadsModel.fromJson(data['data']);
      return leadsResponseModel;
    });
  }

  @override
  Stream<SourcesModel> getLeadsSources() {
    return remoteDataSource.getLeadsSourcesStream().map((data) {
      final leadsResponseModel = SourcesModel.fromJson(data['data']);
      return leadsResponseModel;
    });
  }

  @override
  Stream<StatusesModel> getLeadStatuses() {
    return remoteDataSource.getLeadsStatusesStream().map((data) {
      final leadsResponseModel = StatusesModel.fromJson(data['data']);
      return leadsResponseModel;
    });
  }

  @override
  Future<void> addLeadsDataToFirestore(LeadCreateModel data) async {
    Map<String, dynamic> customerJson = data.toJson();
    await remoteDataSource.addLeadsDataToFirestore(customerJson);
  }
}
