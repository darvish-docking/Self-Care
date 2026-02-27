import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/features/home/presentation/pages/home.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      },
    );
  }
}