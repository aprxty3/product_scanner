import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_scanner/bloc/auth/auth_bloc.dart';
import 'package:product_scanner/routes/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          String? title;
          IconData? icon;
          VoidCallback? onTap;

          switch (index) {
            case 0:
              title = 'Add Product';
              icon = Icons.post_add_rounded;
              onTap = () => context.goNamed(Routes.scan);
              break;
            case 1:
              title = 'Product';
              icon = Icons.list_alt_outlined;
              onTap = () => context.goNamed(Routes.product);
              break;
            case 2:
              title = 'QR Code';
              icon = Icons.qr_code;
              onTap = () {};
              break;
            case 3:
              title = 'Catalog';
              icon = Icons.document_scanner_outlined;
              onTap = () {};
              break;
          }

          return Material(
            borderRadius: BorderRadius.circular(9),
            color: Colors.blueAccent,
            child: InkWell(
              borderRadius: BorderRadius.circular(9),
              onTap: onTap,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(title!),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthBloc>().add(AuthEventLogout());
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
