import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProjectRemoteDataSource {
  Stream<Map<String, dynamic>> getProjectDataStream();

  Future<void> addProjectToFirestore(Map<String, dynamic> customerData);
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final FirebaseFirestore firestore;

  ProjectRemoteDataSourceImpl(this.firestore);

  @override
  Stream<Map<String, dynamic>> getProjectDataStream() {
    return firestore
        .collection('homeResponses')
        .doc('projects')
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
  Future<void> addProjectToFirestore(Map<String, dynamic> customerData) async {
    await firestore.collection('homeResponses').doc('projects').set({
      'data': FieldValue.arrayUnion([customerData])
    }, SetOptions(merge: true));
  }
}
