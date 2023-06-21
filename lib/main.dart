import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/home_page.dart';
import 'Api/Api_news.dart';
import 'pages/favourite_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/home_page': (context) => HomePage(),
        '/favourite_page': (context) => FavouritePage(),
      },
      title: 'My App',
      home:  HomePage(),
    );
  }
}
