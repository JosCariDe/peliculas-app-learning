import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/search/blocs/search_movie_bloc/search_movie_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/search/delegates/search_delagate_movie.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final bloc = context.watch<SearchMovieBloc>();

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_creation_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('CinemaPedia', style: titleStyle),
              Spacer(),
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchDelegateMovie(bloc: bloc));
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
