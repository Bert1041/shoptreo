import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptreo/config/constants/colors.dart';
import 'package:shoptreo/screens/auth/account_screen.dart';
import 'package:shoptreo/screens/discover/discover_screen.dart';
import 'package:shoptreo/screens/orders/orders_screen.dart';
import '../../screens/home_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0; // Index for bottom navigation

  final List<Widget> _screens = [
    const HomeScreen(),
    const DiscoverScreen(),
    const OrdersScreen(),
    const AccountScreen(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        selectedLabelStyle: TextStyle(
          fontFamily: 'Filson Pro',
          fontSize: 10.sp,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Filson Pro',
          fontSize: 10.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        onTap: _onBottomNavTapped,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

