
import 'package:get_it/get_it.dart';
import 'package:peliculas_app/features/movie/data/datasources/remote/movies_datasource_remote.dart';
import 'package:peliculas_app/features/movie/data/datasources/remote/movies_remote_datasource_impl.dart';
import 'package:peliculas_app/features/movie/data/repositories/movies_repository_impl.dart';
import 'package:peliculas_app/features/movie/domain/cases_uses/get_now_playing_use_case.dart';
import 'package:peliculas_app/features/movie/domain/repositories/movies_repository.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/bloc/get_now_movies_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //? DataSources 
    //? MOVIES
  sl.registerLazySingleton<MoviesDatasourceRemote>(
    () => MoviesRemoteDatasourceImpl(),
  );

  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(movieDataSource: sl()),
  );

  sl.registerLazySingleton<GetNowPlayingUseCase>(
    () => GetNowPlayingUseCase(movieRepository: sl()),
  );

  sl.registerLazySingleton<GetNowMoviesBloc>(
    () => GetNowMoviesBloc(getNowPlayingUseCase: sl()),
  );
}