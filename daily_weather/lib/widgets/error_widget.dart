// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// ignore: must_be_immutable
class CustomErrorWidget extends StatelessWidget {
  String? error_msg = "";
  CustomErrorWidget({
    Key? key,
    required this.error_msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            error_msg ?? "Opps! Try again later!",
            style: const TextStyle(color: AppColor.white, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/empty_box.png',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ],
      ),
    );
  }
}
