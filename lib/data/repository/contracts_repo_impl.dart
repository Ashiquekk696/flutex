import 'package:flutex_admin/data/datasource/contracts_remote_datasource.dart';
import 'package:flutex_admin/data/model/contract/contract_model.dart';
import '../../domain/contracts_repository.dart';
import '../model/contract/contract_post_model.dart';
 

class ContractsRepositoryImpl implements ContractsRepository {
  final ContractsRemoteDataSource remoteDataSource;

  ContractsRepositoryImpl(this.remoteDataSource);
 
 @override
  Stream<ContractsModel> getContractsData() {
    return remoteDataSource.getContractsDataStream().map((data) {
      final contractsResponseModel = ContractsModel.fromJson(data['data']);
     // Print each update
 
      return contractsResponseModel;
    });
  }

    @override
  Future<void> addContractaDataToFirestore(ContractPostModel contractModel)async {
      Map<String, dynamic> contractJson = contractModel.toJson();
    await remoteDataSource.addContractToFirestore(contractJson);
  }

}
