
import 'package:flutter/material.dart';
import 'package:learning_flutter/multimedia/video_player/video_player_screen.dart';
import 'package:learning_flutter/sqlite/util/sqlite_util.dart';
import 'package:learning_flutter/theme/Theme.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget app = MultiProvider(
      providers: [
        Provider(create: (_) => SqliteUtil.getInstance()),
        // ChangeNotifierProvider(create: (_) => SqliteUtil.getInstance()),
      ],
      child: GestureDetector(
        child: MaterialApp(
          theme: ThemeUtil.defaultThemeData,
          initialRoute: '/',
          routes: {'/': (ctx) => VideoPlayerScreen()},
        ),
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
      ),
    );
    return app;
  }
}
