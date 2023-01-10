import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ImageData extends StatelessWidget {
  const ImageData(
      {super.key,
      required this.aseetPath,
      required this.data,
      required this.label});
  final String aseetPath;
  final String data;
  final String label;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          aseetPath,
          height: size.height * 0.05,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(data),
        Text(
          label,
          style: const TextStyle(color: AppColor.grey),
        ),
      ],
    );
  }
}
