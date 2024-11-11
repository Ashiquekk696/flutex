import 'package:flutex_admin/data/model/global/currencies_model.dart';

abstract class CurrencyRepository { 
  Stream<CurrenciesModel> getCurrencyData();
}
