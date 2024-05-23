import 'package:flutter/material.dart';
import '../image_asset.dart';

import '../../../data/enums/appbar_type_enum.dart';
import '../../../resources/file_paths/icons.dart';
import '../../../resources/styles/colors.dart';
import '../../../resources/styles/text_styles.dart';
import '../texts/custom_text.dart';
import 'app_bar_back_icon_widget.dart';
import 'app_bar_trailing_icon_widget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.appbarType,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.color,
    this.backgroundGradient,
    this.textColor,
    this.iconColor,
    this.leadingIconFunction,
    this.trailingIconFunction,
    this.toolbarHeight = kToolbarHeight,
  });
  final AppbarType appbarType;
  final String? title;
  final String? leadingIcon;
  final String? trailingIcon;
  final Color? color;
  final Gradient? backgroundGradient;
  final Color? textColor;
  final Color? iconColor;
  final Function? leadingIconFunction;
  final Function? trailingIconFunction;
  final double toolbarHeight;

  @override
  // ignore: library_private_types_in_public_api
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    switch (widget.appbarType) {
      case AppbarType.withLeading:
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: widget.color,
          elevation: 0,
          title: Row(
            children: <Widget>[
              widget.leadingIcon != null
                  ? ImageAsset(
                      widget.leadingIcon!,
                      width: 32,
                      height: 32,
                      color: widget.iconColor,
                    )
                  : AppBarBackIconWidget(
                      onTap: widget.leadingIconFunction,
                      color: widget.iconColor ?? AppColors.white,
                    ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: widget.backgroundGradient,
            ),
          ),
        );

      case AppbarType.withLeadingAndTitle:
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: widget.color,
          elevation: 0,
          title: Row(
            children: <Widget>[
              AppBarBackIconWidget(
                color: widget.iconColor ?? AppColors.white,
              ),
              const SizedBox(
                width: 16,
              ),
              CustomText(
                widget.title ?? '',
                style: AppTextStyle.h4(
                  color: widget.textColor ?? AppColors.white,
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: widget.backgroundGradient,
            ),
          ),
        );
      case AppbarType.withTitle:
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: widget.color,
          elevation: 0,
          title: Row(
            children: <Widget>[
              CustomText(
                widget.title ?? '',
                style: AppTextStyle.h3(
                  weight: AppTextStyle.fontBold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: widget.backgroundGradient,
            ),
          ),
        );

      case AppbarType.withLeadingTrailingAndTitle:
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: widget.color,
          elevation: 0,
          title: Row(
            children: <Widget>[
              AppBarBackIconWidget(
                color: widget.iconColor ?? AppColors.white,
              ),
              const SizedBox(
                width: 16,
              ),
              CustomText(
                widget.title ?? '',
                style: AppTextStyle.h4(
                  color: widget.textColor ?? AppColors.white,
                ),
              ),
              const Spacer(),
              AppBarTrailingIconWidget(
                color: widget.iconColor ?? AppColors.white,
                iconPath: widget.trailingIcon ?? AppIcons.close,
                onTap: widget.trailingIconFunction,
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: widget.backgroundGradient,
            ),
          ),
        );
      case AppbarType.withTitleAndTrailing:
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: widget.color,
          elevation: 0,
          title: Row(
            children: <Widget>[
              CustomText(
                widget.title ?? '',
                style: AppTextStyle.h4(
                  color: widget.textColor ?? AppColors.white,
                ),
              ),
              const Spacer(),
              AppBarTrailingIconWidget(
                color: widget.iconColor ?? AppColors.white,
                iconPath: widget.trailingIcon ?? AppIcons.arrowDown,
                onTap: widget.trailingIconFunction,
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: widget.backgroundGradient,
            ),
          ),
        );
    }
  }
}
