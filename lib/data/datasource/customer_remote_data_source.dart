import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CustomerRemoteDataSource {
  Stream<Map<String, dynamic>> getCustomerDataStream();
  Stream<Map<String, dynamic>> getGroupsDataStream();
  Stream<Map<String, dynamic>> getCountriesDataStream();
  Future<void> addCustomerDataToFirestore( Map<String, dynamic> customerData);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final FirebaseFirestore firestore;

  CustomerRemoteDataSourceImpl(this.firestore);

  @override
  Stream<Map<String, dynamic>> getCustomerDataStream() {
    return firestore
        .collection('homeResponses')
        .doc('customerList')
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
  Stream<Map<String, dynamic>> getGroupsDataStream() {
    return firestore
        .collection('homeResponses')
        .doc('groups')
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
  Stream<Map<String, dynamic>> getCountriesDataStream() {
    return firestore
        .collection('homeResponses')
        .doc('countries')
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
  Future<void> addCustomerDataToFirestore(
      Map<String, dynamic> customerData) async {
    await firestore.collection('homeResponses').doc('customerList').update({
      'data': FieldValue.arrayUnion([customerData])  
    });
 
  }
}
