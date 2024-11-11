import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TicketsRemoteDataSource {
  Stream<Map<String, dynamic>> getTicketsDataStream();
  Stream<Map<String, dynamic>> getTicketsDepartmentStream();
  Future<void> addTicketToFirestore(Map<String, dynamic> ticketsData);
  Stream<Map<String, dynamic>> getTicketsPriorityStream();
  Stream<Map<String, dynamic>> getTicketsServicesStream();
}

class TicketRemoteDataSourceImpl implements TicketsRemoteDataSource {
  final FirebaseFirestore firestore;
  TicketRemoteDataSourceImpl(this.firestore);
  @override
  Future<void> addTicketToFirestore(Map<String, dynamic> ticketData) async {
    await firestore.collection('homeResponses').doc('tickets').set({
      'data': FieldValue.arrayUnion([ticketData])
    }, SetOptions(merge: true));
  }

  @override
  Stream<Map<String, dynamic>> getTicketsDataStream() {
    return firestore
        .collection('homeResponses')
        .doc('tickets')
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
  Stream<Map<String, dynamic>> getTicketsDepartmentStream() {
    return firestore
        .collection('homeResponses')
        .doc('departments')
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
  Stream<Map<String, dynamic>> getTicketsPriorityStream() {
    return firestore
        .collection('homeResponses')
        .doc('priorities')
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
  Stream<Map<String, dynamic>> getTicketsServicesStream() {
    return firestore
        .collection('homeResponses')
        .doc('services')
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
