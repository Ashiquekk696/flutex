import 'package:flutex_admin/data/model/lead/lead_model.dart';
import 'package:flutex_admin/data/model/lead/sources_model.dart';
import 'package:flutex_admin/data/model/lead/statuses_model.dart';

import '../data/model/lead/lead_create_model.dart';

abstract class LeadsRepository {
  Stream<LeadsModel> getLeadsData();
  Stream<SourcesModel> getLeadsSources();
  Stream<StatusesModel> getLeadStatuses();
  Future<void> addLeadsDataToFirestore(LeadCreateModel data);
}
