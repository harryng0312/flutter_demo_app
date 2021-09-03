import 'package:flutter/material.dart';
import 'package:learning_flutter/state1/drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:learning_flutter/state1/model/ui.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Settings'),
      ),
      drawer: DrawerMenu(),
      // body: Consumer<UI>(builder: (context, ui, child) {
      //   return Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Padding(
      //         padding: EdgeInsets.only(left: 20, top: 20),
      //         child: Text(
      //           'Font Size: ${ui.fontSize.toInt()}',
      //           style: TextStyle(
      //               fontSize: Theme.of(context).textTheme.headline5!.fontSize),
      //         ),
      //       ),
      //       Slider(
      //           min: 0.5,
      //           value: ui.sliderFontSize,
      //           onChanged: (newValue) {
      //             ui.fontSize = newValue;
      //           }),
      //     ],
      //   );
      // }),

      body: Builder(builder: (context) {
        UI ui = Provider.of<UI>(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Font Size: ${ui.fontSize.toInt()}',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline5!.fontSize),
              ),
            ),
            // Consumer<UI>(
              // builder: (context, ui, child) {
                Slider(
                    min: 0.5,
                    value: ui.sliderFontSize,
                    onChanged: (newValue) {
                      ui.fontSize = newValue;
                    })
              // },
            // )
          ],
        );
      }),
      // worked but not update the slider
      // body: Builder(builder: (context) {
      //   UI ui = Provider.of<UI>(context);
      //   GlobalKey sliderKey = GlobalKey();
      //   return Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Padding(
      //         padding: EdgeInsets.only(left: 20, top: 20),
      //         child: Text(
      //           'Font Size: ${ui.fontSize.toInt()}',
      //           style: TextStyle(
      //               fontSize:
      //                   Theme.of(context).textTheme.headline5!.fontSize),
      //         ),
      //       ),
      //       Slider(
      //           key: sliderKey,
      //           min: 0.5,
      //           value: ui.sliderFontSize,
      //           onChanged: (newValue) {
      //             ui.fontSize = newValue;
      //           }),
      //     ],
      //   );
      // })
    );
  }
}
