import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_scanner/routes/router.dart';
import 'bloc/bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        routerConfig: router,
      ),
    );
  }
}
