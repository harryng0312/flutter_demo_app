import 'package:flutter/material.dart';
import 'package:learning_flutter/theme/Theme.dart';
import 'package:provider/provider.dart';

// import 'package:learning_flutter/common/theme.dart';
import 'package:learning_flutter/state/model/cart.dart';
import 'package:learning_flutter/state/model/catalog.dart';
import 'package:learning_flutter/state/screen/cart.dart';
import 'package:learning_flutter/state/screen/catalog.dart';
import 'package:learning_flutter/state/screen/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
        // ChangeNotifierProvider<CartModel>(create: (context) => CartModel())
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: ThemeUtil.defaultThemeData,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
