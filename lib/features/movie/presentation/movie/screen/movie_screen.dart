import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_app/di/injection.dart';
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
        appBar: AppBar(title: Text(movieId)),
        body: BlocBuilder<GetMovieByIdBloc, GetMovieByIdState>(
          builder: (context, state) {
            if (state is GetMovieByIdLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetMovieByIdFailure) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is GetMovieByIdSucces) {
              return Center(child: Text('Movie: ${state.movie.title}'));
            }

            return const Center(child: Text('Estado inicial'));
          },
        ),
      ),
    );
  }
}
