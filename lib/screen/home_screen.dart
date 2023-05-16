import 'package:flutter/material.dart';
import 'package:product_scanner/routes/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.goNamed(Routes.setting);
                },
                child: Text('Go To Setting')),
            ElevatedButton(
                onPressed: () {
                  context.goNamed(Routes.product);
                },
                child: Text('Go To Product')),
          ],
        ),
      ),
    );
  }
}
