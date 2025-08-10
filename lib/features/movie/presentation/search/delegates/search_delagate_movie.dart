import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/search/blocs/search_movie_bloc/search_movie_bloc.dart';

class SearchDelegateMovie extends SearchDelegate<String?> {
  final SearchMovieBloc bloc;
  String _lastQuery = '';

  SearchDelegateMovie({String? hint, required this.bloc}) {
    if (hint != null) query = hint;
  }

  @override
  String? get searchFieldLabel => 'Buscar Movies...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
            _lastQuery = '';
            bloc.add(SearchClearedEvent());
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  // buildResults -> se dispara al confirmar (enter / submit)
  @override
  Widget buildResults(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final trimmed = query.trim();
    if (trimmed != _lastQuery) {
      _lastQuery = trimmed;
      if (trimmed.isEmpty) {
        bloc.add(SearchClearedEvent());
      } else {
        bloc.add(SearchMovieImplEvent(query: trimmed));
      }
    }

    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      bloc: bloc, // <- importante: pasar el bloc aquí
      builder: (context, state) {
        if (state is SearchMovieInitial) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.search, size: 40),
                SizedBox(height: 20),
                Text('Escribe algo para buscar tu peli favorita', textAlign: TextAlign.center),
              ],
            ),
          );
        } else if (state is SearchMovieLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchMovieError) {
          return Center(
            child: Column(
              children: [
                const Icon(Icons.error, color: Colors.red, size: 40),
                const SizedBox(height: 20),
                Text(state.message, textAlign: TextAlign.center, style: textTheme.bodyMedium!.copyWith(color: Colors.red)),
              ],
            ),
          );
        } else if (state is SearchMovieSuccess) {
          final listMovies = state.moviesResultSearch;
          if (listMovies.isEmpty) {
            return const Center(child: Text('No se encontraron resultados'));
          }
          return ListView.builder(
            itemCount: listMovies.length,
            itemBuilder: (context, index) => ListTile(title: Text(listMovies[index].title)),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  // buildSuggestions -> mientras escribe
  @override
  Widget buildSuggestions(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final trimmed = query.trim();

    // Evitar añadir eventos idénticos repetidamente
    if (trimmed != _lastQuery) {
      _lastQuery = trimmed;
      if (trimmed.isEmpty) {
        bloc.add(SearchClearedEvent());
      } else {
        bloc.add(SearchMovieImplEvent(query: trimmed));
      }
    }

    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      bloc: bloc, // <- importante también aquí
      builder: (context, state) {
        if (state is SearchMovieInitial) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.search, size: 40),
                SizedBox(height: 20),
                Text('Escribe algo para buscar tu peli favorita', textAlign: TextAlign.center),
              ],
            ),
          );
        } else if (state is SearchMovieLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchMovieError) {
          return Center(
            child: Column(
              children: [
                const Icon(Icons.error, color: Colors.red, size: 40),
                const SizedBox(height: 20),
                Text(state.message, textAlign: TextAlign.center, style: textTheme.bodyMedium!.copyWith(color: Colors.red)),
              ],
            ),
          );
        } else if (state is SearchMovieSuccess) {
          final listMovies = state.moviesResultSearch;
          if (listMovies.isEmpty) {
            return const Center(child: Text('No se encontraron sugerencias'));
          }
          return ListView.builder(
            itemCount: listMovies.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(listMovies[index].title),
              onTap: () {
                query = listMovies[index].title;
                showResults(context);
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
