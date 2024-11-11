import '../data/model/home/home_response_model.dart';

abstract class HomeRepository {
 Stream<HomeResponseModel>  getHomeData();
}
