import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:erobot_app/validation/validation.dart';
import 'package:erobot_app/import/importall.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class JoinUs extends StatefulWidget {
  @override
  _JoinUsState createState() => _JoinUsState();
}

class _JoinUsState extends State<JoinUs> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  var _filepath = '0';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
      body: KeyboardAvoider(
        autoScroll: true,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            Material(
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Raleway',
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Want to be a member?',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Please enter your info',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
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
                            InputStyle(
                              weight: 0.55,
                              labelText: 'First Name',
                              validator: (val) {
                                RequestMember.firstName = val;
                                return val.isEmpty
                                    ? 'Enter your first name'
                                    : null;
                              },
                            ),
                            SizedBox(height: 10),
                            //LAST NAME INPUT
                            InputStyle(
                              weight: 0.55,
                              labelText: 'Last Name',
                              validator: (val) {
                                RequestMember.lastName = val;
                                return val.isEmpty
                                    ? 'Enter your last name'
                                    : null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        //IMAGE PICKER
                        buildImagePciker(),
                      ],
                    ),
                    SizedBox(height: 10),

                    //EMAIL INPUT
                    InputStyle(
                      labelText: 'Enter your email address',
                      validator: (val) {
                        RequestMember.email = val;
                        return validateEmail(val);
                      },
                    ),
                    SizedBox(height: 10),
                    //INTRODUCING INPUT
                    InputStyle(
                      labelText: 'Please introduces yourself',
                      validator: (val) {
                        RequestMember.memberInfo = val;
                        return val.isEmpty
                            ? 'Please introduces yourself'
                            : null;
                      },
                    ),
                    SizedBox(height: 10),

                    //WHY JOIN INPUT
                    InputStyle(
                      labelText: 'Why do you want to join us?',
                      validator: (val) {
                        RequestMember.whyJoin = val;
                        return val.isEmpty
                            ? 'Please answer the question'
                            : null;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    SizedBox(height: 10),
                    //SUBMIT BUTTON
                    Center(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Palette.blue_pacific),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          splashColor: Color.fromRGBO(255, 255, 255, .2),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              print(
                                'Entered validation: \nFirstName: ${RequestMember.firstName}\nLastName: ${RequestMember.lastName}\nEmail: ${RequestMember.email}\nIntroduces: ${RequestMember.memberInfo}\nWhyJoin: ${RequestMember.whyJoin}',
                              );
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

  CircleAvatar buildImagePciker() {
    return CircleAvatar(
      backgroundColor: Palette.blue_pacific,
      radius: 55,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 50,
        backgroundImage: _filepath != '0' ? FileImage(File(_filepath)) : null,
        child: GestureDetector(
          onTap: () async {
            var filepath = await FilePicker.getFilePath(type: FileType.image);
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
                  backgroundColor: Color.fromRGBO(255, 255, 255, .5),
                  child: Icon(
                    Icons.camera_alt,
                    color: Palette.blue_pacific,
                    size: 35,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
