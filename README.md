# Erobot-App
Start date: 24 July, 2020

Welcome to Open Source Project.
Erobot is designed to control Arduino robot via Bluetooth. Even though, this app is still developing using Flutter. 

5 Functions of the app are:
- Arduino Documents : How to build robots
- Sender : Send string or character to Arduino via bluetooth
- Ball Shooter : A controller to control ball shooter robot, servo, and speed
- Arduino Car : A controller to controll Arduino car and spead
- IR Remote : Vitual IR Remote via Bluetooth.

Prototype and design here: https://www.figma.com/file/x1edWP3L1by9QWuI5EVUiP/E-Robot-App?node-id=0%3A1

# Structure
main.dart

screens/

- arduino_doc/arduin.doc.dart        //Arduino Documents (function page)
- sender/sender.dart                 //Sender function page (function page)
- controller/ball_shooter.dart       //Ball Shooter Controller (function page)
- controller/arduino_car.dart        //Arduino Car Controller (function page)
- ir_remoter/ir_remoter.dart         //IR Remoter (function page)

- login_page/log_choice.dart         //Ask user Login or Register page 
- login_page/login                   //Login page

- drawer_bar/aboutus.dart            //About us
- drawer_bar/feedback.dart           //Feedback

- supplier/widget_supplier.dart      //Store reusable widget 




 
 
 
