import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cart.dart';
import 'profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://rxqucmdsnpwqetfxzoux.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ4cXVjbWRzbnB3cWV0Znh6b3V4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQ2MTIyMjAsImV4cCI6MjA5MDE4ODIyMH0.ZkCXoqiZb1BnBXgxbBU7R1MGUtYpDPUAnsLRchdXFO4',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey.shade50,
      ),
      home: const FoodHubHome(),
    );
  }
}

class FoodHubHome extends StatefulWidget {
  const FoodHubHome({super.key});

  @override
  State<FoodHubHome> createState() => _FoodHubHomeState();
}

class _FoodHubHomeState extends State<FoodHubHome> {
  int _selectedIndex = 0;

  // CartPage key to force refresh when switching to cart tab
  final GlobalKey<CartPageState> _cartKey = GlobalKey<CartPageState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const AppBody(),
      const OrdersPage(),
      CartPage(key: _cartKey),
      const ProfilePage(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
    // Refresh cart every time user taps cart tab
    if (index == 2) {
      _cartKey.currentState?.loadCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "FoodHub",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Orders"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for food...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.green),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.tune, size: 16, color: Colors.white),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1550547660-d9450f859349',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CategoryItem(icon: Icons.local_pizza, label: "Pizza"),
              CategoryItem(icon: Icons.eco, label: "Salads"),
              CategoryItem(icon: Icons.local_drink, label: "Drinks"),
              CategoryItem(icon: Icons.cake, label: "Desserts"),
            ],
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Featured Dishes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              children: const [
                FeaturedCard(
                  title: "Burger",
                  price: "\$12.99",
                  img: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd",
                ),
                FeaturedCard(
                  title: "Pizza",
                  price: "\$15.99",
                  img: "https://images.unsplash.com/photo-1600028068383-ea11a7a101f3",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [_tabButton("Ongoing", 0), _tabButton("Completed", 1)],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: activeTab == 0
                ? [
                    const OrderCard(
                      title: "Double Beef Burger",
                      shop: "FoodHub Central",
                      price: "\$18.50",
                      status: "Preparing",
                      isOngoing: true,
                    ),
                  ]
                : [
                    const OrderCard(
                      title: "Pepperoni Pizza",
                      shop: "Pizza Palace",
                      price: "\$12.00",
                      status: "Delivered",
                      isOngoing: false,
                    ),
                  ],
          ),
        ),
      ],
    );
  }

  Widget _tabButton(String title, int index) {
    bool isSelected = activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => activeTab = index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String title, shop, price, status;
  final bool isOngoing;
  const OrderCard({
    super.key,
    required this.title,
    required this.shop,
    required this.price,
    required this.status,
    required this.isOngoing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(Icons.fastfood, color: Colors.green.shade400),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  shop,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 5),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                status,
                style: TextStyle(
                  color: isOngoing ? Colors.orange : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isOngoing ? Colors.green.shade50 : Colors.green,
                  foregroundColor: isOngoing ? Colors.green : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(80, 30),
                ),
                child: Text(
                  isOngoing ? "Track" : "Reorder",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const CategoryItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.green.shade50,
          child: Icon(icon, color: Colors.green),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class FeaturedCard extends StatelessWidget {
  final String title, price, img;
  const FeaturedCard({
    super.key,
    required this.title,
    required this.price,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              img,
              height: 100,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(price, style: const TextStyle(color: Colors.green)),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    // Check if item already exists in cart
                    final existing = await supabase
                        .from('foodtable')
                        .select()
                        .eq('title', title);

                    if (existing.isNotEmpty) {
                      // Item exists — increase quantity
                      final currentQty = existing[0]['quantity'] ?? 1;
                      final itemId = existing[0]['id'];
                      await supabase
                          .from('foodtable')
                          .update({'quantity': currentQty + 1}).eq('id', itemId);
                    } else {
                      // Item doesn't exist — insert new
                      await supabase.from('foodtable').insert({
                        'title': title,
                        'price': double.parse(price.replaceAll('\$', '')),
                        'image': img,
                        'quantity': 1,
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$title added to cart!"),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text("Add", style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
