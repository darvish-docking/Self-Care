import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/home/presentation/providers/home-provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {

    return 
    ClipRRect(
      borderRadius: const BorderRadius.vertical(
    top: Radius.circular(24),
  ),
      child: BottomAppBar(
        child: SizedBox(
          // height: 50,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              _buildIcon("assets/icons/home.svg", 0, context),
              _buildIcon("assets/icons/receipt.svg", 1, context),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add,
                    color: Colors.white,
                    size: 35.0,),
              ),
              _buildIcon("assets/icons/messages.svg", 3, context),
              _buildIcon("assets/icons/profile.svg", 4, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(
      String path, int index, BuildContext context) {

    final provider = context.watch<HomeProvider>();
    final isSelected = provider.selectedBottomIndex == index;


    return IconButton(
      // color: AppColors.textSecondary,
      onPressed: () =>
          provider.changeBottomIndex(index),
      icon: SvgPicture.asset(
        path,
        width: 24,
        colorFilter: ColorFilter.mode(
          isSelected
              ? AppColors.primary
              : AppColors.textSecondary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
