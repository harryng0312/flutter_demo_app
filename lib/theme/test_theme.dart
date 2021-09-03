import 'package:flutter/material.dart';
import 'package:learning_flutter/theme/Theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeUtil.defaultThemeData,
      home: MyThemePage(),
    );
  }
}

class MyThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Theme Example'),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).accentColor,
          child: Text(
            'Themes contains the graphical appearances that makes the user interface more attractive.',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
      floatingActionButton: Theme(
        // data: Theme.of(context).copyWith(
        //   colorScheme:
        //       Theme.of(context).colorScheme.copyWith(secondary: Colors.blue),
        data: Theme.of(context),
        child: FloatingActionButton(
          foregroundColor: ThemeUtil.extStyle.btnFltForegroundColor,
          onPressed: () {},
          child: Icon(Icons.person),
        ),
      ),
    );
  }
}
