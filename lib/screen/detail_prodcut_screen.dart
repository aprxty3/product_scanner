import 'package:flutter/material.dart';

class DetailProductScreen extends StatelessWidget {
  final String id;
  final Map<String, dynamic> data;
  const DetailProductScreen(this.id, this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
      ),
      body: Center(
        child: Text(
          data.toString(),
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
