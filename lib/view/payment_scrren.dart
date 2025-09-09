import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart_screen.dart'; // import your cart_screen.dart to access cartItems

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate total from cartItems
    double totalAmount = 0;
    for (var item in CartScreen.cartItems) {
      totalAmount += item['total'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/aba.png',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            const Text(
              "MALL TECT : SAL",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Total Payment: \$${totalAmount.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
