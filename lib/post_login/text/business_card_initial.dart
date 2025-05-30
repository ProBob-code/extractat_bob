import 'package:flutter/material.dart';

class BusinessCardInitial extends StatelessWidget {
  const BusinessCardInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Business Card Initial")),
      body: const Center(child: Text("This is the Business Card Initial Page")),
    );
  }
}
