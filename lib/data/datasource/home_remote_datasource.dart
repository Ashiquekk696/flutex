import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeRemoteDataSource {
  Stream<Map<String, dynamic>> getHomeDataStream();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSourceImpl(this.firestore);

  @override
  Stream<Map<String, dynamic>> getHomeDataStream() {
    
    return firestore
        .collection('homeResponses')
        .doc('homeResponse')
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
