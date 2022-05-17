import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar(
      {Key? key,
      this.showTextButton = false,
      this.showTextTitle = false,
      this.title = "Home"})
      : super(key: key);
  final bool showTextButton;
  final bool showTextTitle;
  final String title;

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
        child: SizedBox(
          width: double.infinity,
          height: 120,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                showTextTitle
                    ? Expanded(
                        flex: 4,
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyText1,
                        ))
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            image:
                                DecorationImage(image: NetworkImage(logoUrl))),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.cast),
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
                    )
                  ],
                ),
              ]),
              kHeight10,
              showTextButton
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        TextButtonWidget(title: "TV Shows"),
                        TextButtonWidget(title: "Movies"),
                        TextButtonWidget(
                            title: "Categories", icon: Icons.arrow_drop_down)
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    Key? key,
    this.icon = Icons.abc,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            icon == Icons.abc
                ? Container()
                : Icon(
                    icon,
                    color: kLightColor,
                    size: 40,
                  )
          ],
        ));
  }
}
