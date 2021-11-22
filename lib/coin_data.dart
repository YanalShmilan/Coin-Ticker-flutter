import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getData(cur) async {
    var BIT = await http.get(
      Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/BTC/$cur?apikey=93A65038-3CEC-40AE-A89D-AD0033CCE5B6'),
    );
    var ETH = await http.get(
      Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/ETH/$cur?apikey=93A65038-3CEC-40AE-A89D-AD0033CCE5B6'),
    );
    var LTC = await http.get(
      Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/LTC/$cur?apikey=93A65038-3CEC-40AE-A89D-AD0033CCE5B6'),
    );

    var BTCrate = jsonDecode(BIT.body)['rate'];
    var ETHrate = jsonDecode(ETH.body)['rate'];
    var LTCrate = jsonDecode(LTC.body)['rate'];
    List<double> result = [BTCrate, ETHrate, LTCrate];
    return result;
  }
}
