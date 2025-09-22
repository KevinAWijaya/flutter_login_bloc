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
          backgroundColor: VColor.onSurfaceContainer,
          selectedItemColor: VColor.onSurface,
          unselectedItemColor: VColor.onSurface,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            _buildNavItem(Icons.home, "Home", 0, selectedIndex),
            _buildNavItem(Icons.shopping_cart, "New Order", 1, selectedIndex),
            _buildNavItem(Icons.bar_chart, "Report", 2, selectedIndex),
            _buildNavItem(Icons.menu, "Menu", 3, selectedIndex),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index, int selectedIndex) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == selectedIndex ? Colors.blue : Colors.transparent,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          color: index == selectedIndex ? Colors.white : VColor.onSurface,
        ),
      ),
      label: label,
    );
  }
}
