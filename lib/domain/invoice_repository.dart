import 'package:flutex_admin/data/model/invoice/invoice_model.dart';
 

abstract class InvoiceRepository {
  Stream<InvoicesModel> getInvoiceData(); 
}
