import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CryptoUtil {

  String APIENDPOINT = "https://min-api.cryptocompare.com/data/price";
  String APIKEY = "{YOUR_APIKEY}";

  Future<dynamic> fetchRate(base,target) async{
    //Rates r = new Rates(base: "USD",rates: {"INR":21.123},date: "2");
    //return r;
    http.Response response = await http.get(APIENDPOINT+"?fsym=$base&tsyms=$target&api_key=$APIKEY");
    //print('res '+response.body);
    //print("responsecode "+response.statusCode.toString());
    if(response.statusCode.toString() == "200") {
      //print("yes");
      //print("rates "+RatesData.fromJson(json.decode(response.body),target).toString());
      //print("yes 1");
      return Rate.fromJson(json.decode(response.body),target);
    }
    else
    {
      throw Exception("Failed to get rates");
    }
  }

  Future<String> converter(String baseIn,base,target) async{
    try {
      //print("call");
      Rate rates = await fetchRate(base, target);
      return (double.parse(baseIn) * rates.rate).toString();
    }
    catch(e) {
      return e.toString();
    }

  }

}

class Rate {
  double rate;

  Rate({this.rate});

  Rate.fromJson(Map<String, dynamic> json,String target) {
    rate = json[target];
  }
}