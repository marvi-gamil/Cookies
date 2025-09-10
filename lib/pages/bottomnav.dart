import 'package:flutter/material.dart';
import 'home.dart';
import 'order.dart';
import 'wallet.dart';
import 'profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  void setPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      Home(setPage: setPage),
      OrdersPage(setPage: setPage),
      WalletPage(setPage: setPage),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color(0xFF1C4BA0),
        buttonBackgroundColor: const Color(0xFF1C4BA0),
        height: 60,
        index: _currentIndex,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.shopping_cart_outlined, color: Colors.white),
          Icon(Icons.account_balance_wallet_outlined, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
