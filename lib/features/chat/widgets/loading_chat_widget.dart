import 'package:flutter/material.dart';
import 'package:pusher_full_chat_example/core/constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Sizes.getHeight(context),
        width: Sizes.getWidth(context),
        child: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
