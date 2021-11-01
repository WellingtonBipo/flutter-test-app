import 'package:app_teste_tecnio_wk/view/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Teste Tecnico WK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          appBarTheme: AppBarTheme(color: Colors.indigo.shade900)),
      home: const HomeView(),
    );
  }
}
