import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wisdom_pos_test/bloc/auth/login_bloc.dart';
import 'package:wisdom_pos_test/bloc/service/sales_bloc.dart';
import 'package:wisdom_pos_test/bloc/service/sales_event.dart';
import 'package:wisdom_pos_test/bloc/service/sales_state.dart';
import 'package:wisdom_pos_test/core/color.dart';
import 'package:wisdom_pos_test/core/constants/constants.dart';
import 'package:wisdom_pos_test/data/models/ticket.dart';
import 'package:wisdom_pos_test/data/repositories/auth_repository.dart';
import 'package:wisdom_pos_test/data/repositories/session_repository.dart';
import 'package:wisdom_pos_test/ui/auth/login_page.dart';
import 'package:wisdom_pos_test/ui/menu/home/service_ticket_by_category_list.dart';
import 'package:wisdom_pos_test/ui/menu/home/service_ticket_list.dart';
import 'package:wisdom_pos_test/ui/menu/search/search_ticket_page.dart';

import '../../data/models/service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildCategoryButton(BuildContext context, String label, IconData icon, bool isSelected) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              context.read<SalesBloc>().add(CategorySelected(label));
            },
            customBorder: const CircleBorder(),
            splashColor: VColor.black.withOpacity(0.5),
            highlightColor: VColor.black.withOpacity(0.3),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(color: Colors.white38),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.blue.shade900 : Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateFormat("yyyy-MM-dd").parse(DateTime(2024, 8, 5).toString());
    return Scaffold(
      backgroundColor: VColor.primary,
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              SalesBloc(serviceRepository: RepositoryProvider.of(context), ticketRepository: RepositoryProvider.of(context))..add(LoadServices(now)),
          child: BlocBuilder<SalesBloc, SalesState>(
            builder: (context, state) {
              if (state is SalesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SalesError) {
                return Center(child: Text(state.message));
              } else if (state is SalesLoaded) {
                final selected = state.selectedCategory;
                final services = state.services;
                final tickets = state.tickets;

                final filteredServices = selected == 'All'
                    ? services.where((s) => s.active == 1).toList()
                    : services.where((s) => s.name?.toLowerCase() == selected.toLowerCase() && s.active == 1).toList();
                final groupedTickets = groupAndSortTicketsByService(
                  services: filteredServices,
                  tickets: tickets,
                );
                int totalGrandTotal = groupedTickets.fold<int>(
                  0,
                  (sum, entry) =>
                      sum +
                      entry.value.fold<int>(
                        0,
                        (subtotal, ticket) => subtotal + (ticket.grandTotal ?? 0),
                      ),
                );

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(
                        tickets: tickets,
                        grandTotal: totalGrandTotal,
                        selectedDate: state.selectedDate,
                        onPickDate: () => _pickDate(context, state.selectedDate),
                        context: context,
                      ),
                      _categoryMenu(context, selected),
                      const SizedBox(height: 16),
                      _servicesList(groupedTickets, selected),
                    ],
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _header({
    required List<Ticket> tickets,
    required int grandTotal,
    required DateTime selectedDate,
    required VoidCallback onPickDate,
    required BuildContext context,
  }) {
    final formattedDate = DateFormat('EEE, dd MMM yyyy').format(selectedDate);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onPickDate,
                  child: Row(
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Sales: ${tickets.length} · \$${grandTotal.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  final state = context.read<SalesBloc>().state;
                  if (state is SalesLoaded) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchTicketPage(tickets: state.tickets),
                      ),
                    );
                  }
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 28,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () async {
                  context.read<SalesBloc>().add(LogOut());
                  final authRepo = RepositoryProvider.of<AuthRepository>(context);
                  final sessonRepo = RepositoryProvider.of<SessionRepository>(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => LoginBloc(authRepo, sessonRepo),
                        child: const LoginPage(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.white, size: 28),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _categoryMenu(BuildContext context, String selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCategoryButton(context, 'All', Constans.iconList[0], selected == 'All'),
          _buildCategoryButton(context, 'Dine In', Constans.iconList[1], selected == 'Dine In'),
          _buildCategoryButton(context, 'Take Away', Constans.iconList[2], selected == 'Take Away'),
          _buildCategoryButton(context, 'Delivery', Constans.iconList[3], selected == 'Delivery'),
          _buildCategoryButton(context, 'General', Constans.iconList[4], selected == 'General'),
        ],
      ),
    );
  }

  Widget _servicesList(List<MapEntry<Service, List<Ticket>>> groupedTickets, String selected) {
    if (selected == "All") {
      return Container(
        constraints: const BoxConstraints(minHeight: 800),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ServiceTicketList(groupedTickets: groupedTickets),
      );
    } else {
      return Container(
        constraints: const BoxConstraints(minHeight: 800),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ServiceTicketByGroupList(groupedTickets: groupedTickets),
      );
    }
  }

  Future<void> _pickDate(BuildContext context, DateTime initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: VColor.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: VColor.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      context.read<SalesBloc>().add(DateSelected(picked));
    }
  }
}

/// grouping ticket by services
List<MapEntry<Service, List<Ticket>>> groupAndSortTicketsByService({
  required List<Service> services,
  required List<Ticket> tickets,
}) {
  final Map<int, Service> serviceMap = {
    for (var service in services)
      if (service.id != null) service.id!: service,
  };

  // Step 1: Initialize result with all services (empty ticket list)
  final Map<Service, List<Ticket>> result = {
    for (var service in services)
      if (service.id != null) service: [],
  };

  // Step 2: Group tickets into their corresponding services
  for (var ticket in tickets) {
    final serviceId = ticket.fkService;

    if (serviceId == null || !serviceMap.containsKey(serviceId)) continue;

    final service = serviceMap[serviceId]!;

    result[service]!.add(ticket);
  }

  // Step 3: Sort by service.id
  final sortedEntries = result.entries.toList()..sort((a, b) => (a.key.id ?? 0).compareTo(b.key.id ?? 0));

  return sortedEntries;
}
