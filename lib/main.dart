
import 'package:auth_flutter_example/firebase_options.dart';
import 'package:auth_flutter_example/screens/authScreen/AuthScreen.dart';
import 'package:auth_flutter_example/screens/formScreen.dart';
import 'package:auth_flutter_example/screens/homeScreen/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      routes: {
        '/': (_) => Authscreen(),
        '/home': (_) => HomeScreen(),
        '/form': (_) => FormScreen()
      },
      initialRoute: '/',
    );
  }
}
