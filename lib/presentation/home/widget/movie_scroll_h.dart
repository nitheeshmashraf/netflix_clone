import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widget/movie_card.dart';
import 'package:netflix_clone/presentation/search/widget/seatch_title.dart';

class MovieScrollH extends StatelessWidget {
  const MovieScrollH({
    Key? key,
    required this.title,
    this.showIndex = false,
  }) : super(key: key);
  final String title;
  final bool showIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchScreenTitle(title: title),
        kHeight20,
        LimitedBox(
          maxHeight: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => MovieCard(
              index: index,
              showIndex: showIndex,
            ),
            itemCount: 10,
            separatorBuilder: (context, index) => kWidth20,
          ),
        ),
      ],
    );
  }
}
