import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoptreo/core/app/app_root.dart';

import 'core/providers/auth_provider.dart';
import 'core/providers/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = AuthProvider();
            provider.tryAutoLogin();
            return provider;
          },
        ),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const AppRoot(),
    );
  }
}
