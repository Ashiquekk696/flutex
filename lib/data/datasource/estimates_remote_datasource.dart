import 'package:cloud_firestore/cloud_firestore.dart';

abstract class EstimatesRemoteDataSource {
  Stream<Map<String, dynamic>> getEstimatesDataStream();
  Future<void> addEstimatesToFirestore(Map<String, dynamic> data) ;
}

class EstimatesRemoteDataSourceImpl implements EstimatesRemoteDataSource {
  final FirebaseFirestore firestore;

  EstimatesRemoteDataSourceImpl(this.firestore);

  @override
  Stream<Map<String, dynamic>> getEstimatesDataStream() {
    
    return firestore
        .collection('homeResponses')
        .doc('estimates')
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
  Future<void> addEstimatesToFirestore(Map<String, dynamic> data) async {
    await firestore.collection('homeResponses').doc('estimates').update({
      'data': FieldValue.arrayUnion([data])
    });
  }
}
