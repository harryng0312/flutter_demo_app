import 'package:flutter/material.dart';
import 'package:learning_flutter/write_file/screen/dog_home_page.dart';
import 'package:learning_flutter/write_file/util/file_storage_util.dart';
import 'package:learning_flutter/theme/Theme.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget app = MultiProvider(
      providers: [
        Provider(create: (_) => FileStorageUtil.getInstance()),
        // ChangeNotifierProvider(create: (_) => SqliteUtil.getInstance()),
      ],
      child: GestureDetector(
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
      ),
    );
    return app;
  }
}
