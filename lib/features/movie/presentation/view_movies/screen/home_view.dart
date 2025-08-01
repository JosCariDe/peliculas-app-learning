import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_now_movies_bloc.dart/get_now_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_popular_movies/get_popular_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/screen/scroll_infinite/movie_horizontal_view.dart';
import 'package:peliculas_app/features/movie/presentation/home/widgets/movies_slideshow.dart';
import 'package:peliculas_app/features/movie/presentation/home/widgets/shared/custom_app_bar.dart';
import 'package:peliculas_app/features/movie/presentation/home/widgets/shared/full_screen_loader.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<GetNowMoviesBloc>().add(GetAllMovies());
    context.read<GetPopularMoviesBloc>().add(GetAllMoviesPopular());
  }

  @override
  Widget build(BuildContext context) {
    /*
    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      return Center(child: Text('Responsive Desing'),);
    } */

    return BlocBuilder<GetNowMoviesBloc, GetNowMoviesState>(
      builder: (context, state) {
        if (state is GetNowMoviesLoading || state is GetNowMoviesInitial) {
          return const FullScreenLoader();
        }

        if (state is GetNowMoviesFailure) {
          return Center(child: Text(state.message));
        }

        if (state is GetNowMoviesSuccess) {
          return _ContainHome(
            movies: state.movies,
            moviesSlide: state.slideMoovie ?? [],
          );
        }

        return const Center(child: Text('Something went wrong'));
      },
    );
  }
}

class _ContainHome extends StatelessWidget {
  const _ContainHome({required this.movies, required this.moviesSlide});

  final List<Movie> moviesSlide;
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppBar()),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: moviesSlide),

                MovieHorizontalView(
                  movies: movies,
                  title: 'En Cines',
                  subtitle: 'Lunes 20',
                  loadNextPage: () {
                    debugPrint('Llamado del padre, osea HomeScreen');
                    context.read<GetNowMoviesBloc>().add(LoadNextPage());
                  },
                ),
                BlocBuilder<GetPopularMoviesBloc, GetPopularMoviesState>(
                  builder: (context, statePopular) {
                    if (statePopular is GetPopularMoviesLoading ||
                        statePopular is GetPopularMoviesInitial) {
                      debugPrint('Atorado en Loading Populate');
                      return CircularProgressIndicator();
                    }
                    if (statePopular is GetPopularMoviesFailure) {
                      debugPrint('Atorado en Failure Populate');
                      return Center(child: Text(statePopular.message));
                    }
                    if (statePopular is GetPopularMoviesSuccess) {
                      debugPrint('Atorado en Success Populate');
                      return MovieHorizontalView(
                        movies: statePopular.movies,
                        title: 'Populares',
                        subtitle: 'En este mes',
                        loadNextPage: () {
                          debugPrint('Llamado del padre, osea HomeScreen');
                          context.read<GetPopularMoviesBloc>().add(
                            LoadNextPagePopular(),
                          );
                        },
                      );
                    }
                    return Center(child: Text('Algo salio mal'));
                  },
                ),

                MovieHorizontalView(
                  movies: movies,
                  title: 'Populares',
                  //subtitle: 'Lunes 20',
                  loadNextPage: () {
                    debugPrint('Llamado del padre, osea HomeScreen');
                    context.read<GetNowMoviesBloc>().add(LoadNextPage());
                  },
                ),

                MovieHorizontalView(
                  movies: movies,
                  title: 'Mejores calificadas',
                  subtitle: 'De todos los tiempos',
                  loadNextPage: () {
                    debugPrint('Llamado del padre, osea HomeScreen');
                    context.read<GetNowMoviesBloc>().add(LoadNextPage());
                  },
                ),
                SizedBox(height: 15),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
