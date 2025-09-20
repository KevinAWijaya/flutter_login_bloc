abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class NavigationSelected extends NavigationState {
  final int selectedIndex;

  NavigationSelected(this.selectedIndex);
}
