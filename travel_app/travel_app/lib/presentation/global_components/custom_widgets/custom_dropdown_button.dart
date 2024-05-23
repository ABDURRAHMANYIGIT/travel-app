import 'package:flutter/material.dart';
import '../../../resources/styles/colors.dart';
import '../texts/custom_text.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  const CustomDropdownButton(
      {super.key,
      required this.title,
      required this.callback,
      required this.hintText,
      required this.optionList,
      required this.showingProperty,
      this.selectedValue,
      this.subtitle});
  final String title;
  final String hintText;
  final String? subtitle;
  final Function(dynamic) callback;
  final List<T> optionList;
  final String? showingProperty;
  final T? selectedValue;

  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  dynamic selectedItem;
  @override
  void initState() {
    selectedItem = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomText(
          widget.title,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: DropdownButtonFormField<dynamic>(
            hint: Text(
              widget.hintText,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.grey,
              ),
            ),
            value: selectedItem,
            dropdownColor: AppColors.etrexioPurple,
            validator: (dynamic value) =>
                value == null ? 'This field is required' : null,
            items: widget.optionList.map<DropdownMenuItem<dynamic>>(
              (dynamic value) {
                String text = '';
                if (widget.showingProperty == null) {
                  text = value as String;
                } else {
                  text = (value.toJson()
                          as Map<String, dynamic>)[widget.showingProperty]
                      .toString();
                }
                return DropdownMenuItem<dynamic>(
                  value: value,
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.grey,
                    ),
                  ),
                );
              },
            ).toList(),
            onChanged: (dynamic val) {
              selectedItem = val;
              if (selectedItem != null) {
                widget.callback(selectedItem);
              }
            },
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.grey,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.etrexioPurple,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  color: AppColors.lightGrey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  color: AppColors.etrexioPurple,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
