import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thebasiclook/constants.dart';
import 'package:http/http.dart' as http;

abstract class PaymentManager {
  static Future<void> makePayment(int amount, String currency) async {
    try {
      String clientSecret =
          await _getClientSecret((amount * 100).toString(), currency);

      await initialize(clientSecret);
      await Stripe.instance.presentPaymentSheet();
      PaymentIntent paymentSucc = await Stripe.instance
          .confirmPayment(paymentIntentClientSecret: clientSecret);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> initialize(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'gasser'));
  }

  
  static Future<String> _getClientSecret(String amount, String currency) async {
    var response = await http
        .post(Uri.parse('https://api.stripe.com/v1/payment_intents'), headers: {
      'Authorization': 'Bearer $secretKey',
      "Content-Type": "application/x-www-form-urlencoded",
    }, body: {
      'amount': amount,
      'currency': currency
    });
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse['client_secret'];
    } else {
      throw Exception('Failed to load client secret');
    }
  }
}
  /* Future<void> checkout(
      {required String token, required String sessionId}) async {
    final url = Uri.parse(baseUrl + 'orders/');

    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
       "Content-Type": "application/json",
    }, body: {
      'sessionId': sessionId
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  } */

