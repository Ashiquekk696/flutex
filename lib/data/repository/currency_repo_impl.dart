  import 'package:flutex_admin/data/datasource/currency_remote_data_sorce.dart';

import '../../domain/currency_repository.dart';
import '../model/global/currencies_model.dart';



  
class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;

  CurrencyRepositoryImpl(this.remoteDataSource);

@override
  Stream<CurrenciesModel> getCurrencyData() {
    return remoteDataSource.getCurrencyStream().map((data) {
      final currencyResponseModel = CurrenciesModel.fromJson(data['data']);
      return currencyResponseModel;
    });
  }

  }
