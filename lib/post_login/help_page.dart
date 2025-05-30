import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help & FAQs Page")),
      body: const Center(child: Text("This is the Help & FAQs Page")),
    );
  }
}
