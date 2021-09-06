import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:learning_flutter/theme/Theme.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/dog.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget app = GestureDetector(
      child: MaterialApp(
        theme: ThemeUtil.defaultThemeData,
        initialRoute: '/',
        routes: {'/': (ctx) => MyHomePage()},
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

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Dog> lsDataDog = [];
  List<Dog> lsSearchDog = List.empty(growable: true);
  GlobalKey pnlResultKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    TextEditingController txtSearchCtr = TextEditingController();
    ValueChanged<String>? searchDog = (String text) {
      // setState(() {
      List<Dog> rs = List.empty(growable: false);
      if (text.isNotEmpty) {
        rs = lsDataDog
            .where((element) =>
                element.name.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
      lsSearchDog.clear();
      lsSearchDog.addAll(rs);
      // });
    };
    VoidCallback? refreshData = () {
      pnlResultKey.currentState!.setState(() {
        txtSearchCtr.clear();
        lsSearchDog.clear();
        lsSearchDog.addAll(lsDataDog);
      });
    };
    return Scaffold(
        body: CustomScrollView(slivers: [
      PreferredSize(
          preferredSize: Size.fromHeight(140.0), // not affected
          child: SliverAppBar(
            title: Text('Dog list'),
            floating: true,
            pinned: true,
            expandedHeight: 90,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(children: [
                SizedBox(height: 100.0),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Container(
                    height: 30.0,
                    child: TextSelectionGestureDetector(
                      child: TextField(
                        controller: txtSearchCtr,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              iconSize: 20,
                              icon: Icon(Icons.clear),
                              onPressed: refreshData,
                            ),
                            // border: InputBorder.none,
                            // focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 13),
                            hintText: "Search"),
                        onChanged: (text) {
                          pnlResultKey.currentState!.setState(() {
                            searchDog(text);
                          });
                        },
                        onSubmitted: (text) {
                          pnlResultKey.currentState!.setState(() {
                            searchDog(text);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            leading: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: refreshData,
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      // add a new Dog
                      int id = DateTime.now().millisecondsSinceEpoch;
                      String name = lorem(paragraphs: 1, words: 1);
                      Random rand = Random();
                      int age = rand.nextInt(100);
                      Dog dog = Dog(id: id, name: name, age: age);
                      lsDataDog.add(dog);
                      refreshData();
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (lsDataDog.length > 0) {
                        txtSearchCtr.clear();
                        lsDataDog.removeLast();
                        refreshData();
                      }
                    });
                  }),
            ],
          )),
      StatefulBuilder(
          key: pnlResultKey,
          builder: (context, setState) {
            Widget widget;
            if (lsSearchDog.length > 0) {
              widget = SliverPadding(
                padding: EdgeInsets.zero,
                sliver: SliverList(
                  // Use a delegate to build items as they're scrolled on screen.
                  delegate: SliverChildBuilderDelegate(
                    // The builder function returns a ListTile with a title that
                    // displays the index of the current item.
                    (context, index) {
                      return Card(
                        shadowColor: Colors.transparent,
                        margin: EdgeInsets.only(
                            left: 1, top: 1, right: 1, bottom: 0),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Colors.cyan),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   shape: BoxShape.rectangle,
                          //   border: Border.all(color: Colors.cyan)
                          // ),
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.zero,
                          child: Column(children: [
                            Row(children: [
                              Expanded(
                                  child: Text('ID:${lsSearchDog[index].id}'))
                            ]),
                            Row(children: [
                              Expanded(
                                  child:
                                      Text('Name:${lsSearchDog[index].name}'))
                            ]),
                            Row(children: [
                              Expanded(
                                  child: Text('Age:${lsSearchDog[index].age}'))
                            ]),
                          ]),
                        ),
                      );
                    },
                    // Builds 1000 ListTiles
                    childCount: lsSearchDog.length,
                  ),
                ),
              );
            } else {
              widget = SliverToBoxAdapter(
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(child: Text('Record is not found')))
                    ],
                  ),
                ),
              );
            }
            return widget;
          }),
    ]));
  }
}
