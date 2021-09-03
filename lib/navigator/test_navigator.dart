import 'package:flutter/material.dart';

import 'my_home_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Product Navigation demo home page'),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Product Navigation demo home page')
      },
    );
  }
}