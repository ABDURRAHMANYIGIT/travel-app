import 'package:flutter/material.dart';

import '../../domain/router/route.dart';
import '../../resources/file_paths/icons.dart';
import '../../resources/styles/colors.dart';

// TODO(ALL): UPDATE TAB VALUES, SENTENCES, COLORS AND ICONS
enum BottomBarItem { tab1, tab2, tab3, tab4 }

Map<BottomBarItem, String> tabName = <BottomBarItem, String>{
  BottomBarItem.tab1: 'tab1',
  BottomBarItem.tab2: 'tab2',
  BottomBarItem.tab3: 'tab3',
  BottomBarItem.tab4: 'tab4',
};
Map<BottomBarItem, String> tabRoute = <BottomBarItem, String>{
  BottomBarItem.tab1: AppRouter.designRoute,
  BottomBarItem.tab2: AppRouter.designRoute,
  BottomBarItem.tab3: AppRouter.designRoute,
  BottomBarItem.tab4: AppRouter.designRoute,
};

const Map<BottomBarItem, Color> activeTabColor = <BottomBarItem, Color>{
  BottomBarItem.tab1: AppColors.etrexioPurple,
  BottomBarItem.tab2: AppColors.etrexioPurple,
  BottomBarItem.tab3: AppColors.etrexioPurple,
  BottomBarItem.tab4: AppColors.etrexioPurple,
};

extension BottomBarItemExtension on BottomBarItem {
  String get icon {
    switch (this) {
      case BottomBarItem.tab1:
        return AppIcons.close;
      case BottomBarItem.tab2:
        return AppIcons.close;
      case BottomBarItem.tab3:
        return AppIcons.close;
      case BottomBarItem.tab4:
        return AppIcons.close;
    }
  }

  String get activeIcon {
    switch (this) {
      case BottomBarItem.tab1:
        return AppIcons.arrowLeft;
      case BottomBarItem.tab2:
        return AppIcons.arrowLeft;
      case BottomBarItem.tab3:
        return AppIcons.arrowLeft;
      case BottomBarItem.tab4:
        return AppIcons.arrowLeft;
    }
  }

  String get tabName {
    switch (this) {
      case BottomBarItem.tab1:
        return 'tab1';
      case BottomBarItem.tab2:
        return 'tab2';
      case BottomBarItem.tab3:
        return 'tab3';
      case BottomBarItem.tab4:
        return 'tab4';
    }
  }
}
