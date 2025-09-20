import 'package:flutter/material.dart';
import 'package:wisdom_pos_test/data/models/service.dart';
import 'package:wisdom_pos_test/data/models/ticket.dart';
import 'package:wisdom_pos_test/ui/menu/home/service_card.dart';

class ServiceTicketByGroupList extends StatelessWidget {
  final List<MapEntry<Service, List<Ticket>>> groupedTickets;

  const ServiceTicketByGroupList({super.key, required this.groupedTickets});

  @override
  Widget build(BuildContext context) {
    final entry = groupedTickets[0];
    final service = entry.key;
    final tickets = entry.value;

    Service openService = Service(id: service.id, name: "Open");
    final openTickets = tickets.where((element) => element.paid == null).toList();
    Service closeService = Service(id: service.id, name: "Closed");
    final closedTickets = tickets.where((element) => element.paid != null).toList();

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          ServiceCard(
            service: openService,
            tickets: openTickets,
          ),
          ServiceCard(
            service: closeService,
            tickets: closedTickets,
          ),
        ],
      ),
    );
  }
}
