import 'package:flutter/material.dart';
// import 'input/test_textfield.dart';
// import 'animation/test_animation.dart';
// import 'theme/test_theme.dart';
// import 'state1/test_state.dart';
// import 'localization/test_localization_2.dart';
// import 'state/test_state.dart';
// import 'forms/test_form_2.dart';
// import 'sqlite/test_sqlite.dart';
// import 'write_file/test_file_storage.dart';
// import 'multimedia/test_video_player.dart';
import 'multimedia/test_camera.dart';

Future<void> main() async {
  MyApp app = MyApp();
  await app.init();
  runApp(app);
}
