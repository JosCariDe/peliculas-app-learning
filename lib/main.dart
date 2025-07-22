import 'package:flutter/material.dart';
import 'package:peliculas_app/config/routes/app_router.dart';
import 'package:peliculas_app/features/movie/presentation/screen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
