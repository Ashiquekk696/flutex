import 'package:flutex_admin/data/datasource/estimates_remote_datasource.dart';
import 'package:flutex_admin/data/model/estimate/estimate_model.dart';
import '../../domain/estimates_repository.dart';
class EstimatesRepositoryImpl implements EstimatesRepository {
  final EstimatesRemoteDataSource remoteDataSource;

  EstimatesRepositoryImpl(this.remoteDataSource);
 
 @override
  Stream<EstimatesModel> getEstimatesData() {
    return remoteDataSource.getEstimatesDataStream().map((data) {
      final responseModel = EstimatesModel.fromJson(data['data']);
      return responseModel;
    });
  }
}
