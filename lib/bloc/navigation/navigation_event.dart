abstract class NavigationEvent {}

class SelectTabEvent extends NavigationEvent {
  final int tabIndex;

  SelectTabEvent(this.tabIndex);
}
