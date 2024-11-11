 
import 'package:flutex_admin/data/datasource/proposal_remote_datasource.dart';
import 'package:flutex_admin/data/model/proposal/proposal_model.dart';
import 'package:flutex_admin/data/model/proposal/proposal_post_model.dart';
import 'package:flutex_admin/domain/proposals_repository.dart';
 

class PropsalRepositoryImpl implements ProposalsRepository {
  final ProposalRemoteDatasource remoteDataSource;

  PropsalRepositoryImpl(this.remoteDataSource);
 
 @override
  Stream<ProposalsModel> getPropsalsData() {
    return remoteDataSource.getProposalDataStream().map((data) {
      final responseModel = ProposalsModel.fromJson(data['data']);
      return responseModel;
    });
  }
    @override
  Future<void> addProposalsDataToFirestore(ProposalPostModel data) async {
    Map<String, dynamic> jsonData = data.toJson();
    await remoteDataSource.addProposalsDataToFirestore(jsonData);
  }
}
