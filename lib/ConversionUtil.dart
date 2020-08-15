import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ConversionUtil {

  String APIENDPOINT = "https://api.ratesapi.io/api/latest";

  Future<dynamic> fetchRate(base,target) async{
    //Rates r = new Rates(base: "USD",rates: {"INR":21.123},date: "2");
    //return r;
    http.Response response = await http.get(APIENDPOINT+"?base=$base&symbols=$target");
    //print('res '+response.body);
    //print("responsecode "+response.statusCode.toString());
    if(response.statusCode.toString() == "200") {
      //print("yes");
      //print("rates "+RatesData.fromJson(json.decode(response.body),target).toString());
      //print("yes 1");
      return RatesData.fromJson(json.decode(response.body),target);
    }
    else
    {
      throw Exception("Failed to get rates");
    }
  }

  Future<String> converter(String baseIn,base,target) async{
    try {
      //print("call");
      RatesData rates = await fetchRate(base, target);
      return (double.parse(baseIn) * rates.rates.rate).toString();
    }
    catch(e) {
      return e.toString();
    }

    }

}

class RatesData {
  String base;
  Rates rates;
  String date;

  RatesData({this.base, this.rates, this.date});

  RatesData.fromJson(Map<String, dynamic> json,String w) {
    base = json['base'];
    rates = json['rates'] != null ? new Rates.fromJson(json['rates'],w) : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base'] = this.base;
    if (this.rates != null) {
      data['rates'] = this.rates.toJson();
    }
    data['date'] = this.date;
    return data;
  }
}

class Rates {
  double rate;

  Rates({this.rate});

  Rates.fromJson(Map<String, dynamic> json,String w) {
    rate = json[w];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['INR'] = this.rate;
    return data;
  }
}
