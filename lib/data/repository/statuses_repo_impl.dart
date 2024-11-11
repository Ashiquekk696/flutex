
import 'package:flutex_admin/data/datasource/statuses_remote_datasource.dart';
import 'package:flutex_admin/data/model/lead/statuses_model.dart';
import 'package:flutex_admin/domain/statuses_repository.dart';

class StatusRepositoryImpl implements StatusRepository {
  final StatusRemoteDataSource remoteDataSource;

  StatusRepositoryImpl(this.remoteDataSource);

  @override
  Stream<StatusesModel> getStatuses() {
    return remoteDataSource.getStatusesStream().map((data) {
      final responseModel = StatusesModel.fromJson(data['data']);
      return responseModel;
    });
  }

  

 
 
}
