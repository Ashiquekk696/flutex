
import 'package:flutex_admin/data/datasource/payment_methods_remote_datasource.dart';

import '../../domain/payment_method_repository.dart';
import '../model/global/payment_modes_model.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final PaymentMethodRemoteDataSource remoteDataSource;

  PaymentMethodRepositoryImpl(this.remoteDataSource);

 
  
  @override
  Stream<PaymentModesModel> getPaymentMethodsData() {
    return remoteDataSource.getPaymentDataStream().map((data) {
      final paymentResposResponseModel = PaymentModesModel.fromJson(data['data']); 
      return paymentResposResponseModel;
    });
  }
}
