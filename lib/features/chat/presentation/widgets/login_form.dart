import 'package:flutter/material.dart';

import 'login_button..dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController username = TextEditingController();
    final TextEditingController password = TextEditingController();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: username,
              decoration: const InputDecoration(
                labelText: 'Enter your email',
                hintText: 'John Doe',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Email must be at least @ characters';
                }
                return null; // Input is valid
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: password,
              decoration: const InputDecoration(
                labelText: 'Enter your password',
                hintText: '123456789',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 3) {
                  return 'Password must be at least 3 characters';
                }
                return null; // Input is valid
              },
            ),
            const SizedBox(height: 20),

            SizedBox(
             width: 500,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login Correcto')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
