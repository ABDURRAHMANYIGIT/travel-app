import 'package:flutter/material.dart';

class ShimmerFullTextWidget extends StatelessWidget {
  const ShimmerFullTextWidget(
      {super.key, this.lineCount = 20, this.color = Colors.white});
  final int lineCount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ...List<Widget>.generate(
                  lineCount,
                  (int index) => Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8,
                        color: color,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
