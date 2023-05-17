import 'package:flutter/material.dart';
import 'package:product_scanner/routes/router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Screen'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => context.goNamed(Routes.home),
            child: const Text('Back to Homepage')),
      ),
    );
  }
}
