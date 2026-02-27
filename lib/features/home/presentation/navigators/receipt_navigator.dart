import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/pages/receipts.dart';

class ReceiptsNavigator extends StatelessWidget {
  const ReceiptsNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const ReceiptsPage(),
        );
      },
    );
  }
}

