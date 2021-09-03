import 'package:flutter/material.dart';

import 'product.dart';
import 'rating_box.dart';

class ProductPage extends StatefulWidget {
  ProductPage({required this.item});

  final Product item;

  @override
  State<StatefulWidget> createState() => _ProductPageState(item: this.item);
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  _ProductPageState({required this.item});

  final Product item;
  late Animation<Offset> slideTransitionAnimation;
  late Animation<double> sizeTransitionAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    slideTransitionAnimation = Tween(begin: Offset(1.1, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.easeInBack));
    sizeTransitionAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    // sizeTransitionAnimation = CurvedAnimation(
    //   parent: animationController,
    //   curve: Curves.fastOutSlowIn,
    // );
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return SlideTransition(
        position: slideTransitionAnimation,
        child: SizeTransition(
            sizeFactor: sizeTransitionAnimation,
            child: Scaffold(
              appBar: AppBar(
                leading: ElevatedButton(
                  // icon: Icon(Icons.arrow_back),
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(CircleBorder())),
                  child: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(this.item.name),
              ),
              body: Center(
                child: Container(
                  padding: EdgeInsets.all(0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset("assets/images/" + this.item.image),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(this.item.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(this.item.description),
                                    Text(
                                        "Price: " + this.item.price.toString()),
                                    RatingBox(),
                                  ],
                                )))
                      ]),
                ),
              ),
            )));
  }
}
