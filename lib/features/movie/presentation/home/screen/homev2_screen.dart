import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peliculas_app/features/movie/presentation/home/widgets/widgets_barril.dart';

class Homev2Screen extends StatelessWidget {

  final StatefulNavigationShell navigationShell;
  const Homev2Screen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavigationBar(navigationShell: navigationShell,),
    );
  }



}

