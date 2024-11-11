import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ContractsRemoteDataSource {
  Stream<Map<String, dynamic>> getContractsDataStream();
  Future<void> addContractToFirestore(Map<String, dynamic> customerData);
}

class ContractsRemoteDatasourceImpl implements ContractsRemoteDataSource {
  final FirebaseFirestore firestore;

  ContractsRemoteDatasourceImpl(this.firestore);

  @override
  Stream<Map<String, dynamic>> getContractsDataStream() {
    return firestore
        .collection('homeResponses')
        .doc('contracts')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return data;
      } else {
        return {};
      }
    });
  }

  @override
  Future<void> addContractToFirestore(Map<String, dynamic> customerData) async {
    await firestore.collection('homeResponses').doc('contracts').update({
      'data': FieldValue.arrayUnion([customerData])
    });
  }
}
