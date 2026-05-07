import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/login/login_screen.dart';
import 'auth/register/register_screen.dart';
import 'firebase_options.dart';
import 'package:movies_app/screens/home_screen/home_screen.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context)=>  LoginScreen(),
        RegisterScreen.routeName: (context)=> RegisterScreen(),
        HomeScreen.routeName: (context)=> const HomeScreen(),

      },
    );
  }
}

class WhiteScreen extends StatelessWidget {
  const WhiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}