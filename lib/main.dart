import 'package:flutter/material.dart';
import 'package:login_task/login_page.dart';
import 'package:login_task/login_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LoginController(),
            child: LoginPage(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Login Task',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: LoginPage(),
        ));
  }
}
