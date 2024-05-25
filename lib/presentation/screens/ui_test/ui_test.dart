import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/styles/colors.dart';
import '../../layouts/main_layout.dart';

class UiTestScreen extends StatelessWidget {
  const UiTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('build');
    return MainLayout(
      backgroundColor: AppColors.white,
      content: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              color: AppColors.etrexioPurple,
            ),
          ],
        ),
      ),
    );
  }
}
