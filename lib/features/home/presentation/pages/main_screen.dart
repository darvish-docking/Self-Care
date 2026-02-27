import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/navigators/chat_navigator.dart';
import 'package:selfcare_mobileapp/features/home/presentation/navigators/profile_navigator.dart';
import 'package:selfcare_mobileapp/features/home/presentation/navigators/receipt_navigator.dart';

import 'package:selfcare_mobileapp/features/home/presentation/providers/home-provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/widgets/bottom_nav_bar.dart';

import '../navigators/home_navigator.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const _MainScreenBody(),
    );
  }
}

class _MainScreenBody extends StatelessWidget {
  const _MainScreenBody();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: provider.selectedBottomIndex,
        children: const [
          HomeNavigator(),
          ReceiptsNavigator(),
          SizedBox(), // + button tab (temporary)
          ChatNavigator(),
          ProfileNavigator(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}