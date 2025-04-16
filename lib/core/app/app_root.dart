import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoptreo/config/constants/colors.dart';
import 'package:shoptreo/config/routes/app_routes.dart';
import 'package:shoptreo/shared/widgets/bottom_nav.dart';
import 'package:shoptreo/screens/onboarding/onboarding_screen.dart';
import 'package:shoptreo/shared/widgets/app_loader.dart';

import '../providers/auth_provider.dart';
// Error: Could not find the correct Provider<AuthProvider> above this Consumer<AuthProvider> Widget

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (authProvider.isLoading) {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(body: AppLoader()),
              );
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light().copyWith(
                primaryColor: AppColors.primary,
              ),
              darkTheme: ThemeData.dark(),
              themeMode: ThemeMode.system,
              home:
                  authProvider.isAuthenticated
                      ? const BottomNav()
                      : const OnboardingScreen(),
              initialRoute: AppRoutes.onboarding,
              routes: AppRoutes.routes,
            );
          },
        );
      },
    );
  }
}
