import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:food_delivery/service/widget_support.dart';

class WalletPage extends StatefulWidget {
  final Function(int)? setPage;
  const WalletPage({super.key, this.setPage});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  String selectedGovernorate = 'Port Said';
  String selectedPayment = 'Visa';
  double shippingFee = 2.5;

  final Map<String, double> governorateShipping = {
    'Port Said': 2.5,
    'Cairo': 5.0,
    'Alexandria': 4.0,
  };

  final List<Map<String, dynamic>> paymentMethods = [
    {'name': 'Visa', 'icon': Icons.credit_card},
    {'name': 'MasterCard', 'icon': Icons.payment},
    {'name': 'Cash', 'icon': Icons.money},
  ];

  @override
  Widget build(BuildContext context) {
    final cartItems = Cart.instance.items;
    double subtotal = Cart.instance.getSubtotal();
    double total = subtotal + shippingFee;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/HomeBackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Summary 📝", style: AppWidget.LogoTextStyle()),
                const SizedBox(height: 12),

                ValueListenableBuilder(
                  valueListenable: Cart.instance.notifier,
                  builder: (context, _, __) {
                    if (cartItems.isEmpty) {
                      return Center(
                        child: Text(
                          "No items in cart!",
                          style: AppWidget.SimpleTextFieldstyle(),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  item["image"],
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["name"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1C4BA0),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Quantity: ${item["quantity"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "\$${(item["price"] * item["quantity"]).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1C4BA0),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 16),
                Text("Checkout 🛒", style: AppWidget.LogoTextStyle()),
                const SizedBox(height: 12),

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: selectedGovernorate,
                  decoration: const InputDecoration(
                    labelText: "Governorate",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: governorateShipping.keys
                      .map(
                        (gov) => DropdownMenuItem(value: gov, child: Text(gov)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGovernorate = value!;
                      shippingFee = governorateShipping[selectedGovernorate]!;
                    });
                  },
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: streetController,
                  decoration: const InputDecoration(
                    labelText: "Street Address",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                Text("Payment Method 💳", style: AppWidget.OrderTextStyle()),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  children: paymentMethods.map((method) {
                    bool isSelected = selectedPayment == method['name'];
                    return ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(method['icon'], color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            method['name'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFF1C4BA0),
                      backgroundColor: Colors.grey,
                      onSelected: (selected) {
                        setState(() {
                          selectedPayment = method['name'];
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shipping Fee: \$${shippingFee.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(height: 12, thickness: 1.2),
                      Text(
                        "Total: \$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C4BA0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C4BA0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Payment Successful!")),
                        );
                        Cart.instance.clear();
                        setState(() {});
                      },
                      child: const Text(
                        "Pay Now",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        widget.setPage?.call(0); // العودة للـ Home
                      },
                      child: const Text(
                        "Continue Shopping",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
