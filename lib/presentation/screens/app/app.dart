import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(switch (navigationShell.currentIndex) {
        1 => 'Favorites',
        2 => 'Profile',
        _ => 'Products'
      })),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: 'Products', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Favorites', icon: Icon(Icons.favorite)),
          NavigationDestination(label: 'Profile', icon: Icon(Icons.person)),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
