import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wisdom_pos_test/bloc/auth/login_bloc.dart';
import 'package:wisdom_pos_test/bloc/auth/login_event.dart';
import 'package:wisdom_pos_test/bloc/service/sales_bloc.dart';
import 'package:wisdom_pos_test/bloc/service/sales_event.dart';
import 'package:wisdom_pos_test/bloc/service/sales_state.dart';
import 'package:wisdom_pos_test/core/color.dart';
import 'package:wisdom_pos_test/core/constants/constants.dart';
import 'package:wisdom_pos_test/core/constants/size.dart';
import 'package:wisdom_pos_test/core/constants/space.dart';
import 'package:wisdom_pos_test/data/models/ticket.dart';
import 'package:wisdom_pos_test/ui/auth/login_page.dart';
import 'package:wisdom_pos_test/ui/menu/search/search_ticket_page.dart';
import 'package:wisdom_pos_test/ui/widgets/button_icon.dart';
import 'package:wisdom_pos_test/ui/widgets/text.dart';

import '../../data/models/service.dart';
import 'home/service_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildCategoryButton(BuildContext context, String label, IconData icon, bool isSelected) {
    return Column(
      children: [
        VButtonIcon(
          icon: icon,
          isSelected: isSelected,
          onTap: () {
            context.read<SalesBloc>().add(CategorySelected(label));
          },
        ),
        spaceVerticalSmall,
        VText(
          label,
          fontSize: textSizeSmall,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateFormat("yyyy-MM-dd").parse(DateTime(2024, 8, 5).toString());
    return Scaffold(
      backgroundColor: VColor.surface,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SalesBloc(
              serviceRepository: RepositoryProvider.of(context), ticketRepository: RepositoryProvider.of(context))
            ..add(LoadServices(now)),
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

                return CustomScrollView(
                  slivers: [
                    // Header
                    SliverToBoxAdapter(
                      child: _header(
                        tickets: tickets,
                        grandTotal: totalGrandTotal,
                        selectedDate: state.selectedDate,
                        onPickDate: () => _pickDate(context, state.selectedDate),
                        context: context,
                      ),
                    ),

                    // Category menu
                    SliverToBoxAdapter(
                      child: _categoryMenu(context, selected),
                    ),

                    SliverToBoxAdapter(child: spaceVerticalMedium),

                    // Service list yang scrollable
                    _servicesList(groupedTickets, selected),

                    // filler biar background bawah sama
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        color: VColor.surfaceContainer,
                      ),
                    ),
                  ],
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
                      VText(
                        formattedDate,
                        fontSize: textSizeLarge,
                      ),
                      spaceHorizontalSuperSmall,
                      const Icon(Icons.keyboard_arrow_down, color: VColor.onSurface),
                    ],
                  ),
                ),
                spaceVerticalSuperSmall,
                VText(
                  'Sales: ${tickets.length} · \$${grandTotal.toStringAsFixed(2)}',
                  color: VColor.onSurface.withValues(alpha: 0.5),
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
                  color: VColor.onSurface,
                  size: iconMedium,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              spaceHorizontalLarge,
              IconButton(
                onPressed: () async {
                  context.read<LoginBloc>().add(LogoutRequested());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                icon: const Icon(Icons.logout, color: VColor.onSurface, size: iconMedium),
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
      padding: const EdgeInsets.symmetric(horizontal: marginLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCategoryButton(context, 'All', Constans.iconList[0], selected == 'All'),
          spaceHorizontalSmall,
          _buildCategoryButton(context, 'Dine In', Constans.iconList[1], selected == 'Dine In'),
          spaceHorizontalSmall,
          _buildCategoryButton(context, 'Take Away', Constans.iconList[2], selected == 'Take Away'),
          spaceHorizontalSmall,
          _buildCategoryButton(context, 'Delivery', Constans.iconList[3], selected == 'Delivery'),
          spaceHorizontalSmall,
          _buildCategoryButton(context, 'General', Constans.iconList[4], selected == 'General'),
        ],
      ),
    );
  }

  Widget _servicesList(List<MapEntry<Service, List<Ticket>>> groupedTickets, String selected) {
    if (selected == "All") {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final entry = groupedTickets[index];
            final service = entry.key;
            final tickets = entry.value;

            return Container(
              decoration: const BoxDecoration(
                color: VColor.surfaceContainer,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: marginMedium),
                child: ServiceCard(
                  service: service,
                  tickets: tickets,
                ),
              ),
            );
          },
          childCount: groupedTickets.length,
        ),
      );
    } else {
      final entry = groupedTickets[0];
      final service = entry.key;
      final tickets = entry.value;

      Service openService = Service(id: service.id, name: "Open");
      final openTickets = tickets.where((element) => element.paid == null).toList();
      Service closeService = Service(id: service.id, name: "Closed");
      final closedTickets = tickets.where((element) => element.paid != null).toList();

      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              decoration: const BoxDecoration(
                color: VColor.surfaceContainer,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: marginMedium),
                child: Column(
                  children: [
                    ServiceCard(service: openService, tickets: openTickets),
                    ServiceCard(service: closeService, tickets: closedTickets),
                  ],
                ),
              ),
            ),
          ],
        ),
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
