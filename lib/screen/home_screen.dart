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
      ),
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateLogout) {
              context.goNamed(Routes.login);
            }
          },
          builder: (context, state) {
            if (state is AuthStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AuthStateError) {
              return const Center(child: Text('Error Bro'));
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.goNamed(Routes.setting);
                    },
                    child: const Text('Go To Setting')),
                ElevatedButton(
                    onPressed: () {
                      context.goNamed(Routes.product);
                    },
                    child: const Text('Go To Product')),
              ],
            );
          },
        ),
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
