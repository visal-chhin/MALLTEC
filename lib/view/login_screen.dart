import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:malltec/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Get.to(HomeScreen()); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 104, 150, 230),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Column(
          children: [
            Image.asset("asset/img/logo.png", width: 50, height: 50),
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          child: InkWell(
            onTap: () => Get.to(HomeScreen()),
            child: Column(
              children: [
                Image.asset("asset/img/logo.png", width: 90, height: 90),
                const Text(
                  "MALL TECT",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
