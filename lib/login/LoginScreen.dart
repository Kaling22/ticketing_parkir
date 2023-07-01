import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ticketing_parkir/menu/HomeScreen.dart';
import 'package:ticketing_parkir/controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({key}) : super(key: key);
  
  LoginController loginController = Get.put(LoginController());
  var isLogin = false.obs;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(  
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(
                'assets/images/parkir_icon.jpg',
                height: 80,
                width: 80,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                textAlign: TextAlign.center,
                'Ticketing Parkir',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 255, 255, 255)
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: loginController.emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration.collapsed(
                    hintText: "E-Mail",
                    hintStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: loginController.passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration.collapsed(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: GestureDetector(
                onTap: () {
                  Navigator.pop(const HomeScreen(token: '') as BuildContext);
                },
                child: Text(
                  textAlign: TextAlign.left,
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 231, 57, 57),
                  ),
                ),),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                  
                  onPressed: () => {
                    loginController.loginWithEmail(),
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Color.fromARGB(255, 17, 17, 17),
                      fontWeight: FontWeight.w500
                    ),
                  )
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
