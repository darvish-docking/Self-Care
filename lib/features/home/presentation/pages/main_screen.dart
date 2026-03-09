import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/home/presentation/navigators/chat_navigator.dart';
import 'package:selfcare_mobileapp/features/home/presentation/navigators/home_navigator.dart';
import 'package:selfcare_mobileapp/features/home/presentation/navigators/profile_navigator.dart';
import 'package:selfcare_mobileapp/features/home/presentation/navigators/receipt_navigator.dart';

import 'package:selfcare_mobileapp/features/home/presentation/providers/home-provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/widgets/bottom_nav_bar.dart';



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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {

        /// If user is NOT on Home tab
        if (provider.selectedBottomIndex != 0) {
          context.read<HomeProvider>().changeBottomIndex(0);
          return;
        }

        /// If user is already on Home tab → show exit confirmation
        final shouldExit = await showModalBottomSheet<bool>(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Text(
                    "Exit App",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Are you sure you want to exit?",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [

                      /// Cancel Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("Cancel"),
                        ),
                      ),

                      const SizedBox(width: 10),

                      /// Exit Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text("Exit"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );

        /// If user confirms exit
        if (shouldExit == true) {
          SystemNavigator.pop();
        }

      },
      child: Scaffold(
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
      ),
    );
  }
}