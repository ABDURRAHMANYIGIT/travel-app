import 'package:flutter/material.dart';

import '../../resources/styles/default_styles.dart';
import '../global_components/UI/bottom_sheet_top_holder_widget.dart';
import 'main_layout.dart';

class BottomSheetLayout extends StatelessWidget {
  const BottomSheetLayout({
    super.key,
    this.content = const SizedBox.shrink(),
    this.scrollController,
    this.scrollPhysics,
    this.resizeToAvoidBottomInset,
  });
  final Widget content;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final bool? resizeToAvoidBottomInset;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(DefaultStyles.largeRadius),
        topRight: Radius.circular(DefaultStyles.largeRadius),
      ),
      child: MainLayout(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        content: SingleChildScrollView(
          physics: scrollPhysics ?? const ClampingScrollPhysics(),
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DefaultStyles.defaultPadding,
              vertical: DefaultStyles.halfPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const BottomSheetTopHolderWidget(),
                const SizedBox(
                  height: 20,
                ),
                content
              ],
            ),
          ),
        ),
      ),
    );
  }
}
