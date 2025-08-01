
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:peliculas_app/features/movie/domain/repositories/movies_repository.dart';

class GetNowPlayingUseCase {

  final MoviesRepository movieRepository;

  GetNowPlayingUseCase({required this.movieRepository});

  Future<Either<Failure, List<Movie>>> call({int page = 1}){
    debugPrint('Page en caso de uso: ${page.toString()}');
    return movieRepository.getNowPlaying(page: page);
  }


}