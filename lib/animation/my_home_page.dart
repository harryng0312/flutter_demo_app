import 'package:flutter/material.dart';

import 'product.dart';
import 'product_box.dart';
import 'product_page.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({required this.title, required this.animation});

  final String title;
  final Animation<double> animation;
  final items = Product.getProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Product Navigation")),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return FadeTransition(
                opacity: animation,
                child: GestureDetector(
                  child: ProductBox(item: items[index]),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductPage(item: items[index]),
                      ),
                    );
                  },
                ));
          },
        ));
  }
}
