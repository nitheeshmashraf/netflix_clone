import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/search/widget/seatch_title.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchScreenTitle(title: "Top Search"),
        kHeight20,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.isError) {
                return const Center(
                  child: Text("Error occured while fetching"),
                );
              }

              if (state.idleList.isEmpty) {
                return const Center(
                  child: Text("No results found"),
                );
              }

              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => TopSearchItemTile(
                        title: state.idleList[index].title ?? " ",
                        imageUrl: state.idleList[index].backdropPath ?? "",
                      ),
                  separatorBuilder: (context, index) => kHeight20,
                  itemCount: state.idleList.length);
            },
          ),
        )
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTile({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          height: 100,
          width: size.width * 0.35,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageBaseUrl + imageUrl))),
        ),
        kWidth,
        Expanded(
            child: Text(
          title,
          style: const TextStyle(fontSize: 18),
        )),
        kWidth,
        const CircleAvatar(
            backgroundColor: kLightColor,
            child: Center(
                child: Icon(
              Icons.play_circle_fill,
              color: kDarkColor,
              size: 40,
            )))
      ],
    );
  }
}
