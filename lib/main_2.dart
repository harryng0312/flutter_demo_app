import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  Widget rsStateful = Scaffold(
    appBar: AppBar(
      title: Text('title'),
    ),
    body: Center(
        child:
        Text(
          'Hello World',
        )
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {  },
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
  );
  // runApp(rsStateful);
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String title = "Hellow world app";
    // StatefulWidget statefulScaffold = Scaffold(
    //   appBar: AppBar(
    //     title: Text(title),
    //   ),
    //   body: Center(
    //       child:
    //       Text(
    //         'Hello World',
    //       )
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     child: Icon(Icons.add),
    //     onPressed: () {  },
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    //   floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    // );
    // StatefulWidget materialApp = MaterialApp(
    //   title: 'Hello World Demo Application',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   // home: MyHomePage(title: 'Home page'),
    //   home: statefulScaffold,
    // );
    // return materialApp;
    StatelessWidget myHomePage = MyHomePage(title: title);
    // return myHomePage;

    StatefulWidget materialApp = MaterialApp(
      title: 'Hello World Demo Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Home page'),
      home: myHomePage,
    );
    return materialApp;

  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  // @override
  // _MyHomePageState createState() => _MyHomePageState();
  @override
  Widget build(BuildContext context) {
    // return the size of widget
    Size size = MediaQuery.of(context).size;
    Widget rs = Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {  },
        ),
        title: Text(this.title),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
              // shape: MaterialStateProperty.all(CircleBorder(side: BorderSide(color: Colors.transparent)))
              shape: MaterialStateProperty.all(CircleBorder(side: BorderSide.none)),
              shadowColor: MaterialStateProperty.all(Colors.transparent)
            ),
            child: Text("Save"),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
          child:
          Text(
            'Hello World',
          )
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: IconButton(icon: Icon(Icons.home), onPressed: () {  },),),
            Expanded(child: IconButton(icon: Icon(Icons.show_chart), onPressed: () {  },),),
            Expanded(child: new Text(''), ),
            // Expanded(child: ExpansionPanel( ),),
            Expanded(child: IconButton(icon: Icon(Icons.tab), onPressed: () {  },),),
            Expanded(child: IconButton(icon: Icon(Icons.settings), onPressed: () {  },),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {  },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
    // Widget material = MaterialApp(home: rs);
    // return material;
    return rs;
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
