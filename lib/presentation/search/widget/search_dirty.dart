import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/core/constants.dart';

class SearchDirtyWidget extends StatelessWidget {
  const SearchDirtyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Movies & TV",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        kHeight20,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1 / 1.4,
                  children: List.generate(
                      state.searchResultList.length,
                      (index) => MainCard(
                          title:
                              state.searchResultList[index].originalTitle ?? "",
                          imageUrl:
                              state.searchResultList[index].posterPath ?? "")));
            },
          ),
        )
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  const MainCard({Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        imageUrl != ""
            ? Container(
                height: 180,
                width: size.width * 0.45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageBaseUrl + imageUrl))),
              )
            : const CircularProgressIndicator(),
        // Text(title),
        // Text(imgUrl)
      ],
    );
  }
}
