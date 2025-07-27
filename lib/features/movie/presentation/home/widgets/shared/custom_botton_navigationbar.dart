import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  
  const CustomBottomNavigationBar({
    super.key, 
    required this.navigationShell,
  });

  void _onItemTap(int index) {
    // Usar goBranch es la forma recomendada con StatefulNavigationShell
    // Mantiene el estado de cada branch/pestaña
    navigationShell.goBranch(
      index,
      // Si tocas la misma pestaña, navega al inicio de esa branch
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      currentIndex: navigationShell.currentIndex,
      onTap: _onItemTap,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          activeIcon: Icon(Icons.category),
          label: 'Categorías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          activeIcon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
      ],
    );
  }
}