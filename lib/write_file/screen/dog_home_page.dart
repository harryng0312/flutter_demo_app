import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learning_flutter/write_file/controller/dog_controller.dart';

class DogHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DogHomePageState();
}

class _DogHomePageState extends State<DogHomePage> {
  late DogController dogController = DogController(state: this);

  @override
  Widget build(BuildContext context) {
    dogController.context = context;
    return Scaffold(
        body: CustomScrollView(slivers: [
      PreferredSize(
        preferredSize: Size.fromHeight(140.0), // not affected
        child: SliverAppBar(
          // title: Text('Dog Home page'),
          floating: true,
          pinned: true,
          expandedHeight: 90,
          elevation: 20,
          // flexibleSpace: buildFlexibleSpace(),
          flexibleSpace: buildFlexibleSpaceTransform(),
          leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: dogController.refreshDataHandler,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.add), onPressed: dogController.addDogHandler),
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: dogController.removeDogHandler),
          ],
        ),
      ),
      StatefulBuilder(
          key: dogController.pnlResultKey,
          builder: (context, setState) {
            Widget widget;
            if (dogController.lsSearchDog.length > 0) {
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
                                  child: Text(
                                      'ID:${dogController.lsSearchDog[index].id}'))
                            ]),
                            Row(children: [
                              Expanded(
                                  child: Text(
                                      'Name:${dogController.lsSearchDog[index].name}'))
                            ]),
                            Row(children: [
                              Expanded(
                                  child: Text(
                                      'Age:${dogController.lsSearchDog[index].age}'))
                            ]),
                          ]),
                        ),
                      );
                    },
                    // Builds 1000 ListTiles
                    childCount: dogController.lsSearchDog.length,
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

  Widget buildFlexibleSpace() {
    return FlexibleSpaceBar(
      background: Column(children: [
        SizedBox(height: 100.0),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Container(
            height: 30.0,
            child: TextSelectionGestureDetector(
              child: TextField(
                controller: dogController.txtSearchCtr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.clear),
                      onPressed: dogController.refreshDataHandler,
                    ),
                    // border: InputBorder.none,
                    // focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 13),
                    hintText: "Search"),
                onChanged: dogController.searchDogHandler,
                onSubmitted: dogController.searchDogHandler,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildFlexibleSpaceTransform() {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);
        final fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        return Stack(
          children: [
            Center(
              child: Opacity(
                  opacity: 1 - opacity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      dogController.txtSearchCtr.text.isNotEmpty?
                          dogController.txtSearchCtr.text:
                        "count of dog: ${dogController.lsSearchDog.length}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
            Opacity(
              opacity: opacity,
              child: buildFlexibleSpace(),
            ),
          ],
        );
      },
    );
  }
}
