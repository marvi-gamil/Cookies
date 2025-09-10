import 'package:flutter/material.dart';
import 'package:food_delivery/service/widget_support.dart';
import 'package:food_delivery/pages/signup.dart';

class OneBoard extends StatefulWidget {
  const OneBoard({super.key});

  @override
  State<OneBoard> createState() => _OneBoardState();
}

class _OneBoardState extends State<OneBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            // Onboarding Image
            Image.asset(
              "assets/images/OnBoard.png",
              height: 550,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 10.0),

            // Title
            Center(
              child: Text(
                'Fresh Cookies, Fast Delivery',
                textAlign: TextAlign.center,
                style: AppWidget.HeadLineTextFieldstyle(),
              ),
            ),

            const SizedBox(height: 20.0),

            // Subtitle
            Text(
              'Order your favorite cookies\nanytime, anywhere 🍪',
              textAlign: TextAlign.center,
              style: AppWidget.SimpleTextFieldstyle(),
            ),

            const SizedBox(height: 60.0),

            // ✅ Get Started Button (navigates to Signup)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Signup()),
                );
              },
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 74, 137, 210),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Pacifico-Regular',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
