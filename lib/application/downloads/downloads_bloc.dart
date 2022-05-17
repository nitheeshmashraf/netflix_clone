import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/models/downloads/downloads.dart';
import 'package:netflix_clone/domain/models/downloads/i_downloads_repo.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';
part 'downloads_bloc.freezed.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final IDownloadsRepo _downloadsRepo;
  DownloadsBloc(this._downloadsRepo) : super(DownloadsState.initial()) {
    on<_GetDownloadsImage>((event, emit) async {
      if (state.downloads.isNotEmpty) {
        emit(state.copyWith(isLoading: false, downloads: state.downloads));
        return;
      }
      emit(state.copyWith(
          isLoading: true, downloadsFailureOrSuccessOption: none()));
      final Either<MainFailure, List<Downloads>> downloadsOption =
          await _downloadsRepo.getDownloadsImages();
      log(downloadsOption.toString());
      emit(downloadsOption.fold(
          (l) => state.copyWith(
              isLoading: false, downloadsFailureOrSuccessOption: Some(Left(l))),
          (r) => state.copyWith(
              isLoading: false,
              downloads: r,
              downloadsFailureOrSuccessOption: Some(Right(r)))));
    });
  }
}
