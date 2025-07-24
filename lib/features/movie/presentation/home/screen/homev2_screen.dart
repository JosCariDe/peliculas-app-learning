import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/bloc/get_now_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/widgets/widgets_barril.dart';

class Homev2Screen extends StatelessWidget {
  const Homev2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _HomeView());
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
    final List<Movie> movies =
        context.watch<GetNowMoviesBloc>().currentMovies ?? [];

    return Column(
      children: [

        CustomAppBar(),

        Expanded(
          child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                title: Text(movie.title),
                //subtitle: Text(movies[index].overview),
              );
            },
          ),
        ),
      ],
    );
  }
}
