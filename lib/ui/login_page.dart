import 'package:flutter/material.dart';
import 'package:mobilefinal/db/user_db.dart';
import 'package:mobilefinal/utils/current_user.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  UserUtils user = UserUtils();
  final userid = TextEditingController();
  final password = TextEditingController();
  bool isValid = false;
  int formState = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 30, 0),
          children: <Widget>[
            Image.network(
              "http://www.nationmultimedia.com/img/news/2014/07/27/30239586/30239586-01.jpg",
              width: 200,
              height: 200,
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: "User Id",
                  icon: Icon(Icons.account_box, size: 40, color: Colors.grey),
                ),
                controller: userid,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isNotEmpty) {
                    this.formState += 1;
                  }
                }),
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                  icon: Icon(Icons.lock, size: 40, color: Colors.grey),
                ),
                controller: password,
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isNotEmpty) {
                    this.formState += 1;
                  }
                }),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
            RaisedButton(
              child: Text("Login"),
              onPressed: () async {
                _formkey.currentState.validate();
                await user.open("user.db");
                Future<List<User>> allUser = user.getAllUser();

                Future isUserValid(String userid, String password) async {
                  var userList = await allUser;
                  for (var i = 0; i < userList.length; i++) {
                    if (userid == userList[i].userid &&
                        password == userList[i].password) {
                      CurrentUser.id = userList[i].id;
                      CurrentUser.userId = userList[i].userid;
                      CurrentUser.name = userList[i].name;
                      CurrentUser.age = userList[i].age;
                      CurrentUser.password = userList[i].password;
                      CurrentUser.quote = userList[i].quote;
                      this.isValid = true;
                      print("this user valid");
                      break;
                    }
                  }
                }

                if (this.formState != 2) {
                  Toast.show("Please fill out this form", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  this.formState = 0;
                } else {
                  this.formState = 0;
                  await isUserValid(userid.text, password.text);
                  if (!this.isValid) {
                    Toast.show("Invalid user or password", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  } else {
                    Navigator.pushReplacementNamed(context, '/home');
                    userid.text = "";
                    password.text = "";
                  }
                }

                Future showAllUser() async {
                  var userList = await allUser;
                  for (var i = 0; i < userList.length; i++) {
                    print(userList[i]);
                  }
                }

                showAllUser();
                print(CurrentUser.whoCurrent());
              },
            ),
            FlatButton(
              child: Container(
                child: Text("Register New User", textAlign: TextAlign.right),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/register');
              },
              padding: EdgeInsets.only(left: 180.0),
            ),
          ],
        ),
      ),
    );
  }
}
