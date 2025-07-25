import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/bloc/get_now_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/widgets/widgets_barril.dart';

class Homev2Screen extends StatelessWidget {
  const Homev2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottonNavigationbar(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<GetNowMoviesBloc>().add(GetAllMovies());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNowMoviesBloc, GetNowMoviesState>(
      builder: (context, state) {
        if (state is GetNowMoviesLoading || state is GetNowMoviesInitial) {
          return const Center(child: CircularProgressIndicator());
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
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
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

                MovieHorizontalView(
                  movies: movies,
                  title: 'Proximamente',
                  subtitle: 'En este mes',
                  loadNextPage: () {
                    debugPrint('Llamado del padre, osea HomeScreen');
                    context.read<GetNowMoviesBloc>().add(LoadNextPage());
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
