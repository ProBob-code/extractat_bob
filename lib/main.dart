import 'package:flutter/material.dart';
import 'pre_login/start_page.dart';
import 'pre_login/sign_in.dart';
import 'pre_login/sign_up.dart';
import 'post_login/home_page.dart' as home;
import 'post_login/home_page_new.dart' as newhome;
import 'post_login/profile_page.dart' as profile;
import 'post_login/audio/audio_extraction.dart';
import 'post_login/audio/audio_downloads.dart';
import 'post_login/audio/audio_datasets.dart';
import 'post_login/audio/audio_file_initial.dart';
import 'post_login/audio/live_recording_initial.dart';
import 'post_login/text/text_extraction.dart';
import 'post_login/settings_page.dart';
import 'post_login/about_page.dart';
import 'post_login/help_page.dart';
import 'post_login/text/business_card_initial.dart';
import 'post_login/text/PDF_initial.dart';
import 'post_login/text/business_card_downloads.dart'; 
import 'post_login/text/business_card_datasets.dart';

void main() {
  runApp(const ExtractatApp());
}

class ExtractatApp extends StatelessWidget {
  const ExtractatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'extractat.io',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'RobotoFlex',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const StartPage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const home.HomePage(),
        '/newhome': (context) => const newhome.HomePageNew(),
        '/profile': (context) => const profile.ProfilePage(),
        '/audio': (context) => const AudioExtractionPage(),
        '/text': (context) => const TextExtractionPage(),
        '/settings': (context) => const SettingsPage(),
        '/about': (context) => const AboutPage(),
        '/help': (context) => const HelpPage(),
        '/business_card_initial': (context) => const BusinessCardInitial(),
        '/pdf_initial': (context) => const PDFInitial(),
        '/business_card_downloads': (context) => const BusinessCardDownloads(),
        '/business_card_datasets': (context) => const BusinessCardDatasets(),
        '/audio_file_initial': (context) => const AudioFileInitial(),
        '/audio_downloads': (context) => const AudioDownloads(),
        '/audio_datasets': (context) => const AudioDatasets(),
        '/live_recording_initial': (context) => const LiveRecordingInitial(),
      },
    );
  }
}
