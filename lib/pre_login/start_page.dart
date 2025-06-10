// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'sign_in.dart';
// import 'sign_up.dart';

// class StartPage extends StatefulWidget {
//   const StartPage({super.key});

//   @override
//   State<StartPage> createState() => _StartPageState();
// }

// class _StartPageState extends State<StartPage> {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: 393, // Mimics Android RelativeLayout width
//           height: 852, // Mimics Android RelativeLayout height
//           decoration: BoxDecoration(
//             color: const Color(0x1A000000), // Same as #1A000000
//             borderRadius: BorderRadius.circular(16), // To enable clip behavior
//           ),
//           clipBehavior: Clip.hardEdge, // Mimics clipToOutline="true"
//           child: Stack(
//             children: [
//               // Background image
//               Positioned.fill(
//                 child: Image.asset(
//                   'assets/background/bg_pattern.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),

//               // Foreground content
//               SafeArea(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 60),

//                     Stack(
//                       alignment: Alignment.bottomCenter,
//                       children: [
//                         // Logo
//                         Center(
//                           child: Image.asset(
//                             'assets/background/t_logo.png',
//                             width: 700,
//                             height: 680,
//                             fit: BoxFit.contain,
//                           ),
//                         ),

//                         // Buttons
//                         Positioned(
//                           top: 500,
//                           left: 32,
//                           right: 32,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => const SignInPage()),
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.grey.shade300.withOpacity(0.9),
//                                     foregroundColor: Colors.black87,
//                                     elevation: 5,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                   ),
//                                   child: const Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 12),
//                                     child: Text(
//                                       'Sign In',
//                                       style: TextStyle(
//                                         fontFamily: 'RobotoFlex',
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => const SignUpPage()),
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.grey.shade300.withOpacity(0.9),
//                                     foregroundColor: Colors.black87,
//                                     elevation: 5,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                   ),
//                                   child: const Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 12),
//                                     child: Text(
//                                       'Sign Up',
//                                       style: TextStyle(
//                                         fontFamily: 'RobotoFlex',
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         // Divider line
//                         Positioned(
//                           top: 580,
//                           left: 25,
//                           right: 25,
//                           child: Container(
//                             height: 1.5,
//                             color: Colors.black.withOpacity(0.2),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background/bg_pattern.svg',
              fit: BoxFit.cover,
            ),
          ),

          // Foreground content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenHeight = constraints.maxHeight;
                final screenWidth = constraints.maxWidth;

                return Column(
                  children: [
                    SizedBox(height: screenHeight * 0.15), // Top spacing

                    // Logo
                    Image.asset(
                      'assets/background/t_logo.png',
                      width: screenWidth * 0.97,
                      fit: BoxFit.contain,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                      height: 1.5,
                      color: Colors.black.withOpacity(0.5),
                      ),
                    ),


                    SizedBox(height: screenHeight * 0.02), // Gap below logo
                    
                    // Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignInPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade300,
                                foregroundColor: Colors.black,
                                elevation: 9,
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
                                  MaterialPageRoute(
                                      builder: (_) => const SignUpPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade300,
                                foregroundColor: Colors.black,
                                elevation: 9,
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

                    const Spacer(), // Push content upward in tall screens
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
