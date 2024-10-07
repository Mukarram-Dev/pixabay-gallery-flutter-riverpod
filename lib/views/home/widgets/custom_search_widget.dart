import 'package:pixabay_gallery/config/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintTitle;
  final bool enabled;
  final VoidCallback onTap;

  const CustomSearchWidget({
    super.key,
    this.enabled = true,
    required this.controller,
    required this.textInputType,
    required this.hintTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        cursorColor: AppColors.primaryColor,
        controller: controller,
        enabled: enabled,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: AppColors.white,
          hintText: hintTitle,
          contentPadding: const EdgeInsets.all(16),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: 45,
                height: 35,
                child: Material(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: const Icon(
                    Icons.search,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          hintStyle:
              const TextStyle(letterSpacing: 1.0, color: AppColors.grey1),
        ),
      ),
    );
  }
}
