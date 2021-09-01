import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Flutter Form Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

// Build a Form widget using the _formKey created above.
  FocusNode fNodeTxtUsername = new FocusNode();
  FocusNode fNodeTxtPasswd = new FocusNode();
  FocusNode fNodeTxtDob = new FocusNode();

  // FocusScope.of(context).requestFocus(fNodeTxtUsername);
  TextEditingController txtNameCtrl = new TextEditingController();
  TextEditingController txtPhoneCtrl = new TextEditingController();
  TextEditingController txtDobCtr = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: txtNameCtrl,
            focusNode: fNodeTxtUsername,
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
          ),
          TextFormField(
            controller: txtPhoneCtrl,
            focusNode: fNodeTxtPasswd,
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Enter a phone number',
              labelText: 'Phone',
            ),
            keyboardType: TextInputType.phone,
          ),
          TextFormField(
            controller: txtDobCtr,
            focusNode: fNodeTxtDob,
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Enter your date of birth, format: dd/MM/yyyy',
              labelText: 'Dob',
            ),
            keyboardType: TextInputType.datetime,
            onTap: () async {
              DateTime? dt = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 30)),
                lastDate: DateTime.now().add(Duration(days: 30)),
              );
              if (dt != null) {
                // FocusScope.of(context).requestFocus(fNodeTxtDob);
                String value = DateFormat('yyyy/MM/dd').format(dt);
                // txtDobCtr.text = DateFormat('yyyy/MM/dd').format(dt);
                txtDobCtr.value = TextEditingValue(
                  text: value,
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: value.length),
                  ),
                );
                print("Dob: ${txtDobCtr.text}");
              }
            },
          ),
          new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: new ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  _formKey.currentState!.save();
                },
              )),
        ],
      ),
    );
  }
}
