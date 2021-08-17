import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_task/facebook_login_controller.dart';
import 'package:login_task/google_login_controller.dart';

class FacebookLoginPage extends StatefulWidget {
  @override
  _FacebookLoginPageState createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "APPBAR",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(0, 121, 107, 1),
        elevation: 22,
        shadowColor: Color.fromRGBO(0, 66, 59, 1),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      body: loginUI(),
    );
  }

  loginUI() {
    return Consumer<FacebookSignInController>(
      builder: (context, model, child) {
        if (model.userData != null) {
          return Center(
            child: loggedInUI(model),
          );
        } else {
          return loginControls(context);
        }
      },
    );
  }

  loggedInUI(FacebookSignInController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(model.userData!["picture"]["data"]["url"] ?? '')
                  .image,
          radius: 50,
        ),
        Text(model.userData!["name"] ?? ''),
        Text(model.userData!["email"]),
        ActionChip(
          avatar: Icon(Icons.logout),
          label: Text("Logout"),
          onPressed: () {
            Provider.of<FacebookSignInController>(context, listen: false)
                .logOut();
          },
        )
      ],
    );
  }

  loginControls(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Image.asset(
              "assets/images/google.png",
              width: 250,
            ),
            onTap: () {
              Provider.of<GoogleSignInController>(context, listen: false)
                  .login();
            },
          ),
          GestureDetector(
            child: Image.asset(
              "assets/images/facebook.png",
              width: 250,
            ),
            onTap: () {
              Provider.of<FacebookSignInController>(context, listen: false)
                  .login();
            },
          ),
        ],
      ),
    );
  }
}
