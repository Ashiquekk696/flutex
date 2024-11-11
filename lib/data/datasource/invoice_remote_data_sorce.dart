import 'package:cloud_firestore/cloud_firestore.dart';

abstract class InvoiceRemoteDataSource {
  Stream<Map<String, dynamic>> getInvoiceDataStream();

 // Stream<Map<String, dynamic>> getInvoiceCurrencyDataStream();
}

class InvoiceRemoteDataSourceImpl implements InvoiceRemoteDataSource {
  final FirebaseFirestore firestore;

  InvoiceRemoteDataSourceImpl(this.firestore);

  @override
  Stream<Map<String, dynamic>> getInvoiceDataStream() {
    return firestore
        .collection('homeResponses')
        .doc('invoices')
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
