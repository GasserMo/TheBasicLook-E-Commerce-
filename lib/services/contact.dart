import 'dart:convert';

import 'package:thebasiclook/constants.dart';
import 'package:http/http.dart' as http;

class Contact {
  Future<http.Response> contact(
      {required String email,
      required String name,
      required String phone,
      required String message,
      }) async {
    final url = Uri.parse(baseUrl + 'contact/');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "message": message
        }));
    
    return response;
  }
}
