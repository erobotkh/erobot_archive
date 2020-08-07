import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:erobot_app/validation/validation.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  //OBSCURE IS USE FOR SHOW/HIDE PASSWORD
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
        'Login',
        style: TextStyle(fontSize: 18),
      )),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ' Welcome back mate!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  //FORM
                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          //EMAIL INPUT
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(bottom: 5),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Enter your email address",
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.6)),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 5, 20, 0),
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

                          //PASSWORD INPUT
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(bottom: 5),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: false,
                                    labelText: "Enter your password",
                                    labelStyle: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.6)),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 20, 0),
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
                      width: MediaQuery.of(context).size.width,
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
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print('Entered $_email & $_password');
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
            //SOCIAL LOGIN
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
                        //LOGIN WITH GOOGLE
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
                        //LOGIN WITH FACEBOOK
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
