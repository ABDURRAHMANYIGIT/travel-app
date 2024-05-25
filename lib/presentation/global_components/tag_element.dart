import 'package:flutter/material.dart';
import '../../resources/styles/colors.dart';

class TagElement extends StatelessWidget {
  const TagElement({
    super.key,
    required this.title,
    required this.color,
  });
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(.5),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.etrexioPurple,
          fontSize: 10,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
