import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:thebasiclook/constants.dart';
import 'package:thebasiclook/services/savingUserData.dart';

class Auth {
  Future<http.Response> Login(
      {required String email, required String password}) async {
    final url = Uri.parse(baseUrl + 'auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return response;
  }

 

  Future<http.Response> Register(
      {required String name,
      required String email,
      required String password}) async {
    final url = Uri.parse(baseUrl + 'auth/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
  
    return response;
  }
}
 Future<void> signOut() async {
    // Clear the stored user data, e.g., token, role, userId
    await GetStorage().remove('token');
    await GetStorage().remove('role');
    await GetStorage().remove('userId');
  }