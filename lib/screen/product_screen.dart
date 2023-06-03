import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:product_scanner/bloc/bloc.dart';
import 'package:product_scanner/model/product_model.dart';
import 'package:product_scanner/routes/router.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = context.read<ProductBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Product'),
      ),
      body: StreamBuilder<QuerySnapshot<ProductModel>>(
        stream: productBloc.streamProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('Tidak ada data'),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Tidak dapat mengambil data'),
            );
          }

          List<ProductModel> allProducts = [];
          for (var element in snapshot.data!.docs) {
            allProducts.add(element.data());
          }
          return ListView.builder(
            itemCount: allProducts.length,
            itemBuilder: (context, index) {
              ProductModel productModel = allProducts[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(productModel.name.toString()),
                            Text(productModel.name.toString()),
                            Text(productModel.name.toString()),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
