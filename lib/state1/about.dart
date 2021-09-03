import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:learning_flutter/state1/drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:learning_flutter/state1/model/ui.dart';

class About extends StatelessWidget {
  String text = lorem(paragraphs: 3, words: 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerMenu(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        // child: Consumer<UI>(
        //   builder: (context, ui, child) {
        //     return RichText(
        //       text: TextSpan(
        //         text: text,
        //         style:
        //             TextStyle(fontSize: ui.fontSize, color: Colors.lightBlue),
        //       ),
        //     );
        //   },
        // ),
        child: RichText(
          text: TextSpan(
            text: text,
            style: TextStyle(fontSize: Provider.of<UI>(context).fontSize, color: Colors.lightBlue)
          ),
        ),
      ),
    );
  }
}
