
import 'package:go_router/go_router.dart';
import 'package:peliculas_app/features/movie/presentation/screen/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [  

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    )
    
  ] 
);