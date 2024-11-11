import 'package:cloud_firestore/cloud_firestore.dart';

abstract class StatusRemoteDataSource {
  Stream<Map<String, dynamic>> getStatusesStream(); 
}

class StatusesRemoteDataSourceImpl implements StatusRemoteDataSource {
  final FirebaseFirestore firestore;

  StatusesRemoteDataSourceImpl(this.firestore);

 
 
  @override
  Stream<Map<String, dynamic>> getStatusesStream() {
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

 