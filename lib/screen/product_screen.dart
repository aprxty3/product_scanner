import 'package:flutter/material.dart';
import 'package:product_scanner/routes/router.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Product'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              // context.go('/product/${index + 1}');
              context.goNamed(
                Routes.detailProduct,
                pathParameters: {'id': '${index + 1}'},
                queryParameters: {
                  'id': '${index + 1}',
                  'name': 'product ${index + 1}',
                  'desc': 'ini adalah product ${index + 1}',
                },
              );
            },
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(
              'Product ${index + 1}',
            ),
          );
        },
      ),
    );
  }
}
