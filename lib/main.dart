import 'package:erobot_app/service/auth_service.dart';
// import 'package:erobot_app/widgets/page_transition.dart';
import 'package:provider/provider.dart';
import 'config/palette.dart';
import 'package:erobot_app/import/screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    StreamProvider<CustomUser>.value(
        value: AuthService().user,
        builder: (context, snapshot) {
          return MaterialApp(
            builder: (context, navigator) {
              var lang = Localizations.localeOf(context).languageCode;
              return Theme(
                data: ThemeData(
                  fontFamily: lang == 'kh' ? 'Hanuman' : 'Raleway',
                  primarySwatch: Palette.appbar,
                  canvasColor: Palette.background,
                ),
                child: navigator,
              );
            },
            theme: ThemeData(
              primarySwatch: Palette.appbar,
              canvasColor: Palette.background,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              '/loginP': (context) => LoginPage(),
              '/farm_assistant': (context) => FarmAssistant(),
              '/sender': (context) => Sender(),
              '/ir_remote': (context) => IrRemoter(),
              '/feedback': (context) => FeedbackApp(),
              '/joinus': (context) => JoinUs()
            },
          );
        }),
  );
}
