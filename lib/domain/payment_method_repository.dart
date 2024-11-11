import 'package:flutex_admin/data/model/global/payment_modes_model.dart';

abstract class PaymentMethodRepository {
  Stream<PaymentModesModel> getPaymentMethodsData(); 
}
