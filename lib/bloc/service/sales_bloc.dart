import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom_pos_test/data/repositories/service_repository.dart';
import 'package:wisdom_pos_test/data/repositories/ticket_repository.dart';

import 'sales_event.dart';
import 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final ServiceRepository serviceRepository;
  final TicketRepository ticketRepository;

  SalesBloc({required this.serviceRepository, required this.ticketRepository}) : super(SalesInitial()) {
    on<LoadServices>((event, emit) async {
      emit(SalesLoading());
      try {
        final services = await serviceRepository.fetchServices();
        final tickets = await ticketRepository.fetchTickets(date: DateFormat("yyyy-MM-dd").format(event.selectedDate));
        emit(SalesLoaded(services: services, tickets: tickets, selectedCategory: 'All', selectedDate: event.selectedDate));
      } catch (e) {
        emit(SalesError(e.toString()));
      }
    });

    on<CategorySelected>((event, emit) {
      final currentState = state;
      if (currentState is SalesLoaded) {
        emit(SalesLoaded(
            services: currentState.services, tickets: currentState.tickets, selectedCategory: event.category, selectedDate: currentState.selectedDate));
      }
    });

    on<DateSelected>((event, emit) async {
      if (state is SalesLoaded) {
        final currentState = state as SalesLoaded;
        final services = await serviceRepository.fetchServices();
        final tickets = await ticketRepository.fetchTickets(date: DateFormat("yyyy-MM-dd").format(event.selectedDate));
        emit(SalesLoaded(services: services, tickets: tickets, selectedCategory: currentState.selectedCategory, selectedDate: event.selectedDate));
      }
    });

    on<LogOut>((event, emit) async {
      if (state is SalesLoaded) {
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
      }
    });
  }
}
