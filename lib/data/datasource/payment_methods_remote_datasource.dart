import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PaymentMethodRemoteDataSource {
  Stream<Map<String, dynamic>> getPaymentDataStream();
}

class PaymentMethodRemoteDataSourceImpl implements PaymentMethodRemoteDataSource {
  final FirebaseFirestore firestore;

  PaymentMethodRemoteDataSourceImpl(this.firestore);

  @override
  Stream<Map<String, dynamic>> getPaymentDataStream() {
    
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
