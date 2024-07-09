import 'package:flutter/material.dart';

import '../../../utils/app_text_style.dart';

class OptionOrWidget extends StatelessWidget {
  const OptionOrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.white54,
            height: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'OR',
            style: AppTextStyle.textStyle14,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.white54,
            height: 1,
          ),
        ),
      ],
    );
  }
}
