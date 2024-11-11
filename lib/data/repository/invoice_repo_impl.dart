import 'package:flutex_admin/data/datasource/invoice_remote_data_sorce.dart'; 
import 'package:flutex_admin/domain/invoice_repository.dart'; 
import '../model/invoice/invoice_model.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceRemoteDataSource remoteDataSource;

  InvoiceRepositoryImpl(this.remoteDataSource);

  @override
  Stream<InvoicesModel> getInvoiceData() {
    return remoteDataSource.getInvoiceDataStream().map((data) {
      final invoiceResponseModel = InvoicesModel.fromJson(data['data']);
      return invoiceResponseModel;
    });
  }

}
