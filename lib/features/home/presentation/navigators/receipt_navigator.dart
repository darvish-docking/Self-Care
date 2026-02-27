import 'package:flutter/material.dart';

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

class ReceiptsPage extends StatelessWidget {
  const ReceiptsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Receipts Page"),
    );
  }
}