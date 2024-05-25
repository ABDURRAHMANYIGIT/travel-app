import 'package:flutter/material.dart';
import '../../resources/styles/colors.dart';

class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: const BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        name,
        style: const TextStyle(color: AppColors.etrexioPurple),
      ),
    );
  }
}
