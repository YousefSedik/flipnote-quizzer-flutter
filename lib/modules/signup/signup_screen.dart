import 'package:project/modules/signup/signup_controller.dart';
import 'package:project/widgets/input_text_field.dart';
import 'package:project/validators/validators.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final SignupController controller = Get.put(SignupController());

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
                  buildSignUpForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ToggleSwitch(
            initialLabelIndex: 0,
            minWidth: 120,
            activeBgColor: [Colors.black],
            inactiveBgColor: Colors.grey[200],
            totalSwitches: 2,
            labels: ['Student', 'Teacher'],

            onToggle: (index) {
              if (index == 0) {
                controller.accountType = AccountType.student;
              } else if (index == 1) {
                controller.accountType = AccountType.teacher;
              }
            },
          ),
          SizedBox(height: 24),
          InputTextField(
            controller: controller.emailController,
            hintText: "Enter your email",
            title: "Email",
            lastItem: false,
            isObscureText: false,
            defaultValue: "user@gmail.com",
            other: {
              "validators": [emailValidator],
              "key": "emailField",
            },
          ),
          InputTextField(
            controller: controller.usernameController,
            hintText: "Username",
            title: "Username",
            lastItem: false,
            // defaultValue: "yousefsedikkk",
            isObscureText: false,
            other: {
              "validators": [notNullOrEmpty],
              "key": "usernameField",
            },
          ),
          InputTextField(
            controller: controller.passwordController,
            hintText: "Enter your password",
            title: "Password",
            lastItem: false,
            // defaultValue: "ggpass1242123",
            isObscureText: true,
            other: {
              "validators": [notNullOrEmpty],
              "key": "passwordField",
            },
          ),
          InputTextField(
            controller: controller.passwordConfirmationController,
            hintText: "Enter your password again",
            title: "Confirm Password",
            lastItem: true,
            // defaultValue: "ggpass1242123",
            isObscureText: true,
            other: {
              "validators": [notNullOrEmpty],
              "key": "passwordConfirmationField",
            },
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
                if (controller.formKey.currentState!.validate()) {
                  controller.formKey.currentState!.save();
                  controller.setLoading(true);
                  await controller.signUp();
                  controller.setLoading(false);
                }
              },
              child: GetBuilder(
                builder: (SignupController c) {
                  if (c.isLoading) {
                    return SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    );
                  } else {
                    return Text("Sign Up");
                  }
                },
              ),
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
