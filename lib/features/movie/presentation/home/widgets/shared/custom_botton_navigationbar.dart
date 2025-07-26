import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottonNavigationbar extends StatelessWidget {
  const CustomBottonNavigationbar({super.key});

  void onItemTap(BuildContext context, int index) {

    switch(index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/favorites');
        break;
      case 2:
        //context.go('/');
        break;
    }

  }

  @override
  Widget build(BuildContext context) {

    

    return BottomNavigationBar(
      elevation: 0,
      onTap: (value) {
        return onItemTap(context, value);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline_outlined),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
