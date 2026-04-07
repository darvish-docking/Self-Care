import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/providers/app_providers.dart';
import 'package:selfcare_mobileapp/core/theme/app_theme.dart';
import 'package:selfcare_mobileapp/features/auth/Presentation/pages/start_1.dart';
import 'package:selfcare_mobileapp/firebase_options.dart';
import 'package:selfcare_mobileapp/core/services/firebase_messaging_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase Messaging
  await FirebaseMessagingService.initialize();

  runApp(
    MultiProvider(
      providers: 
        AppProviders.providers,

      child: const MyApp()
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const StartPage1(title: 'Self Care'),
      
      
    );
  }
}

