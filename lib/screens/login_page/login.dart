import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    nameInput(),
                    SizedBox(
                      height: 16,
                    ),
                    emailInput(),
                    SizedBox(
                      height: 16,
                    ),
                    passwordInput(),
                    SizedBox(
                      height: 16,
                    ),
                    submitButton(),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  String _username, _email, _password = "";
  Widget nameInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "e.g Morgan",
      ),
      textInputAction: TextInputAction.next,
      validator: (name) {
        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(name))
          return 'Invalid username';
        else
          return null;
      },
      onSaved: (name) => _username = name,
    );
  }

  Widget emailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "e.g abc@gmail.com",
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget passwordInput() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: Icon(Icons.lock),
      ),
      textInputAction: TextInputAction.done,
    );
  }

  RaisedButton submitButton() {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
        }
        print('$_username, $_password, $_email');
      },
      child: Text(
        "Submit",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
