import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peliculas_app/config/human_formats.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';

class MovieHorizontalView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalView({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalView> createState() => _MovieHorizontalViewState();
}

class _MovieHorizontalViewState extends State<MovieHorizontalView> {

  final scroolController = ScrollController();

  @override
  void initState() {
    super.initState();

    scroolController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scroolController.position.pixels + 200) >= scroolController.position.maxScrollExtent) {
        debugPrint('Load next Page and call CallBack');

        widget.loadNextPage!();
      }      
    },);
    
    
  }

  @override
  void dispose() {
    scroolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subTitle: widget.subtitle),

          Expanded(
            child: ListView.builder(
              controller: scroolController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),

          const Spacer(),

          if (subTitle != null)
            FilledButton(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subTitle!),
            ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [  

          //* Imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 90),
                      child: Center(
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}')
                    ,
                    child: FadeIn(child: child),
                  );
                  
                },
              ),
            ),
          ),

          const SizedBox(height: 5,),
          //* Title

          SizedBox(
            width: 150,
            child: Text( 
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),

          //* Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                const SizedBox(width: 3,),
                Text('${movie.voteAverage}', style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
                const SizedBox(width: 10,),
                Spacer(),
                //Text('${ movie.popularity }', style: textStyle.bodySmall,),
                Text(HumanFormats.number(movie.popularity.toInt()), style: textStyle.bodySmall,)
              ],
            ),
          )

        ],
      ),
    );
  }
}
