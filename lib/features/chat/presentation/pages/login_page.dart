import 'package:flutter/material.dart';

import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.flutter_dash,
                size: 80,
                color: Colors.blue,
              ),
              SizedBox(height: 100,),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
