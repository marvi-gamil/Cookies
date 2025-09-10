import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:food_delivery/service/widget_support.dart';

class Home extends StatefulWidget {
  final Function(int)? setPage;
  const Home({super.key, this.setPage});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> cookiesMenu = [
    {
      "name": "Chocolate Chip",
      "price": 4.99,
      "image": "assets/images/CookieChip.jpg",
      "desc": "Classic sweet with rich chocolate chunks.",
    },
    {
      "name": "Oatmeal Raisin",
      "price": 3.99,
      "image": "assets/images/OatmealRaisin.jpg",
      "desc": "Chewy oats mixed with juicy raisins.",
    },
    {
      "name": "Peanut Butter",
      "price": 5.49,
      "image": "assets/images/PeanutButter.jpg",
      "desc": "Nutty, soft and deliciously creamy.",
    },
    {
      "name": "Double Chocolate",
      "price": 5.99,
      "image": "assets/images/DoubleChocolate.jpg",
      "desc": "Dark cocoa with chocolate chunks.",
    },
    {
      "name": "White Chocolate Macadamia",
      "price": 6.49,
      "image": "assets/images/WhiteChocolateMacadamia.jpg",
      "desc": "Sweet white chocolate & crunchy nuts.",
    },
    {
      "name": "Red Velvet",
      "price": 6.99,
      "image": "assets/images/RedVelvet.jpg",
      "desc": "Soft, rich, with a hint of cocoa.",
    },
    {
      "name": "Snickerdoodle",
      "price": 4.49,
      "image": "assets/images/Snickerdoodle.jpg",
      "desc": "Cinnamon-sugar coated classic.",
    },
    {
      "name": "Birthday Cake",
      "price": 5.79,
      "image": "assets/images/BirthdayCake.jpg",
      "desc": "Sprinkles and sweet vanilla delight.",
    },
  ];

  void addToCart(Map<String, dynamic> cookie) {
    Cart.instance.addItem(cookie);
    setState(() {});
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("${cookie['name']} added to cart")));
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = Cart.instance.items;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/HomeBackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cookies 🍪', style: AppWidget.LogoTextStyle()),
                        const SizedBox(height: 5),
                        Text(
                          'Sweet moments start here',
                          style: AppWidget.OrderTextStyle(),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.setPage != null)
                          widget.setPage!(1); // OrdersPage index
                      },
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.shopping_cart_outlined,
                            size: 32,
                            color: Color(0xFF1C4BA0),
                          ),
                          if (cartItems.isNotEmpty)
                            Positioned(
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text(
                                  cartItems.length.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: cookiesMenu.length,
                    itemBuilder: (context, index) {
                      final cookie = cookiesMenu[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.pink.shade50.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: Image.asset(
                                cookie["image"],
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    cookie["name"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    cookie["desc"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${cookie["price"].toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1C4BA0),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add_circle,
                                          color: Color(0xFF1C4BA0),
                                        ),
                                        onPressed: () => addToCart(cookie),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
