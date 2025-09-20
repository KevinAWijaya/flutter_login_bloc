import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisdom_pos_test/bloc/navigation/navigation_bloc.dart';
import 'package:wisdom_pos_test/bloc/navigation/navigation_event.dart';
import 'package:wisdom_pos_test/bloc/navigation/navigation_state.dart';
import 'package:wisdom_pos_test/core/color.dart';

class CustomBottomNavigationBarPage extends StatelessWidget {
  const CustomBottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        int selectedIndex = 0;
        if (state is NavigationSelected) {
          selectedIndex = state.selectedIndex;
        }

        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (index) {
            context.read<NavigationBloc>().add(SelectTabEvent(index));
          },
          backgroundColor: VColor.primary,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'New Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        );
      },
    );
  }
}
