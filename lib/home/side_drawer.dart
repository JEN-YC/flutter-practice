import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawer extends StatefulWidget {
  final User _user;
  SideDrawer({@required User user}) : _user = user;
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final picker = ImagePicker();
  String myPicPath;
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      sharedPreferences = prefs;
      setState(() {
        myPicPath = prefs.getString('my_pic_path') ?? null;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.55,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: myPicPath == null
                  ? Image.asset('assets/default_pic')
                  : Image.file(File(myPicPath)),
              accountEmail: Text(widget._user.email),
              accountName: Text(''),
              decoration: BoxDecoration(color: Colors.brown),
            ),
            ListTile(
              leading: Icon(Icons.file_upload),
              title: Text('Profile picture'),
              onTap: () async {
                String imagePath =
                    (await picker.getImage(source: ImageSource.gallery)).path;
                if (imagePath != null) {
                  // 未來可以上傳至DB, 目前僅存image path到sharedPreference
                  sharedPreferences.setString('my_pic_path', imagePath);
                  setState(() {
                    myPicPath = imagePath;
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.sentiment_satisfied),
              title: Text('Rate Our App'),
              onTap: () {
                Navigator.of(context).pop();
                _asyncScoreDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Log out"),
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(LoggedOutEvent());
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: () {
                SnackBar snackbar = SnackBar(
                  content:
                      Text('Flutter!!'),
                  duration: Duration(seconds: 5),
                );
                Scaffold.of(context).showSnackBar(snackbar);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _asyncScoreDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('喜歡嗎?'),
        content: const Text('如果你喜歡，那就幫我們填寫評論吧!'),
        actions: <Widget>[
          FlatButton(
            child: const Text('待會'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: const Text('好!'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}
