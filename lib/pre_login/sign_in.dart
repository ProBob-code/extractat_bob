import 'package:flutter/material.dart';
// import 'sign_up.dart';
// import '../post_login/home_page.dart';
// import '../post_login/home_page_new.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    usernameFocus.addListener(() {
      print("Username field focus: ${usernameFocus.hasFocus}");
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Full-screen background image
          Positioned.fill(
            child: Image.asset(
              'assets/background/bg_sign_in.png',
              fit: BoxFit.cover,
            ),
          ),

          // Logo
          const Positioned(
            top: 25,
            left: 0,
            child: Image(
              image: AssetImage('assets/background/o_logo.png'),
              width: 160,
              height: 160,
              fit: BoxFit.contain,
            ),
          ),

          // Content form
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 220.0),
              child: Column(
                children: [
                  const Text(
                    "SIGN IN",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'RobotoFlex',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Username
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      controller: usernameController,
                      focusNode: usernameFocus, // ✅ Fix: attach focus node
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'RobotoFlex',
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        floatingLabelStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'RobotoFlex',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          backgroundColor: Colors.black,
                        ),
                        alignLabelWithHint: true,
                        prefixIcon: const Icon(Icons.verified_user, color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black, fontFamily: 'RobotoFlex'),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'RobotoFlex',
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        floatingLabelStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'RobotoFlex',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          backgroundColor: Colors.black,
                        ),
                        alignLabelWithHint: true,
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black, fontFamily: 'RobotoFlex'),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Continue Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                      width: 120,
                      height: 41,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/newhome');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'RobotoFlex',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),

                  // Sign Up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RobotoFlex',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontFamily: 'RobotoFlex',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
