import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoptreo/config/constants/colors.dart';
import 'package:shoptreo/config/routes/app_routes.dart';
import 'package:shoptreo/shared/widgets/bottom_nav.dart';
import 'package:shoptreo/screens/onboarding/onboarding_screen.dart';
import 'package:shoptreo/shared/widgets/app_loader.dart';

import '../providers/auth_provider.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        if (authProvider.isLoading) {
          return const MaterialApp(home: Scaffold(body: AppLoader()));
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: AppColors.primary),
          home:
              authProvider.isAuthenticated
                  ? const BottomNav()
                  : const OnboardingScreen(),
          initialRoute: AppRoutes.onboarding,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
