import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:peliculas_app/di/injection.dart';
import 'package:peliculas_app/features/movie/presentation/home/bloc/bloc/get_now_movies_bloc.dart';
import 'package:peliculas_app/features/movie/presentation/home/screen/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<GetNowMoviesBloc>()),
            ], 
            child: const HomeScreen()
          ),
    ),
  ],
);
