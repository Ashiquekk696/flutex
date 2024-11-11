import 'package:flutex_admin/data/model/proposal/proposal_model.dart';
import 'package:flutex_admin/data/model/proposal/proposal_post_model.dart';

abstract class ProposalsRepository {
  Stream<ProposalsModel> getPropsalsData();
  Future<void> addProposalsDataToFirestore(ProposalPostModel data);
}
