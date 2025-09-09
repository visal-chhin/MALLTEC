import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/stock_mall.dart';
import 'stock_screen.dart';
import 'home_screen.dart';
import 'cart_screen.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({super.key});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  int _selectedIndex = 1; // default selected index for ViewAll

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
        title: Text("View All Items (${stockItems.length})"), // show total items
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: stockItems.length,
        itemBuilder: (context, index) {
          final item = stockItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: 120,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to StockScreen and pass the selected item
                      Get.to(() => StockScreen(item: item));
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(12)),
                      child: Image.asset(
                        item.image,
                        width: 120,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.detail,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Spacer(),
                          Text(
                            "\$${item.price.toStringAsFixed(0)}",
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
}
