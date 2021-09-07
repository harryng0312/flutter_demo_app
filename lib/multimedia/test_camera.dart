import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/multimedia/video_player/video_player_screen.dart';
import 'package:learning_flutter/sqlite/util/sqlite_util.dart';
import 'package:learning_flutter/theme/Theme.dart';
import 'package:provider/provider.dart';

import 'camera/take_picture_screen.dart';

class MyApp extends StatelessWidget {
  late List<CameraDescription> cameras;
  late CameraDescription firstCamera;

  MyApp();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await availableCameras().then((value) {
      cameras = value;
      return cameras;
    }).then((value) {
      firstCamera = value.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget app = MultiProvider(
      providers: [
        Provider(create: (_) => SqliteUtil.getInstance()),
        // ChangeNotifierProvider(create: (_) => SqliteUtil.getInstance()),
      ],
      child: GestureDetector(
        child: MaterialApp(
          theme: ThemeData.dark(), //ThemeUtil.defaultThemeData,
          initialRoute: '/',
          routes: {'/': (ctx) => TakePictureScreen(camera: firstCamera,)},
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
