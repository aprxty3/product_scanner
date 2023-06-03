import 'package:flutter/material.dart';
import 'package:product_scanner/bloc/bloc.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: codeController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: "Product Code",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Product Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Quantity",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                if (codeController.text.length == 10) {
                  context.read<ProductBloc>().add(ProductEventAdd(
                      code: codeController.text,
                      name: nameController.text,
                      qty: int.parse(quantityController.text)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Code harus 10 digit"),
                  ));
                }
              },
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is ProductStateError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                    ));
                  }
                },
                builder: (context, state) {
                  return Text(
                      state is ProductStateLoading ? 'loading' : 'Tambah');
                },
              ))
        ],
      ),
    );
  }
}
