import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:project/components/input_text_field.dart';
import 'package:project/validators/validators.dart';
import 'package:get/get.dart';
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _usernameController =
      TextEditingController();

  static final TextEditingController _passwordController =
      TextEditingController();
  static final TextEditingController _passwordConfirmationController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  static final apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxWidth: 400),
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'SF Pro Display',
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Create your account to continue",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                            fontFamily: 'SF Pro Text',
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),
                  buildLoginForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputTextField(
            controller: _emailController,
            hintText: "Enter your email",
            title: "Email",
            lastItem: false,
            isObscureText: false,
            defaultValue: "user121@gmail.com",
            other: {
              "validators": [emailValidator],
            },
          ),
          InputTextField(
            controller: _usernameController,
            hintText: "Username",
            title: "Username",
            lastItem: false,
            defaultValue: "yousefsedikkk",
            isObscureText: false,
          ),
          InputTextField(
            controller: _passwordController,
            hintText: "Enter your password",
            title: "Password",
            lastItem: false,
            defaultValue: "ggpass1242123",
            isObscureText: true,
          ),
          InputTextField(
            controller: _passwordConfirmationController,
            hintText: "Enter your password again",
            title: "Confirm Password",
            lastItem: true,
            defaultValue: "ggpass1242123",
            isObscureText: true,
          ),
          // Login Button
          SizedBox(
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SF Pro Text',
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print(
                    "${_usernameController.text} ${_emailController.text} ${_passwordController.text} ${_passwordConfirmationController.text}",
                  );

                  final response = await apiClient.signup(
                    _usernameController.text,
                    _emailController.text,
                    _passwordController.text,
                    _passwordConfirmationController.text,
                  );
                  if (response.statusCode == 201) {
                    print("signup successful!");
                    // now, login
                    await apiClient.login(
                      _emailController.text,
                      _passwordController.text,
                    );
                    Get.offAllNamed('/home');
                  } else if (response.statusCode == 400) {
                    final Map<String, dynamic> data = response.data;
                    var errorMessage = StringBuffer();
                    errorMessage.write("sign up failed\n");
                    for (var err in data.keys) {
                      errorMessage.writeAll([err, ': ', data[err][0], '\n']);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage.toString()),
                        backgroundColor: Colors.black,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("An error occurred. Please try again."),
                        backgroundColor: Colors.black,
                      ),
                    );
                  }
                }
              },
              child: Text('Signup'),
            ),
          ),

          SizedBox(height: 24),

          // Register Link
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Altready have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontFamily: 'SF Pro Text',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed('/login');
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'SF Pro Text',
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
