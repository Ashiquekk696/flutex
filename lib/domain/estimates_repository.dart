import 'package:flutex_admin/data/model/estimate/estimate_model.dart';

abstract class EstimatesRepository {
 Stream<EstimatesModel>  getEstimatesData();
}
