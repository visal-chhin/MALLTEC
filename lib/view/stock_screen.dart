import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malltec/controller/count_item.dart';
import '../model/stock_mall.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'view_all.dart';

class StockScreen extends StatefulWidget {
  final StockItem item;

  const StockScreen({super.key, required this.item});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final CountItemController controller = Get.put(CountItemController());

  // Available colors
  final List<Color> availableColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.black,
    Colors.orange,
  ];

  // Selected color reactive
  final Rx<Color> selectedColor = Colors.black.obs;

  // Bottom navigation
  int _selectedIndex = 1; // default to View All

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Get.to(() => const HomeScreen());
          break;
        case 1:
          Get.to(() => const ViewAll());
          break;
        case 2:
          Get.to(() => const CartScreen());
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Get.back(),
        ),
        title: Text(widget.item.name),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => const CartScreen());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.item.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(widget.item.name,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.item.detail, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            const Text(
              "MallTec Store",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 4),
            const Text(
              "We provide high-quality electronics with fast shipping, trusted service, and best customer support for all buyers.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Color selection
            Row(
              children: [
                const Text("Select Color:", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                ...availableColors.map((color) {
                  return Obx(() => GestureDetector(
                        onTap: () => selectedColor.value = color,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: selectedColor.value == color
                                ? Border.all(width: 2, color: Colors.black)
                                : null,
                          ),
                        ),
                      ));
                }).toList(),
              ],
            ),
            const SizedBox(height: 16),
            // Quantity and Add to Cart
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Quantity:", style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: controller.decrease,
                        ),
                        Text(controller.quantity.value.toString(),
                            style: const TextStyle(fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: controller.increase,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Total: \$${(widget.item.price * controller.quantity.value).toStringAsFixed(0)}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {
                          // Add to cart
                          CartScreen.cartItems.add({
                            'item': widget.item,
                            'quantity': controller.quantity.value,
                            'total': widget.item.price * controller.quantity.value,
                            'color': selectedColor.value,
                          });

                          // Show snackbar at the top
                          Get.snackbar(
                            "Added to Cart",
                            "${widget.item.name} x${controller.quantity.value} (${_colorName(selectedColor.value)})",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.green.withOpacity(0.8),
                            colorText: Colors.white,
                            duration: const Duration(seconds: 2),
                          );

                          controller.quantity.value = 1; // reset
                        },
                        child: Text(
                          "Add to Cart - \$${(widget.item.price * controller.quantity.value).toStringAsFixed(0)}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "View All",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
      ),
    );
  }

  String _colorName(Color color) {
    if (color == Colors.red) return 'Red';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.green) return 'Green';
    if (color == Colors.black) return 'Black';
    if (color == Colors.orange) return 'Orange';
    return 'Color';
  }
}
