import 'package:app1/controller/dao/Local.dart';
import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/Support.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

//import 'package:app1/pages/root_page.dart';

User myUser;
Future main() async {
  await Local().getAllUsers().then((onValue) {
    onValue.forEach((val) {
      String username = val['username'];
      String pass = val['password'];
      String id = val['id'];
      login(username, pass, id);
    });
    runApp(MyApp(false));
  });
  runApp(MyApp(false));
}

void login(String username, String pass, String id) {
  print("onlogin");
  UserDAO().getUser(id: id).then((onValue) {
    User s = User.fromDocument(onValue);
    if (s.username == username && s.pass == pass) {
      myUser = s;
      runApp(MyApp(
        true,
      ));
    } else {
      runApp(MyApp(
        false,
      ));
    }
  }, onError: (Object error ) {
    runApp(MyApp(
      false,
    ));
  });
}

class MyApp extends StatelessWidget {
  final bool login;

  const MyApp(this.login, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        // fontFamily: 'Oswald',
        // brightness: Brightness.dark,
      ),
      home: home(login),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

Widget home(bool login) {
  if (login)
    return DashboardMainPage();
  else
    return MyHomePage();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double textScaleFactor = 1.0;
    return Scaffold(
        body: SafeArea(
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        //key: PageStorageKey("Divider 1"),

        // padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(
            height: 220.0,
            // child: Padding(
            //   padding: EdgeInsets.all(16.0),
              child: Image.asset('assets/logo.png'),
            // ),
          ),
          Form(
            //key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (val) =>
                        val.length < 1 ? 'Username Required' : null,
                    //onSaved: (val) => _username = val,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    controller: _username,
                    autocorrect: false,
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (val) =>
                        val.length < 1 ? 'Password Required' : null,
                    //onSaved: (val) => _password = val,
                    obscureText: true,
                    controller: _password,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: NativeButton(
              child: Text(
                'Login',
                textScaleFactor: textScaleFactor,
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                UserDAO().getAllUsers().then((onval) {
                  onval.documents.forEach((data) {
                    User.fromDocument(data);
                  });
                });
                if (!Support.checkValues(_username.text)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Worning!"),
                        content: new Text('Insert username please'),
                      );
                    },
                  );
                } else if (!Support.checkValues(_password.text)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Worning!"),
                        content: new Text('Insert password please'),
                      );
                    },
                  );
                } else
                  UserDAO()
                      .getUserByUsernameAndPass(
                        username: _username.text,
                      )
                      .getDocuments()
                      .then((onValue) {
                    if (onValue.documents.length != 0)
                      onValue.documents.forEach((doc) {
                        User s = User.fromDocument(doc);
                        print(s);
                        if (_password.text == s.pass) {
                          myUser = s;
                          print(myUser);
                          Local().saveUser(
                              id: myUser.id,
                              pass: myUser.pass,
                              username: myUser.username);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (C) => DashboardMainPage()));
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Worning!"),
                                content: new Text(
                                    'Username or password is not correct'),
                              );
                            },
                          );
                        }
                      });
                  });
              },
            ),
            trailing: NativeButton(
              child: Icon(
                Icons.fingerprint,
                color: Colors.white,
              ),
              color: Colors.redAccent[400],
              onPressed: () {},
            ),
          ),
        ],
      ),
    ));
  }
}