import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Login')),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Enter your email address",
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.6)),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 5, 20, 10),
                              ),
                              validator: (val) {
                                _email = val;
                                return validateEmail(val);
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    isDense: false,
                                    labelText: "Enter your password",
                                    labelStyle: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.6)),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 0, 10),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: IconButton(
                                          onPressed: _toggle,
                                          icon: Icon(_obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off)),
                                    ),
                                  ),
                                  validator: (val) {
                                    _password = val;
                                    return validatePassword(val);
                                  },
                                  obscureText: _obscureText,
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Hexcolor('03a0b0')),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        splashColor: Color.fromRGBO(255, 255, 255, .2),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print(
                                'Entered validation\nemail: $_email\npassword: $_password');
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: GestureDetector(
                      child: Text(
                        'Forgotten Password?',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        print('forgot pass clicked!');
                      },
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  'Or login with social account',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              splashColor: Colors.white,
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/graphics/google-logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              onTap: () {
                                print('google login clicked!');
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ClipOval(
                          child: Material(
                            color: Hexcolor('386fde'),
                            child: InkWell(
                              splashColor: Colors.white,
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Center(
                                    child: FaIcon(FontAwesomeIcons.facebookF,
                                        size: 20, color: Colors.white)),
                              ),
                              onTap: () {
                                print('facebook login clicked!');
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);
  print(value);
  if (value.isEmpty)
    return 'Please enter your email address';
  else {
    if (!regex.hasMatch(value))
      return 'Please enter a valid email address';
    else
      return null;
  }
}

String validatePassword(String value) {
  RegExp capiltalLetter = RegExp(r'^(?=.*[A-Z])');
  RegExp lowerCase = RegExp(r'(?=.*[a-z])');
  RegExp oneDigit = RegExp(r'(?=.*?[0-9])');
  RegExp specialChar = RegExp(r'(?=.*?[!@#\$&*~])');
  RegExp eightDigit = RegExp(r'.{8,}');

  Pattern pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);

  print(value);
  if (value.isEmpty) {
    return 'Please enter your password';
  } else {
    if (!capiltalLetter.hasMatch(value))
      return 'Should contain at least one upper case';
    else if (!lowerCase.hasMatch(value))
      return 'Should contain at least one lower case';
    else if (!oneDigit.hasMatch(value))
      return 'Should contain at least one digit';
    else if (!specialChar.hasMatch(value))
      return 'Should contain at least one Special character';
    else if (!eightDigit.hasMatch(value))
      return 'Should at least 8 characters';
    else if (!regex.hasMatch(value))
      return 'Enter valid password';
    else
      return null;
  }
  // r'^
  // (?=.*[A-Z])       // should contain at least one upper case
  // (?=.*[a-z])       // should contain at least one lower case
  // (?=.*?[0-9])          // should contain at least one digit
  // (?=.*?[!@#\$&*~]).{8,}  // should contain at least one Special character
  // $
}
