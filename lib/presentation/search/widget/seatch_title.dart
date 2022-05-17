import 'package:flutter/material.dart';

class SearchScreenTitle extends StatelessWidget {
  const SearchScreenTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
