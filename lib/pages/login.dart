import 'package:flutter/material.dart';
import 'package:project/validators/validatords.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(8),
          ),

          margin: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Enter your credentials to access your account!",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: 20),
                buildLoginForm(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              autofocus: true,
              validator: (value) {
                String? res = emailValidator(value);
                if (res != null) {
                  return res;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            MaterialButton(
              color: Colors.black,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid
                }
              },
              child: Text('Log In', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
