import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProposalRemoteDatasource {
  Stream<Map<String, dynamic>> getProposalDataStream();
  Future<void> addProposalsDataToFirestore(Map<String, dynamic> data);
}

class ProposalRemoteDataSourceImpl implements ProposalRemoteDatasource {
  final FirebaseFirestore firestore;

  ProposalRemoteDataSourceImpl(this.firestore);

  @override
  Stream<Map<String, dynamic>> getProposalDataStream() {
    return firestore
        .collection('homeResponses')
        .doc('proposals')
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
  Future<void> addProposalsDataToFirestore(Map<String, dynamic> data) async {
    await firestore.collection('homeResponses').doc('proposals').update({
      'data': FieldValue.arrayUnion([data])
    });
  }
}
