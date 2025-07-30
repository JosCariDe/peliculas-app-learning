
import 'package:get_it/get_it.dart';
import 'package:peliculas_app/features/credit/data/data_sources/remote/cast_dio_data_source_impl.dart';
import 'package:peliculas_app/features/credit/data/data_sources/remote/cast_remote_data_source.dart';
import 'package:peliculas_app/features/credit/data/repositories/cast_respository_impl.dart';
import 'package:peliculas_app/features/credit/domain/case_use/get_actors_case_use.dart';
import 'package:peliculas_app/features/credit/domain/repositories/cast_repository.dart';
import 'package:peliculas_app/features/credit/presentation/actor/bloc/get_actors_bloc/get_actors_bloc.dart';
import 'package:peliculas_app/features/movie/data/datasources/remote/movies_datasource_remote.dart';
import 'package:peliculas_app/features/movie/data/datasources/remote/movies_remote_datasource_impl.dart';
import 'package:peliculas_app/features/movie/data/repositories/movies_repository_impl.dart';
import 'package:peliculas_app/features/movie/domain/cases_uses/get_movie_by_id_use_case.dart';
import 'package:peliculas_app/features/movie/domain/cases_uses/get_now_playing_use_case.dart';
import 'package:peliculas_app/features/movie/domain/cases_uses/get_popular_use_case.dart';
import 'package:peliculas_app/features/movie/domain/repositories/movies_repository.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_now_movies_bloc.dart/get_now_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_popular_movies/get_popular_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/movie/bloc/get_movie_by_id/get_movie_by_id_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //? DataSources 
    //? MOVIES
  sl.registerLazySingleton<MoviesDatasourceRemote>(
    () => MoviesRemoteDatasourceImpl(),
  );

  sl.registerLazySingleton<CastRemoteDataSource>(
    () => CastDioDataSourceImpl(),
    );

  //? Repositories
    //? MOVIES
  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(movieDataSource: sl()),
  );

  sl.registerLazySingleton<CastRepository>(
    () => CastRespositoryImpl(castRemoteDataSource: sl()),
  );

  
  //? CASOS DE USO
     //? MOVIES
  sl.registerLazySingleton<GetNowPlayingUseCase>(
    () => GetNowPlayingUseCase(movieRepository: sl()),
  );

  sl.registerLazySingleton<GetPopularUseCase>(
    () => GetPopularUseCase(movieRepository: sl()),
  );

  sl.registerLazySingleton<GetMovieByIdUseCase>(
    () => GetMovieByIdUseCase(repository: sl()),
  );
  
  sl.registerLazySingleton<GetActorsCaseUse>(
    () => GetActorsCaseUse(castRepository: sl()),
  );


  //? BLoC
    //? MOVIES
  sl.registerLazySingleton<GetNowMoviesBloc>(
    () => GetNowMoviesBloc(getNowPlayingUseCase: sl()),
  );

  sl.registerLazySingleton<GetPopularMoviesBloc>(
    () => GetPopularMoviesBloc(getPopularUseCase: sl()),
  );

  // Usamos registerFactory para que cree una nueva instancia cada vez que se necesite.
  // Esto es ideal para Blocs que están atados a una pantalla específica y necesitan
  // un estado limpio en cada visita.
  sl.registerFactory<GetMovieByIdBloc>(
    () => GetMovieByIdBloc(getMovieUseCase: sl()),
  );

  sl.registerFactory<GetActorsBloc>(
    () => GetActorsBloc(getActorsUseCase: sl()),
  );
}
