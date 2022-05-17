import 'package:dartz/dartz.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/models/hot_and_new/hot_and_new_response/hot_and_new_response.dart';

abstract class HotAndNewService {
  Future<Either<MainFailure, HotAndNewResponse>> getHotandNewMovieData();
  Future<Either<MainFailure, HotAndNewResponse>> getHotandNewTVData();
}
