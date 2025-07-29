import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_app/di/injection.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:peliculas_app/features/movie/presentation/movie/bloc/get_movie_by_id/get_movie_by_id_bloc.dart';

class MovieScreen extends StatelessWidget {
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetMovieByIdBloc(getMovieUseCase: sl())
            ..add(GetMovieUseCase(idMovie: movieId)),
      child: Scaffold(
        body: BlocBuilder<GetMovieByIdBloc, GetMovieByIdState>(
          builder: (context, state) {
            if (state is GetMovieByIdLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetMovieByIdFailure) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is GetMovieByIdSucces) {
              return CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [_CustomSliverAppBar(movie: state.movie)],
              );
            }

            return const Center(child: Text('Estado inicial'));
          },
        ),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(movie.posterPath, fit: BoxFit.contain),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7,1.0],
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0,0.3],
                    colors: [ Colors.black87, Colors.transparent],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
