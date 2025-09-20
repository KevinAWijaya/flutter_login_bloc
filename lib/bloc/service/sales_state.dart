import 'package:wisdom_pos_test/data/models/ticket.dart';

import '../../data/models/service.dart';

abstract class SalesState {}

class SalesInitial extends SalesState {}

class SalesLoading extends SalesState {}

class SalesLoaded extends SalesState {
  final List<Service> services;
  final List<Ticket> tickets;
  final String selectedCategory;
  final DateTime selectedDate;

  SalesLoaded({required this.services, required this.tickets, required this.selectedCategory, required this.selectedDate});

  SalesLoaded copyWith({
    List<Service>? services,
    List<Ticket>? tickets,
    String? selectedCategory,
    DateTime? selectedDate,
  }) {
    return SalesLoaded(
      services: services ?? this.services,
      tickets: tickets ?? this.tickets,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class SalesError extends SalesState {
  final String message;

  SalesError(this.message);
}
