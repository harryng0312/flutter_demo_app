import 'package:flutter/material.dart';
import 'package:learning_flutter/sqlite/screen/dog_home_page.dart';
import 'package:learning_flutter/theme/Theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget app = GestureDetector(
      child: MaterialApp(
        theme: ThemeUtil.defaultThemeData,
        initialRoute: '/',
        routes: {'/': (ctx) => DogHomePage()},
      ),
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
    );
    return app;
  }
}
