part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    required bool isLoading,
    required bool isError,
    required List<SearchResultData> searchResultList,
    required List<Downloads> idleList,
    // required Option<Either<MainFailure, List<SearchResultData>>>
    //     SearchFailureOrSuccessOption,
  }) = _SearchState;

  factory SearchState.initial() {
    return const SearchState(
        isLoading: false, isError: false, idleList: [], searchResultList: []);
  }
}
