import 'package:flutter/material.dart';
import 'package:netflix_clone/presentation/fast_laugh/widget/video_list_item.dart';
import 'package:netflix_clone/presentation/home/widget/custom_button.dart';

class BottomPositionedButtons extends StatelessWidget {
  const BottomPositionedButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.center,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VideoActionsWidget(
                  title: "My List", icon: Icons.add, onPress: () {}),
              const CustomButtonWidget(),
              VideoActionsWidget(
                  title: "Info",
                  icon: Icons.info_outline_rounded,
                  onPress: () {}),
            ]),
      ),
    );
  }
}
