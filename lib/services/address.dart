import 'dart:convert';

import 'package:thebasiclook/constants.dart';
import 'package:http/http.dart' as http;
import 'package:thebasiclook/models/address_model.dart';

class AddressServices {
  Future<List<AddressModel>> getAddress({required String token}) async {
    final url = Uri.parse(baseUrl + 'address/');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    List<AddressModel> addressList = [];
    if (response.statusCode == 200) {
      List<dynamic> allAddress = jsonDecode(response.body)['addresses'];
      for (final address in allAddress) {
        addressList.add(AddressModel.fromJson(address));
      }
      print('success address List' + addressList.toString());
    } else {
      print(response.body);
      print(response.statusCode);
    }
    return addressList;
  }

  Future<void> updateAddress(
      {required String addressLine,
      required String country,
      required String city,
      required String state,
      required String postalCode,
      required String phone,
      required String token,
      required String id}) async {
    final url = Uri.parse(baseUrl + 'address/$id');
    final response = await http.put(url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "addressLine": addressLine,
          "country": country,
          "postalCode": postalCode,
          "city": city,
          "state": state,
          "phone": phone
        }));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final address = responseData['message'];
      print(address);
    } else {
      print(response.body);
      print(response.request);
      print(response.statusCode);
    }
  }

  /* Future<AddressModel?> getAddressById({required String token,
 required String id}) async {
    final url = Uri.parse(baseUrl + 'address/$id');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final dynamic addressData = jsonDecode(response.body)['address'];
      final AddressModel address = AddressModel.fromJson(addressData);
      return address;
    } else if (response.statusCode == 404) {
      print(response.body);
      print(response.statusCode);
      return null;
    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception('Failed to retrieve address');
    }
  } */
  Future<void> addAddress(
      {required String addressLine,
      required String country,
      required String city,
      required String state,
      required String postalCode,
      required String phone,
      required String token}) async {
    final url = Uri.parse(baseUrl + 'address/');
    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "addressLine": addressLine,
          "country": country,
          "postalCode": postalCode,
          "city": city,
          "state": state,
          "phone": phone
        }));

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final address = responseData['address'];
      print('address is added successfuly');
      print(responseData);
      print('address is added successfuly' + address.toString());
    } else {
      print(response.body);
      print(response.request);
      print(response.statusCode);
    }
  }

  Future<void> deleteAddress(
      {required String token, required String id}) async {
    final url = Uri.parse(baseUrl + 'address/$id');
    final response = await http.delete(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print('deleted successfully address List');
    } else {
      print(response.body);
      print(response.statusCode);
    }
  }
}
