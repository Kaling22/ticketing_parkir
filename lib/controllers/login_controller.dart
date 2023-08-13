import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ticketing_parkir/menu/HomeScreen.dart';
import 'package:ticketing_parkir/utils/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginEmail);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
        if (response.statusCode == 200) {
        final json = await jsonDecode(response.body);
        if (json['success'] == true) {
          var token = json['data']['token'];
          var idpetugas = json['data']['id'].toString();
          var namapetugas = json['data']['name'].toString();
          var emailpetugas = json['data']['email'].toString();
          
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);
          await prefs?.setString('id', idpetugas);
          await prefs?.setString('name', namapetugas);
          await prefs?.setString('email', emailpetugas);
          emailController.clear();
          passwordController.clear();
          Get.offAll(HomeScreen(token: token, id:idpetugas, name:namapetugas, email:emailpetugas));
        } else if (json['success'] == false) {
          throw jsonDecode(response.body)['message'];
        }
        
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Login Gagal";
        
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
    
  }
}
