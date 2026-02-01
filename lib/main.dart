import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

// ================= MAIN APP =================

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("FoodHub", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: AppBody(),
    );
  }
}

// ================= BODY =================

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- RESTAURANT BANNER IMAGE ----------
            Image.network(
              "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4",
              width: double.infinity,
              height: 280,
              fit: BoxFit.cover,
            ),

            // ---------- CATEGORIES ----------
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoryBox(name: "Pizza", icon: Icons.local_pizza),
                CategoryBox(name: "Salads", icon: Icons.eco),
                CategoryBox(name: "Beverages", icon: Icons.local_drink),
                CategoryBox(name: "Desserts", icon: Icons.cake),
              ],
            ),

            // ---------- FEATURED DISHES ----------
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Featured Dishes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // ---------- FEATURED CARDS ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeaturedCard(
                  imageUrl:
                      "https://images.unsplash.com/photo-1550547660-d9450f859349",
                  title: "Classic Burger",
                  rating: "4.8",
                  time: "20-25 min",
                  price: "\$12.99",
                ),
                FeaturedCard(
                  assetImage: "assets/pizza.jpg",
                  title: "Margherita Pizza",
                  rating: "4.9",
                  time: "30-35 min",
                  price: "\$15.99",
                ),
                FeaturedCard(
                  imageUrl:
                      "https://images.unsplash.com/photo-1551183053-bf91a1d81141",
                  title: "Caesar Salad",
                  rating: "4.6",
                  time: "10-15 min",
                  price: "\$9.99",
                ),
              ],
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ================= CATEGORY BOX =================

class CategoryBox extends StatelessWidget {
  final String name;
  final IconData icon;

  CategoryBox({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$name category clicked"),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.green),
            SizedBox(height: 5),
            Text(name, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ================= FEATURED CARD =================

class FeaturedCard extends StatelessWidget {
  final String? imageUrl;
  final String? assetImage;
  final String title;
  final String rating;
  final String time;
  final String price;

  FeaturedCard({
    this.imageUrl,
    this.assetImage,
    required this.title,
    required this.rating,
    required this.time,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- IMAGE ----------
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: assetImage != null
                ? Image.asset(
                    assetImage!,
                    height: 90,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    imageUrl!,
                    height: 90,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),

                SizedBox(height: 6),

                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.orange),
                    SizedBox(width: 4),
                    Text(rating),
                    SizedBox(width: 10),
                    Icon(Icons.timer, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(time),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Add", style: TextStyle(fontSize: 12)),
                    ),
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
