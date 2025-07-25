import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:peliculas_app/di/injection.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_now_movies_bloc.dart/get_now_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_popular_movies/get_popular_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/screen/homev2_screen.dart';
import 'package:peliculas_app/features/movie/presentation/movie/screen/movie_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    
    GoRoute(
      path: '/',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<GetNowMoviesBloc>()),
          BlocProvider(create: (_) => sl<GetPopularMoviesBloc>()),
        ],
        child: const Homev2Screen(),
      ),
    ),

    GoRoute(
      path: 'movie:id',
      builder: (context, state) { 
        final movieID = state.pathParameters['id'] ?? 'no ID';
        return MultiBlocProvider(

        providers: [
        ],
        child:  MovieScreen(movieId: movieID,),
      );
      }
    ),
  ],
);
