import '../../domain/home_repository.dart';
import '../datasource/home_remote_datasource.dart';
import '../model/home/home_response_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
 @override
  Stream<HomeResponseModel> getHomeData() {
    return remoteDataSource.getHomeDataStream().map((data) {
      final homeResponseModel = HomeResponseModel.fromJson(data);
      return homeResponseModel;
    });
  }
}
