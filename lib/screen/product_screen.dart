import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:product_scanner/bloc/bloc.dart';
import 'package:product_scanner/model/product_model.dart';
import 'package:product_scanner/routes/router.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
          if (allProducts.isEmpty) {
            return const Center(
              child: Text('Tidak ada data'),
            );
          }
          return ListView.builder(
            itemCount: allProducts.length,
            itemBuilder: (context, index) {
              ProductModel productModel = allProducts[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                margin: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    context.goNamed(
                      Routes.detailProduct,
                      pathParameters: {
                        'id': productModel.id!,
                      },
                      extra: productModel,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productModel.code.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(productModel.name.toString()),
                              const SizedBox(height: 5),
                              Text('Jumlah Product : ${productModel.qty}'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: QrImageView(
                            data: productModel.code!,
                            size: 200,
                            version: QrVersions.auto,
                          ),
                        ),
                      ],
                    ),
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
