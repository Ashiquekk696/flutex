import 'package:flutex_admin/data/model/contract/contract_model.dart';

import '../data/model/contract/contract_post_model.dart';

abstract class ContractsRepository {
  Stream<ContractsModel> getContractsData();
  Future<void> addContractaDataToFirestore(ContractPostModel contractModel);
}
