import 'package:flutter/material.dart';
import 'package:peliculas_app/features/movie/presentation/home/widgets/widgets_barril.dart';

class Homev2Screen extends StatelessWidget {

  final Widget childView;
  const Homev2Screen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar:const CustomBottonNavigationbar(),
    );
  }



}

