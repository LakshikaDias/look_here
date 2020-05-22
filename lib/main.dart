import 'package:flutter/material.dart';

void main() => runApp(SignIn());

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signin Page paaraa',

        ),

      ),
      body: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('images/user.png'),
            radius: 50.0,
          ),
          Text(''),
        ],
      ),
    );
  }
}
