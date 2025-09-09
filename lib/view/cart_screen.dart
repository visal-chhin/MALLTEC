import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malltec/view/payment_scrren.dart';
import '../model/stock_mall.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  // Global list to store cart items
  static List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    double grandTotal = 0;
    for (var item in cartItems) {
      grandTotal += item['total'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.blueAccent,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cart = cartItems[index];
                      final StockItem item = cart['item'];
                      final int quantity = cart['quantity'];
                      final double total = cart['total'];

                      return ListTile(
                        leading: Image.asset(item.image, width: 50, height: 50),
                        title: Text(item.name),
                        subtitle: Text("Quantity: $quantity"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("\$${total.toStringAsFixed(0)}"),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                cartItems.removeAt(index);
                                Get.snackbar(
                                  "Removed",
                                  "${item.name} removed from cart",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.withOpacity(0.8),
                                  colorText: Colors.white,
                                  duration: const Duration(seconds: 2),
                                );
                                // Rebuild UI
                                (context as Element).markNeedsBuild();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Grand Total: \$${grandTotal.toStringAsFixed(0)}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {
                      if (cartItems.isNotEmpty) {
                        Get.to(() => const PaymentScreen());
                      } else {
                        Get.snackbar(
                          "Cart Empty",
                          "Add items to cart before payment",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.withOpacity(0.8),
                          colorText: Colors.white,
                          duration: const Duration(seconds: 2),
                        );
                      }
                    },
                    child: const Text(
                      "Proceed to Payment",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
    );
  }
}
