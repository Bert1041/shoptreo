import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoptreo/config/constants/colors.dart';
import 'package:shoptreo/shared/widgets/reusable_app_button.dart';
import '../../config/routes/app_routes.dart';
import '../../core/providers/auth_provider.dart';
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
    const LogoutScreen(screen: "Discover"),
    const LogoutScreen(screen: "Orders"),
    const LogoutScreen(screen: "Account"),
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
            label: 'Discover',
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

class LogoutScreen extends StatelessWidget {
  final String screen;

  const LogoutScreen({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(screen), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AppButton(
            label: 'Logout',
            isPrimary: true,
            onPressed: () {
              // Logout and navigate to login screen
              authProvider.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.start,
                (route) => false,
              );
            },
            margin: 0,
          ),
        ),
      ),
    );
  }
}
