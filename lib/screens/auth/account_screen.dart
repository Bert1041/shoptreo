import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoptreo/config/routes/app_routes.dart';
import 'package:shoptreo/core/providers/auth_provider.dart';
import 'package:shoptreo/shared/widgets/reusable_app_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Account"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: AppButton(
            label: 'Logout',
            isPrimary: true,
            onPressed: () {
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
