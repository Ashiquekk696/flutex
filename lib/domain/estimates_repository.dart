import 'package:flutex_admin/data/model/estimate/estimate_model.dart';
import 'package:flutex_admin/data/model/estimate/estimate_post_model.dart';

abstract class EstimatesRepository {
  Stream<EstimatesModel> getEstimatesData();
    Future<void>  postEstimate(EstimatePostModel e);
}
