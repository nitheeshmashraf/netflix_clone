import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/models/downloads/downloads.dart';
import 'package:netflix_clone/domain/models/downloads/i_downloads_repo.dart';
import 'package:netflix_clone/domain/models/search/search_response/search_response.dart';
import 'package:netflix_clone/domain/models/search/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadsService;
  final SearchService _searchService;
  SearchBloc(this._downloadsService, this._searchService)
      : super(SearchState.initial()) {
    on<Initialize>((event, emit) async {
      if (state.searchResultList.isNotEmpty) {
        emit(SearchState(
            isLoading: false,
            isError: false,
            searchResultList: state.searchResultList,
            idleList: []));
        return;
      }
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
            isLoading: false,
            isError: false,
            searchResultList: [],
            idleList: state.idleList));
        return;
      }
      emit(const SearchState(
          isLoading: true, isError: false, searchResultList: [], idleList: []));
      final _result = await _downloadsService.getDownloadsImages();
      emit(_result.fold(
          (l) => state.copyWith(isLoading: false, isError: true),
          (r) => state.copyWith(
              isLoading: false,
              isError: false,
              idleList: r,
              searchResultList: [])));
    });
    on<SearchMovie>((event, emit) async {
      final _result =
          await _searchService.searchMovies(movieQuery: event.movieQuery);

      emit(_result.fold(
          (l) => state.copyWith(isLoading: false, isError: true),
          (r) => state.copyWith(
              isLoading: false,
              isError: false,
              idleList: [],
              searchResultList: r.results)));
    });
  }
}
