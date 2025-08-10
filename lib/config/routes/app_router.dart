import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:peliculas_app/di/injection.dart';
import 'package:peliculas_app/features/movie/presentation/favorites/screen/favorite_screen.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_now_movies_bloc.dart/get_now_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_popular_movies/get_popular_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/screen/homev2_screen.dart';
import 'package:peliculas_app/features/credit/presentation/actor/bloc/get_actors_bloc/get_actors_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/movie/bloc/get_movie_by_id/get_movie_by_id_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/movie/screen/movie_screen.dart';
import 'package:peliculas_app/features/movie/presentation/search/blocs/search_movie_bloc/search_movie_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/view_movies/screen/home_view.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> _shellNavigatorCategoriesKey = GlobalKey<NavigatorState>(debugLabel: 'shellCategories');
final GlobalKey<NavigatorState> _shellNavigatorFavoritesKey = GlobalKey<NavigatorState>(debugLabel: 'shellFavorites');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Homev2Screen(navigationShell: navigationShell);
      },
      branches: [
        // Branch for the Home tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => sl<GetNowMoviesBloc>()),
                  BlocProvider(create: (_) => sl<GetPopularMoviesBloc>()),
                  BlocProvider(create: (_) => sl<SearchMovieBloc>(),  )
                ],
                child: const HomeView(),
              ),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  builder: (context, state) {
                    final movieID = state.pathParameters['id'] ?? 'no-id';
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (_) => sl<GetMovieByIdBloc>()
                            ..add(GetMovieUseCase(idMovie: movieID)),
                        ),
                        BlocProvider(
                          create: (_) => sl<GetActorsBloc>()
                            ..add(GetActorsUseCaseEvent(
                                idMovie: int.tryParse(movieID) ?? 0)),
                        ),
                      ],
                      child: MovieScreen(movieId: movieID),
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // Branch for the Categories tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCategoriesKey,
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('Pantalla de Categorías')),
              ),
            ),
          ],
        ),

        // Branch for the Favorites tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFavoritesKey,
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return const FavoriteScreen();
              },
            ),
          ],
        ),
      ],
    ),

  ],
);
