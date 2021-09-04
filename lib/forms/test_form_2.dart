import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/user.dart';

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
  FocusNode fNodeTxtPhoneNumber = new FocusNode();
  FocusNode fNodeTxtDob = new FocusNode();

  // FocusScope.of(context).requestFocus(fNodeTxtUsername);
  TextEditingController txtNameCtrl = new TextEditingController();
  TextEditingController txtPhoneCtrl = new TextEditingController();
  TextEditingController txtDobCtr = new TextEditingController();

  User? user = null;

  @override
  void initState() {
    super.initState();
    user = User(name: "", phoneNumber: "", dob: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    this.setState(() {});
    Widget form = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: txtNameCtrl,
            focusNode: fNodeTxtUsername,
            validator: (value) {
              String? rs;
              if (value == null || value.isEmpty) {
                rs = 'Name is required';
              }
              return rs;
            },
            onSaved: (value) {
              this.user!.name = value!;
            },
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
          ),
          TextFormField(
            controller: txtPhoneCtrl,
            focusNode: fNodeTxtPhoneNumber,
            validator: (value) {
              String? rs;
              String phoneNoPattern = r"^[0-9]{9,12}$";
              RegExp regex = RegExp(phoneNoPattern);
              if (value == null || value.trim().isEmpty) {
                rs = "Phone number is required";
              } else if (!regex.hasMatch(value)) {
                rs = "Phone number is not correct";
              }
              return rs;
            },
            onSaved: (value) => user!.phoneNumber = value!,
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
            validator: (value) {
              String? rs;
              if (value == null || value.trim().isEmpty) {
                rs = "Dob is required";
              }else {
                DateTime? dob;
                try {
                  String tmp = DateFormat('yyyy/MM/dd').format(
                      DateFormat("yyyy/MM/dd").parse(value));
                  if (tmp == value) {
                    dob = DateFormat("y/M/d").parse(value);
                  } else {
                    rs = "Dob is invalid";
                  }
                } on FormatException {
                  rs = "Dob is not correct";
                }
              }
              return rs;
            },
            onSaved: (value) =>
                user!.dob = DateFormat("yyyy/MM/dd").parse(value!),
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Enter your date of birth, format: yyyy/MM/dd',
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
                txtDobCtr.text = value;
                // txtDobCtr.value = TextEditingValue(
                //   text: value,
                //   selection: TextSelection.fromPosition(
                //     TextPosition(offset: value.length),
                //   ),
                // );
                // print("Dob: ${txtDobCtr.text}");
              }
            },
          ),
          new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: new ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print("Username: ${user!.name}\nPhone No: ${user!.phoneNumber}"
                        "\nDob: ${DateFormat("yyyy/MM/dd").format(user!.dob)}");
                  }
                },
              )),
        ],
      ),
    );
    return form;
  }
}
