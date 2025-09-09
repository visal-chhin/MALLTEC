import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:malltec/view/cart_screen.dart';
import 'package:malltec/view/login_screen.dart';
import 'package:malltec/view/stock_screen.dart';
import 'package:malltec/view/view_all.dart';
import '../model/stock_mall.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _selectedIndex = 0;

  final String _text = "WELCOME TO MALLTECT "; // scrolling text
  final double boxHeight = 40;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    final firstSixItems = stockItems.take(6).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 104, 150, 230),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: InkWell(
          onTap: () => Get.to(() => const LoginScreen()),
          child: Image.asset("asset/img/logo.png", width: 50, height: 50),
        ),
        title: InkWell(
          onTap: () => Get.to(() => const HomeScreen()),
          child: const Center(
            child: Text(
              "MALL TECT",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () => Get.to(() => const CartScreen()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("asset/img/logo.png", width: 20, height: 20),
                const SizedBox(height: 2),
                const Text(
                  "Cart",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Scrolling text
          SizedBox(
            height: boxHeight,
            width: double.infinity,
            child: ClipRect(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final textPainter = TextPainter(
                    text: TextSpan(
                      text: _text,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    textDirection: TextDirection.ltr,
                  )..layout();

                  final textWidth = textPainter.width;
                  final offset =
                      -textWidth + (_controller.value * (MediaQuery.of(context).size.width + textWidth));

                  return Transform.translate(
                    offset: Offset(offset, 0),
                    child: Text(
                      _text,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // GridView
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: firstSixItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final item = firstSixItems[index];
                return InkWell(
                  onTap: () => Get.to(StockScreen(item: item),), // pass item to StockScreen
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(item.image, fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Vertical list title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  "Best Items to Sale:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Vertical ListView
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: firstSixItems.length,
              itemBuilder: (context, index) {
                final item = firstSixItems[index];
                return InkWell(
                  onTap: () => Get.to(StockScreen(item: item),), // pass item to StockScreen
                  child: _buildVerticalCard(item: item),
                );
              },
            ),
          ),
        ],
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

  Widget _buildVerticalCard({required StockItem item}) {
    double buyPrice = 5000;
    if (item.name.toLowerCase().contains("laptop") ||
        item.name.toLowerCase().contains("keyboard")) {
      buyPrice = 8000;
    }

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.asset(
                item.image,
                width: 100,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    const Spacer(),
                    Text(
                      "\$${item.price.toStringAsFixed(0)}",
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          onPressed: () => Get.to(() => const ViewAll()),
                          child: const Text("View"),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          onPressed: () {},
                          child: Text("Buy +\$${buyPrice ~/ 1000}k"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
