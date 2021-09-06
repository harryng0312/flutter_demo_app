import 'package:flutter/material.dart';
import 'package:learning_flutter/state1/home.dart';
import 'package:learning_flutter/state1/about.dart';
import 'package:learning_flutter/state1/settings.dart';
import 'package:provider/provider.dart';
import 'package:learning_flutter/state1/model/ui.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => UI()),
        // ChangeNotifierProvider(create: (context) => UI()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/about': (context) => About(),
          '/settings': (context) => Settings(),
        },
      ),
    );
  }
}