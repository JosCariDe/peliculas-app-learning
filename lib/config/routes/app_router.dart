import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:peliculas_app/di/injection.dart';
import 'package:peliculas_app/features/movie/presentation/favorites/screen/favorite_screen.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_now_movies_bloc.dart/get_now_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_popular_movies/get_popular_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/screen/home_screen.dart';
import 'package:peliculas_app/features/movie/presentation/home/screen/homev2_screen.dart';
import 'package:peliculas_app/features/movie/presentation/movie/screen/movie_screen.dart';
import 'package:peliculas_app/features/movie/presentation/view_movies/screen/home_view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => sl<GetNowMoviesBloc>()),
                  BlocProvider(create: (_) => sl<GetPopularMoviesBloc>()),
                ],
                child: const HomeView(),
              ),
            ),

            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return const FavoriteScreen();
              },
            ),
          ],
        ),
      ],
      navigatorContainerBuilder:
          (
            BuildContext context,
            StatefulNavigationShell navigationShell,
            List<Widget> children,
          ) {
            return Homev2Screen(childView: navigationShell);    
          },
    ),

    /*
    ShellRoute(
      builder: (context, state, child) {
        return Homev2Screen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<GetNowMoviesBloc>()),
              BlocProvider(create: (_) => sl<GetPopularMoviesBloc>()),
            ],
            child: const HomeView(),
          ),
        ),

        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoriteScreen();
          },
        ),
      ],
    ),
    */

    /*    
    GoRoute(
      path: '/',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<GetNowMoviesBloc>()),
          BlocProvider(create: (_) => sl<GetPopularMoviesBloc>()),
        ],
        child: const Homev2Screen(childView: HomeView(),),
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
    */
  ],
);
