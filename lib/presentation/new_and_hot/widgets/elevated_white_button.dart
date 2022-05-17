import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';

class ElevatedWhiteButton extends StatelessWidget {
  const ElevatedWhiteButton({
    Key? key,
    required this.icon,
    required this.title,
    this.selected = false,
    required this.onPress,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final bool selected;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                !selected ? kDarkColor : kLightColor),
            backgroundColor: MaterialStateProperty.all<Color>(
                !selected ? kDarkColor : kLightColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
        onPressed: () => onPress(),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? kDarkColor : kLightColor,
            ),
            Text(
              title,
              style: TextStyle(color: selected ? kDarkColor : kLightColor),
            ),
          ],
        ));
  }
}
