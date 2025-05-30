import 'package:flutter/material.dart';

class AudioDownloads extends StatelessWidget {
  const AudioDownloads({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio Downloads")),
      body: const Center(child: Text("This is the Audio download Page")),
    );
  }
}
