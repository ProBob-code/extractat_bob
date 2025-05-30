import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    // Lock orientation to portrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    // Optionally unlock orientation when leaving this page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen background image
          SizedBox.expand(
            child: Image.asset(
              'assets/background/bg_pattern.png',
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Stack with logo and overlapping buttons
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Logo
                    Center(
                      child: Image.asset(
                        'assets/background/t_logo.png',
                        width: 700,
                        height: 680,
                        fit: BoxFit.contain,
                      ),
                    ),

                    // Positioned buttons overlapping the bottom of the logo
                    Positioned(
                      top: 500, // Adjust this to sit just over the logo base
                      left: 32,
                      right: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignInPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade300.withOpacity(0.9),
                                foregroundColor: Colors.black87,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontFamily: 'RobotoFlex',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade300.withOpacity(0.9),
                                foregroundColor: Colors.black87,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontFamily: 'RobotoFlex',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Positioned horizontal divider directly below the buttons
                    Positioned(
                      top: 580, // Slightly lower than the buttons
                      left: 25,
                      right: 25,
                      child: Container(
                        height: 1.5,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
