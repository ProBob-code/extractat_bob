  import 'package:flutter/material.dart';

  class HomePageNew extends StatefulWidget {
    const HomePageNew({super.key});

    @override
    State<HomePageNew> createState() => _HomePageNewState();
  }

  class _HomePageNewState extends State<HomePageNew> with SingleTickerProviderStateMixin {
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
            Image.asset('assets/background/new_home.png', fit: BoxFit.cover),

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
              top: 172,
              left: 17,
              child: IconButton(
                icon: const Icon(Icons.menu, size: 40, color: Colors.black),
                onPressed: _toggleMenu,
              ),
            ),

            // Profile section on homepageNew
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

            // HOME TEXT
              Positioned(
                top: 245,
                left: 0,
                right: 0,
                child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                  Icon(
                    Icons.home,
                    size: 40,
                    color: Color.fromARGB(255, 212, 0, 0),
                  ),
                  SizedBox(width: 2),
                  Text(
                    'HOME',
                    style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Roboto',
                    letterSpacing: 0,
                    ),
                  ),
                  ],
                ),
                ),
              ),
            

            // AUDIO Extraction
            Positioned(
              top: screenHeight * 0.398,  left: 45,
              child: _buildActionButton(
                icon: Icons.multitrack_audio_sharp,
                label: 'AUDIO EXTRACTION',
                onPressed: () {
                  Navigator.pushNamed(context, '/audio');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Navigate to Audio Extraction')),
                  );
                },
                // Add a style parameter for font size
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18, // Change this value to set font size
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),

            // TEXT Extraction
            Positioned(
              top: screenHeight * 0.72,
              left: 45,
              child: _buildActionButton(
                icon: Icons.text_snippet, // Use a text-related icon
                label: 'TEXT EXTRACTION',
                onPressed: () {
                  Navigator.pushNamed(context, '/text');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Navigate to Text Extraction')),
                  );
                },
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
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
                          // Navigator.pushNamed(context, '/home');
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
      return SizedBox(
        width: 320,
        height: 75,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF262626),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 36),
              const SizedBox(width: 12),
              Text(
                label,
                style: textStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
              ),
            ],
          ),
        ),
      );
    }
  }
