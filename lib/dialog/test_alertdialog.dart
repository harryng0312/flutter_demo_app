import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Flutter Basic Alert Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyAlert(),
      ),
    );
  }
}

class MyAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: Text('Show alert'),
        onPressed: () async {
          String? result = await showAlertDialog(context);
          print("Dialog result: ${result??'null'}");
        },
      ),
    );
  }
}

Future<String?> showAlertDialog(BuildContext context) {
  // Create button
  Widget btnOk = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop("ok");
    },
  );
  Widget btnCancel = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop("cancel");
    },
  );
  // Create AlertDialog
  AlertDialog alertDialog = AlertDialog(
    title: Text("Simple Alert"),
    content: Text("This is an alert message."),
    actions: [
      btnOk,
      btnCancel
    ],
  );

  // show the dialog
  return showDialog<String>(
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}
