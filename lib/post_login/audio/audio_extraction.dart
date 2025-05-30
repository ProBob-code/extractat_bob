// import 'package:flutter/material.dart';

// class AudioExtractionPage extends StatelessWidget {
//   const AudioExtractionPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Audio Extraction")),
//       body: const Center(child: Text("This is the Audio Extraction Page")),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class AudioExtractionPage extends StatelessWidget {
//   const AudioExtractionPage({super.key});


import 'package:flutter/material.dart';

class AudioExtractionPage extends StatefulWidget {
  const AudioExtractionPage({super.key});

  @override
  State<AudioExtractionPage> createState() => _AudioExtractionPageState();
}

class _AudioExtractionPageState extends State<AudioExtractionPage> with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _closeMenu() {
    setState(() {
      _isMenuOpen = false;
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/background/t_extraction_home_np.png', fit: BoxFit.cover),

          // App logo
                Positioned(
                  top: 25,
                  left: 0,
                  child: Hero(
                  tag: 'app_logo',
                  child: GestureDetector(
                    onTap: () {
                    Navigator.pushNamed(context, '/newhome');
                    },
                    child: const Image(
                    image: AssetImage('assets/background/o_logo.png'),
                    width: 160,
                    height: 160,
                    fit: BoxFit.contain,
                    ),
                  ),
                  ),
                ),

          // Menu button
          Positioned(
            top: 171,
            left: 15,
            child: IconButton(
              icon: const Icon(Icons.menu, size: 45, color: Colors.black),
              onPressed: _toggleMenu,
            ),
          ),

          // Profile section on AudioExtractionPage
          Positioned(
            top: 80,
            right: 24,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigate to Profile')),
                );
              },
              child: Row(
                children: const [
                  Text(
                  'Welcome, John',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage('assets/background/profile_pic.png'),
                  // child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),


          // Home mini button
            Positioned(
            top: 177,
            left: 130,
            child: Row(
              children: [
              // Home mini button with text below icon
              Column(
                children: [
                IconButton(
                  icon: const Icon(Icons.home_work, size: 32, color: Colors.black),
                  tooltip: 'Home',
                  onPressed: () {
                  // Navigator.pushNamed(context, '/audio');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Navigate to Audio Extraction')),
                  );
                  },
                  style: IconButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 231, 0, 0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Home',
                  style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  ),
                ),
                ],
              ),
              const SizedBox(width: 15),
              // Download mini button with text below icon
              Column(
                children: [
                IconButton(
                  icon: const Icon(Icons.download, size: 32, color: Colors.black),
                  tooltip: 'Download',
                  onPressed: () {
                  Navigator.pushNamed(context, '/audio_downloads');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Download action')),
                  );
                  },
                  style: IconButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Download',
                  style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  ),
                ),
                ],
              ),
              const SizedBox(width: 15),
              // Dataset mini button with text below icon
              Column(
                children: [
                IconButton(
                  icon: const Icon(Icons.dataset_outlined, size: 32, color: Colors.black),
                  tooltip: 'Dataset',
                  onPressed: () {
                  Navigator.pushNamed(context, '/audio_datasets');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dataset action')),
                  );
                  },
                  style: IconButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Dataset',
                  style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  ),
                ),
                ],
              ),
              ],
            ),
            ),


          // HOME TEXT
            Positioned(
              top: 295,
              left: 0,
              right: 0,
              child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                Icon(
                  Icons.multitrack_audio,
                  size: 35,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                SizedBox(width: 20),
                Text(
                  'AUDIO EXTRACTION',
                  style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.extrabold,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'Robotoflex',
                  letterSpacing: 0,
                  ),
                ),
                ],
              ),
              ),
            ),
          

            // AUDIO Extraction
            Positioned(
            top: screenHeight * 0.43,
            left: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              // Move the text above the button and align left
              Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 25.0),
                child: Text(
                'Can transcribe text from live audio feed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
                ),
              ),
              _buildActionButton(
                icon: Icons.record_voice_over,
                label: '   LIVE RECORDING   ',
                onPressed: () {
                Navigator.pushNamed(context, '/live_recording_initial');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigate to Live recording process')),
                );
                },
              ),
              const SizedBox(height: 10),
              ],
            ),
            ),

          // TEXT Extraction
          // Positioned(
          //   top: screenHeight * 0.77,
          //   left: 40,
          Positioned(
            top: screenHeight * 0.71,
            left: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              // Move the text above the button and align left
              Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 25.0),
                child: Text(
                'Can transcribe text from audio files',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
                ),
              ),
              _buildActionButton(
              icon: Icons.audio_file,
              label: '    AUDIO FILE    ',
              onPressed: () {
                Navigator.pushNamed(context, '/audio_file_initial');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigate to audio file Processing')),
                );
              },
            ),
              ],
          ),
          ),

          // Slide-out Menu
          if (_isMenuOpen) ...[
            GestureDetector(
              onTap: _closeMenu,
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7 > 300
                      ? 300
                      : MediaQuery.of(context).size.width * 0.7,
                  height: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(10, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                      child: Image.asset(
                        'assets/background/t_logo.png',
                        width: 210,
                        height: 210,
                        fit: BoxFit.contain,
                      ),
                      ),
                      const SizedBox(height: 2),

                      // Sidebar profile
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: Row(
                          children: const [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage('assets/background/profile_pic.png'),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Doe',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'RobotoFlex',
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'john@example.com',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontFamily: 'RobotoFlex',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),  
                      const SizedBox(height: 20),
                      const Divider(thickness: 1, color: Colors.black54),
                      const SizedBox(height: 10),
                      const Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoFlex',
                        color: Colors.black,
                      ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                      leading: const Icon(Icons.home, color: Colors.black),
                      title: const Text(
                        'Home',
                        style: TextStyle(
                        fontFamily: 'RobotoFlex',
                        color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/newhome');
                        _closeMenu();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Home')));
                      },
                      ),
                      ListTile(
                      leading: const Icon(Icons.settings, color: Colors.black),
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                        fontFamily: 'RobotoFlex',
                        color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/settings');
                        _closeMenu();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings')));
                      },
                      ),
                      ListTile(
                      leading: const Icon(Icons.info, color: Colors.black),
                      title: const Text(
                        'About',
                        style: TextStyle(
                        fontFamily: 'RobotoFlex',
                        color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/about');
                        _closeMenu();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('About')));
                      },
                      ),
                      ListTile(
                      leading: const Icon(Icons.help_outline, color: Colors.black),
                      title: const Text(
                        'Help & FAQs',
                        style: TextStyle(
                        fontFamily: 'RobotoFlex',
                        color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/help');
                        _closeMenu();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Help & FAQs')));
                      },
                      ),
                      const Spacer(),

                      // Logout button
                      Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signin');
                        _closeMenu();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logged out')),
                        );
                        },
                        icon: const Icon(Icons.logout, color: Colors.black),
                        label: const Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'RobotoFlex',
                          color: Colors.black,
                        ),
                        ),
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    TextStyle? textStyle,
  }) {
    // Special handling for 'PORTABLE DOCUMENT FORMAT'
    final isPdf = label == '    AUDIO FILE    ';
    return SizedBox(
      width: 330,
      height: 110,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main button background
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 110), // Space for icon
                Expanded(
                  child: Container(), // Fills remaining space
                ),
              ],
            ),
            // Custom positioned icon
            Positioned(
              left: 10,
              child: Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: Color(0xFF001F54), // Navy blue
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: label == '   LIVE RECORDING   ' ? const Color.fromARGB(255, 255, 38, 0) : Colors.white,
                  size: 50,
                ),
              ),
            ),
            // Custom positioned label
            Positioned(
              right: 50,
              child: SizedBox(
                width: 170,
                child: isPdf
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '    AUDIO FILE    ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // // SizedBox(height: 2),
                          // Center(
                          //   child: Text(
                          //     'FORMAT',
                          //     style: TextStyle(
                          //       color: Color.fromARGB(255, 0, 0, 0),
                          //       fontSize: 19,
                          //       fontWeight: FontWeight.w900,
                          //       fontFamily: 'Roboto',
                          //     ),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                        ],
                      )
                    : Text(
                        label,
                        style: textStyle ??
                            const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto',
                            ),
                        textAlign: TextAlign.left,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
