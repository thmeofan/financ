import 'package:financ/consts/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../consts/app_text_styles/settings_text_style.dart';

class SettingsTile extends StatelessWidget {
//  final String assetName;
  final String text;
  final VoidCallback? onTap;
  final Widget? action;

  const SettingsTile({
    super.key,
    required this.text,
    this.onTap,
    this.action,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.purpleColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            children: [
              SizedBox(width: 8.0),
              Text(
                text,
                style: SettingsTextStyle.tile,
              ),
              if (action != null) ...[
                Spacer(),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
