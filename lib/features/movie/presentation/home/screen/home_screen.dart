import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/get_now_movies_bloc.dart/get_now_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/widgets/shared/custom_app_bar.dart'; // Import CustomAppBar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildMovies(List<Movie> movies) => ListView.builder(
    itemCount: movies.length,
    itemBuilder: (context, index) => ListTile(
      title: Text(movies[index].title),
      subtitle: Text(movies[index].overview),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // Use CustomAppBar
      body: Center(
        child: BlocBuilder<GetNowMoviesBloc, GetNowMoviesState>(
          builder: (context, state) {
            if (state is GetNowMoviesInitial || state is GetNowMoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetNowMoviesFailure) {
              return Center(child: Text(state.message));
            }

            if (state is GetNowMoviesSuccess) {
              final movies = state.movies;
              if (movies.isEmpty) {
                return const Center(
                  child: Text('Ningun Movie en el list que llega al UI'),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12), // Corrected EdgeInsetsGeometry
                child: _buildMovies(movies),
              );
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
      floatingActionButton: IconButton(onPressed: () {
        context.read<GetNowMoviesBloc>().add(LoadNextPage());
      }, icon: const Icon(Icons.refresh_rounded)),
    );
  }
}
