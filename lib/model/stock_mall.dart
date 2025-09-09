class StockItem {
  final String name;
  final String detail;
  final double price;
  final String image;

  StockItem({
    required this.name,
    required this.detail,
    required this.price,
    required this.image,
  });
}

// 12 items: 6 original + 6 duplicates with unique images
final List<StockItem> stockItems = [
  StockItem(
    name: "Laptop Pro X",
    detail: "High-performance laptop with latest CPU and GPU, ideal for gaming and professional work.",
    price: 2200.0,
    image:"asset/img/laptop.png",
  ),
  StockItem(
    name: "Ultra Monitor 27",
    detail: "27-inch QHD monitor with vibrant colors, fast refresh rate, and adjustable stand.",
    price: 450.0,
    image: "asset/img/monitor.png",
  ),
  StockItem(
    name: "PC Gamer V2",
    detail: "Desktop computer with latest CPU, high-end GPU, and RGB lighting for immersive gaming.",
    price: 1800.0,
    image: "asset/img/pc.png",
  ),
  StockItem(
    name: "Noise-Cancelling Headphones",
    detail: "Over-ear headphones with clear sound, deep bass, and comfortable fit for long use.",
    price: 250.0,
    image: "asset/img/headphones.png",
  ),
  StockItem(
    name: "Mechanical RGB Keyboard",
    detail: "Durable mechanical keyboard with customizable RGB lighting and tactile switches.",
    price: 120.0,
    image: "asset/img/keyboard.png",
  ),
  StockItem(
    name: "Wireless Mouse Ergonomic",
    detail: "High-precision wireless mouse with ergonomic design and long battery life.",
    price: 80.0,
    image: "asset/img/mouse.png",
  ),
  // Duplicates with unique images
  StockItem(
    name: "Laptop Pro X 2",
    detail: "High-performance laptop with latest CPU and GPU, ideal for gaming and professional work.",
    price: 2200.0,
    image: "asset/img/laptop2.png",
  ),
  StockItem(
    name: "Ultra Monitor 27 2",
    detail: "27-inch QHD monitor with vibrant colors, fast refresh rate, and adjustable stand.",
    price: 450.0,
    image: "asset/img/monitor2.png",
  ),
  StockItem(
    name: "PC Gamer V2 2",
    detail: "Desktop computer with latest CPU, high-end GPU, and RGB lighting for immersive gaming.",
    price: 1800.0,
    image: "asset/img/pc2.png",
  ),
  StockItem(
  name: "Noise-Cancelling Headphones X",
  detail: "Over-ear headphones with clear sound, deep bass, and comfortable fit for long use.",
  price: 200.0,
  image: "asset/img/headphones.png",
  ),
  StockItem(
    name: "Mechanical RGB Keyboard Pro",
    detail: "Durable mechanical keyboard with customizable RGB lighting and tactile switches.",
    price: 100.0,
    image: "asset/img/keyboard.png",
  ),
  StockItem(
    name: "Wireless Mouse Ergonomic Plus",
    detail: "High-precision wireless mouse with ergonomic design and long battery life.",
    price: 70.0,
    image: "asset/img/mouse.png",
  ),

];
