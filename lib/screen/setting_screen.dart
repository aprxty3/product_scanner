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
            onPressed: () => GoRouter.of(context).go('/'),
            child: Text('Back to Homepage')),
      ),
    );
  }
}
