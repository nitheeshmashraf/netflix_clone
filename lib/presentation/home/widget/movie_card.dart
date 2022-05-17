import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.index, required this.showIndex})
      : super(key: key);
  final int index;
  final bool showIndex;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: showIndex == true
            ? const EdgeInsets.only(left: 40)
            : const EdgeInsets.only(left: 0),
        width: 160,
        height: 230,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(imageUrl))),
      ),
      showIndex == true
          ? Positioned(
              bottom: -25,
              left: 0,
              child: Text(
                "${index + 1}",
                style: Theme.of(context).textTheme.headline1?.copyWith(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = kLightColor),
              ))
          : Container()
    ]);
  }
}
