import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';

import 'package:netflix_clone/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
              0.2,
              1,
            ],
                colors: [
              kDarkColor,
              Colors.transparent,
            ])),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
              const Spacer(),
              const Icon(
                Icons.cast,
              ),
              kWidth,
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.cyan,
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.01,
                          0.8,
                        ],
                        colors: [
                          Color.fromARGB(255, 1, 55, 55),
                          Color.fromARGB(255, 2, 94, 94),
                        ])),
              ),
              kWidth,
            ],
          ),
        ));
  }
}
