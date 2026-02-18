import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/providers/app_providers.dart';
import 'package:selfcare_mobileapp/core/theme/app_theme.dart';
import 'package:selfcare_mobileapp/features/auth/Presentation/pages/start_1.dart';

void main() {
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

