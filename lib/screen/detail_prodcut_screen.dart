import 'package:flutter/material.dart';
import 'package:product_scanner/bloc/bloc.dart';
import 'package:product_scanner/routes/router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../model/product_model.dart';

class DetailProductScreen extends StatelessWidget {
  DetailProductScreen(this.id, this.product, {super.key});
  final String id;
  final ProductModel product;
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeController.text = product.code!;
    nameController.text = product.name!;
    qtyController.text = product.qty.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImageView(
                  data: product.id!,
                  size: 200,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: codeController,
            keyboardType: TextInputType.number,
            readOnly: true,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: 'Product Code',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Product Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Product Qty',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<ProductBloc>().add(
                    ProductEventEdit(
                      id: product.id!,
                      name: nameController.text,
                      qty: int.parse(qtyController.text),
                    ),
                  );
            },
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
                if (state is ProductStateCompleteEdit) {
                  context.pop();
                }
              },
              builder: (context, state) {
                return Text(
                  state is ProductStateLoading
                      ? "Loadinggg..."
                      : 'Update Product',
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              context.read<ProductBloc>().add(
                    ProductEventDelete(product.id!),
                  );
            },
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
                if (state is ProductStateCompleteDelete) {
                  context.pop();
                }
              },
              builder: (context, state) {
                return const Text(
                  'Delete Product',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
