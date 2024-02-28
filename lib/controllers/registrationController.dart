import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/apiEndPoints.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  // level users
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.registerEmail);
      Map body = {
        'level': 'Trainee',
        'name': nameController.text,
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'phoneNumber': phoneNumberController.text,
        'address': addressController.text,
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      print(response);

      // if (response.statusCode == 201) {
      //   final json = jsonDecode(response.body);
      //   if (json['code'] == 0) {
      //     var token = json['data']['Token'];
      //     print(token);
      //     final SharedPreferences? prefs = await _prefs;

      //     await prefs?.setString('token', token);
      //     nameController.clear();
      //     emailController.clear();
      //     passwordController.clear();
      //     phoneNumberController.clear();
      //     addressController.clear();

      //     // goto login
      //   } else {
      //     throw jsonDecode(response.body)["Message"] ?? "nknown Error Occured";
      //   }
      // } else {
      //   throw jsonDecode(response.body)["Message"] ?? "Unknown Eroor Occured";
      // }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text("Error"),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
