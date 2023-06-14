import 'package:flutter/material.dart';

class TotalBox extends StatelessWidget {
  final String title;
  final String amount;
  final Color colors;

  const TotalBox(
      {Key? key,
      required this.title,
      required this.amount,
      required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: colors,
            ),
          ),
          SizedBox(height: 10),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              color: colors,
            ),
          ),
        ],
      ),
    );
  }
}
