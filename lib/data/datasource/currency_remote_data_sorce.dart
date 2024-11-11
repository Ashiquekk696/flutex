import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CurrencyRemoteDataSource { 
  Stream<Map<String, dynamic>> getInvoiceCurrencyDataStream();
}

class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  final FirebaseFirestore firestore;

  CurrencyRemoteDataSourceImpl(this.firestore);

  @override
  Stream<Map<String, dynamic>> getCurrencyStream() {
    return firestore
        .collection('homeResponses')
        .doc('currencies')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return data;
      } else {
        print('Document does not exist!');
        return {};
      }
    });
  }

  @override
  Stream<Map<String, dynamic>> getInvoiceCurrencyDataStream() {
    return firestore
        .collection('homeResponses')
        .doc('currencies')
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
