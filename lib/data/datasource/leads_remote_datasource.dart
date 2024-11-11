import 'package:cloud_firestore/cloud_firestore.dart';

abstract class LeadsRemoteDataSource {
  Stream<Map<String, dynamic>> getLeadsDataStream();
  Stream<Map<String, dynamic>> getLeadsSourcesStream();
  Stream<Map<String, dynamic>> getLeadsStatusesStream();
  Future<void> addLeadsDataToFirestore(Map<String, dynamic> data);
}

class LeadsRemoteDataSourceImpl implements LeadsRemoteDataSource {
  final FirebaseFirestore firestore;

  LeadsRemoteDataSourceImpl(this.firestore);

  @override
  Stream<Map<String, dynamic>> getLeadsDataStream() {
    return firestore
        .collection('homeResponses')
        .doc('leads')
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
  Future<void> addLeadsDataToFirestore(
      Map<String, dynamic> customerData) async {
    await firestore.collection('homeResponses').doc('leads').update({
      'data': FieldValue.arrayUnion([customerData])
    });
  }

  @override
  Stream<Map<String, dynamic>> getLeadsSourcesStream() {
    return firestore
        .collection('homeResponses')
        .doc('sources')
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
  Stream<Map<String, dynamic>> getLeadsStatusesStream() {
    return firestore
        .collection('homeResponses')
        .doc('statuses')
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
}
