import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_task/login_controller.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "LOGIN PAGE",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(0, 121, 107, 1),
        elevation: 22,
        shadowColor: Color.fromRGBO(0, 66, 59, 1),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150),
        ),
      ),
      body: loginUI(),
    );
  }

  loginUI() {
    return Consumer<LoginController>(
      builder: (context, model, child) {
        if (model.googleAccount != null) {
          return Center(
            child: googleloggedInUI(model),
          );
        } else if (model.userData != null) {
          return Center(
            child: facebookloggedInUI(model),
          );
        } else {
          return loginControls(context);
        }
      },
    );
  }

  googleloggedInUI(LoginController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(model.googleAccount!.photoUrl ?? '').image,
          radius: 60,
        ),
        SizedBox(height: 10),
        Text(
          model.googleAccount!.displayName ?? '',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          model.googleAccount!.email,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        ActionChip(
          elevation: 10,
          labelPadding: EdgeInsets.all(7),
          avatar: CircleAvatar(
            child: Icon(
              Icons.logout,
            ),
          ),
          label: Text("Logout", style: TextStyle(fontSize: 18)),
          onPressed: () {
            Provider.of<LoginController>(context, listen: false).logOut();
          },
        )
      ],
    );
  }

  facebookloggedInUI(LoginController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(model.userData!["picture"]["data"]["url"] ?? '')
                  .image,
          radius: 60,
        ),
        SizedBox(height: 10),
        Text(
          model.userData!["name"] ?? '',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          model.userData!["email"],
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        ActionChip(
          elevation: 10,
          labelPadding: EdgeInsets.all(7),
          avatar: CircleAvatar(
            child: Icon(Icons.logout),
          ),
          label: Text("Logout", style: TextStyle(fontSize: 18)),
          onPressed: () {
            Provider.of<LoginController>(context, listen: false).logOut();
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
              "assets/images/google_logo.png",
              width: 250,
            ),
            onTap: () {
              Provider.of<LoginController>(context, listen: false)
                  .googlelogin();
            },
          ),
          GestureDetector(
            child: Image.asset(
              "assets/images/facebook_logo.png",
              width: 250,
            ),
            onTap: () {
              Provider.of<LoginController>(context, listen: false)
                  .facebooklogin();
            },
          ),
        ],
      ),
    );
  }
}
