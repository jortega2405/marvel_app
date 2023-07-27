
import 'package:flutter/material.dart';
import 'package:marvel_app/providers/character_provider.dart';
import 'package:marvel_app/views/details_screen.dart';
import 'package:marvel_app/views/home_screen.dart';
import 'package:provider/provider.dart';


Future main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
  await inizalitation(null);
  runApp(const AppState());

}

Future inizalitation(BuildContext? context) async {
  await Future.delayed(const Duration(milliseconds: 1000));
}

class AppState  extends StatelessWidget {
  const AppState ({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CharacterProvider(),
          lazy: false,
        )
      ],
      child:const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel App',
      initialRoute: 'home',
      routes: {
        'home':(context) => const HomeScreen(),
        'details':(context) => const DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
        // ignore: deprecated_member_use
        backgroundColor: Colors.red,
        appBarTheme: const AppBarTheme(
          color: Colors.red
        )
      ), 
    );
  }
}
