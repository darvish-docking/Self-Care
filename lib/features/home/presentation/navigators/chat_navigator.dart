import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/pages/chat_menu.dart';

class ChatNavigator extends StatelessWidget {
  const ChatNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) =>  ChatMenuScreen(),
        );
      },
    );
  }
}

