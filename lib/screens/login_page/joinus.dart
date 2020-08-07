import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:erobot_app/validation/validation.dart';
import 'package:erobot_app/object_class/classes.dart';
import 'package:file_picker/file_picker.dart';

class JoinUs extends StatefulWidget {
  @override
  _JoinUsState createState() => _JoinUsState();
}

class _JoinUsState extends State<JoinUs> {
  final _formKey = GlobalKey<FormState>();
  var _filepath = '0';

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Join Us',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              'Want to be a member?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              'Please enter your info',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //FIRST NAME INPUT
                            Container(
                              width: MediaQuery.of(context).size.width * 0.55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.only(bottom: 5),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "First Name",
                                    labelStyle: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.6)),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 20, 0)),
                                validator: (val) {
                                  RequestMember.firstName = val;
                                  if (val.isEmpty)
                                    return 'Enter your first name';
                                  else
                                    return null;
                                },
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //LAST NAME INPUT
                            Container(
                              width: MediaQuery.of(context).size.width * 0.55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.only(bottom: 5),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Last name',
                                    labelStyle: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.6)),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 20, 0)),
                                validator: (val) {
                                  RequestMember.lastName = val;
                                  if (val.isEmpty)
                                    return 'Enter your last name';
                                  else
                                    return null;
                                },
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        //IMAGE PICKER
                        CircleAvatar(
                          backgroundColor: Hexcolor('03a0b0'),
                          radius: 55,
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              backgroundImage: FileImage(File(_filepath)),
                              child: GestureDetector(
                                onTap: () async {
                                  var filepath = await FilePicker.getFilePath(
                                      type: FileType.image);
                                  if (filepath != null) {
                                    setState(() {
                                      _filepath = filepath;
                                    });
                                  }
                                  print(_filepath);
                                },
                                child: _filepath == '0'
                                    ? CircleAvatar(
                                        radius: 55,
                                        backgroundColor:
                                            Color.fromRGBO(255, 255, 255, .5),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Hexcolor('03a0b0'),
                                          size: 35,
                                        ),
                                      )
                                    : null,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    
                    //EMAIL INPUT
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Enter your email address',
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 20, 0)),
                        validator: (val) {
                          RequestMember.email = val;
                          return validateEmail(val);
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 10),

                    //INTRODUCING INPUT
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Please introduces yourself',
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 20, 0)),
                        validator: (val) {
                          RequestMember.memberInfo = val;
                          if (val.isEmpty)
                            return 'Please introduces yourself';
                          else
                            return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                    SizedBox(height: 10),

                    //WHY JOIN INPUT
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Why do you want to join us?',
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 20, 0)),
                        validator: (val) {
                          RequestMember.whyJoin = val;
                          if (val.isEmpty)
                            return 'Please answer the question';
                          else
                            return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                    SizedBox(height: 10),
                    
                    //SUBMIT BUTTON
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
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              print(
                                  'Entered validation: \nFirstName: ${RequestMember.firstName}\nLastName: ${RequestMember.lastName}\nEmail: ${RequestMember.email}\nIntroduces: ${RequestMember.memberInfo}\nWhyJoin: ${RequestMember.whyJoin}');
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            //LAST MESSAGE
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(
                'Your applicant will be reviewed by our team leader within 7 days',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
