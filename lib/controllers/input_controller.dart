import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ticketing_parkir/menu/HomeScreen.dart';
import 'package:ticketing_parkir/utils/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InputController extends GetxController {
  TextEditingController nimController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + "");
      Map body = {
        'nim': nimController.text,
        'created_by':1,
        'updated_by':1
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
//sampai sini
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['Token'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);
          Get.offAll(HomeScreen());
        } else if (json['code'] == 1) {
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
