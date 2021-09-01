import 'package:flutter/material.dart';

Widget MyApp() {
  return MaterialApp(home: App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<App> {
  @override
  Widget build(BuildContext context) {
    TextEditingController unameController = TextEditingController();
    TextEditingController passwdController = TextEditingController();
    unameController.clear();
    unameController.addListener(() {
      print("Username: ${unameController.text}");
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter TextField Example'),
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                    // onChanged: (value) => print("Username: ${value}"),
                    controller: unameController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                    ),
                    // onChanged: (value) => print("Password: ${value}"),
                    controller: passwdController,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: Text('Sign In'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Alert Message"),
                          // Retrieve the text which the user has entered by
                          // using the TextEditingController.
                          content: Text(unameController.text),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            )));
  }
}
