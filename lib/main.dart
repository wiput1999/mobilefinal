import 'package:flutter/material.dart';
import 'package:mobilefinal/ui/friend_page.dart';
import 'package:mobilefinal/ui/home_page.dart';
import 'package:mobilefinal/ui/login_page.dart';
import 'package:mobilefinal/ui/profile_page.dart';
import 'package:mobilefinal/ui/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(120, 144, 156, .1),
      100: Color.fromRGBO(120, 144, 156, .2),
      200: Color.fromRGBO(120, 144, 156, .3),
      300: Color.fromRGBO(120, 144, 156, .4),
      400: Color.fromRGBO(120, 144, 156, .5),
      500: Color.fromRGBO(120, 144, 156, .6),
      600: Color.fromRGBO(120, 144, 156, .7),
      700: Color.fromRGBO(120, 144, 156, .8),
      800: Color.fromRGBO(120, 144, 156, .9),
      900: Color.fromRGBO(120, 144, 156, 1),
    };

    MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

    return MaterialApp(
      title: 'Mobile Final',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/profile": (context) => ProfilePage(),
        "/friend": (context) => FriendPage(),
      },
    );
  }
}
