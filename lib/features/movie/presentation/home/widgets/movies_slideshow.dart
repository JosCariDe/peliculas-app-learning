import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:responsive_framework/responsive_framework.dart';


class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});
  

  @override
  Widget build(BuildContext context) {

    final colors= Theme.of(context).colorScheme;

    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Swiper(
        viewportFraction: ResponsiveBreakpoints.of(context).isMobile ? 0.8 : 0.3,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.blueAccent,
            color: colors.secondary
          )
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _Slide(movie: movie);
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 10)),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(decoration: BoxDecoration(color: Colors.black12));
              }
              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}
