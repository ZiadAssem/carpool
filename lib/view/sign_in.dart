import 'dart:convert';

import 'package:carpool/reusable_widget.dart';
import 'package:carpool/view/routes.dart';
import 'package:flutter/material.dart';
import '../validation_mixin.dart';
import 'main_container.dart';

bool isSignInForm = true;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with ValidationMixin {
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpPhoneController = TextEditingController();
  final signInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildSignInBackground(),
          _buildSignInOrSignUpForm(),
        ],
      ),
    );
  }

  Widget SignUpForm() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 200),
          const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Create an account to continue!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),

          //Signup form
          Form(
            key: signUpFormKey,
            child: Column(
              children: [
                reusableTextField(
                  "E-mail",
                  Icons.abc,
                  false,
                  signUpEmailController,
                  validateName,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: reusableTextField(
                          "Password",
                          Icons.password,
                          true,
                          signUpPasswordController,
                          validatePassword,
                          showPassword),
                    ),
                    Checkbox(
                        activeColor: const Color.fromARGB(255, 142, 15, 6),
                        value: showPassword,
                        onChanged: (bool? value) {
                          setState(() {
                            showPassword = value!;
                          });
                        }),
                  ],
                ),
                const SizedBox(height: 20),
                reusableTextField("Phone Number", Icons.phone_android, false,
                    signUpPhoneController, validatePhone),
                const SizedBox(height: 20),
                resuableButton(context, "SIGN UP", 200.0, () async {
                  if (signUpFormKey.currentState!.validate()) {
                    // final auth = Authentication.instance;
                    // logIn = await auth.createUserWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim());

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("SUCCESSFUL")));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavPage()));
                  }
                }),
                const SizedBox(height: 10),
                const Text("Already Registered?"),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () async {
                      setState(() {
                        isSignInForm = true;
                      });
                    },
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(
                        color: Color.fromARGB(255, 142, 15, 6),
                        fontSize: 20,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget SignInForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 200),
        Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Sign In",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Sign in to continue!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),

            //Signup form
            Form(
              key: signInFormKey,
              child: Column(
                children: [
                  reusableTextField("E-mail", Icons.phone_android, false,
                      signInEmailController, validateEmail),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: reusableTextField(
                            "Password",
                            Icons.password,
                            true,
                            signInPasswordController,
                            validteSignInPassword,
                            showPassword),
                      ),
                      Checkbox(
                          activeColor: const Color.fromARGB(255, 142, 15, 6),
                          value: showPassword,
                          onChanged: (bool? value) {
                            setState(() {
                              showPassword = value!;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: const Color.fromARGB(255, 199, 196, 196),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        )),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  resuableButton(context, "SIGN IN", 200.0,signInFormValidate ),
                  const SizedBox(height: 10),
                  const Text("New User?",
                      style: TextStyle(color: Colors.black)),
                  const SizedBox(height: 10),
                  _buildRegisterHereButton(),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSignInBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/signin.jpg',
            ),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildSignInOrSignUpForm() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: isSignInForm ? SignInForm() : SignUpForm(),
      ),
    );
  }

  Widget _buildRegisterHereButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isSignInForm = false;
          });
        },
        child: const Text(
          "REGISTER HERE",
          style: TextStyle(
            color: Color.fromARGB(255, 142, 15, 6),
            fontSize: 20,
          ),
        ));
  }

  signInFormValidate() async {
                    if (signInFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("SUCCESSFUL"),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavPage()),
                      );
                    }
                  }

}

// Future<bool> checkValue(phoneController, passwordController) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? userData = prefs.getString('users');
//   print('user data is $userData');
//   if (userData != null) {
//     Map<String, dynamic> usersMap = jsonDecode(userData);
//     print('usersMap: $usersMap');

//     // Check if the phone number exists in the user data map
//     if (usersMap.containsKey(phoneController.text)) {
//       Map<String, dynamic> user = usersMap[phoneController.text];

//       // Check if the provided password matches the stored password
//       if (user['password'] == passwordController.text) {
//         return true; // Credentials match
//       }
//     }
//   }

//   return false; // Credentials do not match or user not found
// }
