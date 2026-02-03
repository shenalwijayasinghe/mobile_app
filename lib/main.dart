import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "FoodHub",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Profile clicked")));
            },
          ),
        ],
      ),
      body: const AppBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Orders'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
          // ================= SEARCH BAR =================
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for food...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ================= RESPONSIVE RESTAURANT IMAGE =================
          LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;

              double height = width >= 1200
                  ? 420 // Desktop
                  : width >= 800
                  ? 350 // Tablet
                  : 250; // Mobile

              return Container(
                width: double.infinity,
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://static.vecteezy.com/system/resources/thumbnails/030/033/458/small/burger-fry-souse-banner-free-space-text-mockup-fast-food-top-view-empty-professional-phonography-photo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // ================= CATEGORIES =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryChip(Icons.local_pizza, 'Pizza', Colors.orange),
                _buildCategoryChip(Icons.eco, 'Salads', Colors.green),
                _buildCategoryChip(Icons.local_drink, 'Beverages', Colors.blue),
                _buildCategoryChip(Icons.cake, 'Desserts', Colors.pink),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ================= FEATURED DISHES =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Featured Dishes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('See All', style: TextStyle(color: Colors.green)),
              ],
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 260,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                FeaturedCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
                  title: 'Classic Burger',
                  rating: '4.8',
                  time: '20-25 min',
                  price: '\$12.99',
                  label: 'Popular',
                  labelColor: Colors.red,
                ),
                SizedBox(width: 16),
                FeaturedCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1600028068383-ea11a7a101f3',
                  title: 'Margherita Pizza',
                  rating: '4.9',
                  time: '30-35 min',
                  price: '\$15.99',
                  label: 'New',
                  labelColor: Colors.green,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// ================= FEATURED CARD =================
class FeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;
  final String time;
  final String price;
  final String? label;
  final Color? labelColor;

  const FeaturedCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.time,
    required this.price,
    this.label,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (label != null)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: labelColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      label!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
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
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(rating),
                    const SizedBox(width: 12),
                    const Icon(Icons.timer, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(time),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text("Add")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
