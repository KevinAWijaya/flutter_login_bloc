abstract class SalesEvent {}

class LoadServices extends SalesEvent {
  final DateTime selectedDate;

  LoadServices(this.selectedDate);
}

class CategorySelected extends SalesEvent {
  final String category;
  CategorySelected(this.category);
}

class DateSelected extends SalesEvent {
  final DateTime selectedDate;

  DateSelected(this.selectedDate);
}

class LogOut extends SalesEvent {}
