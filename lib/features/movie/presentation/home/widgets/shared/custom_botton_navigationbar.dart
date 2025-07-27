import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavigationBar({
    super.key,
    required this.navigationShell,
  });

  void _onItemTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {

    final styles = Theme.of(context).colorScheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 16.0),
        child: GNav(
          selectedIndex: navigationShell.currentIndex,
          onTabChange: _onItemTap,
          color: colors.onSurface,
          activeColor: colors.primary,
          tabBackgroundColor: colors.primary.withValues(alpha: 0.1),
          gap: 0,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Inicio',
            ),
            GButton(
              icon: Icons.category_outlined,
              text: 'Categorías',
            ),
            GButton(
              icon: Icons.favorite_outline,
              text: 'Favoritos',
            ),
          ],
        ),
      ),
    );
  }
}
