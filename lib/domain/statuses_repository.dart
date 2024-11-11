import '../data/model/lead/statuses_model.dart';

abstract class StatusRepository { 
  Stream<StatusesModel> getStatuses(); 
}
