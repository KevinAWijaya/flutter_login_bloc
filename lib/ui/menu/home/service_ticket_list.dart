import 'package:flutter/material.dart';
import 'package:wisdom_pos_test/data/models/service.dart';
import 'package:wisdom_pos_test/data/models/ticket.dart';
import 'package:wisdom_pos_test/ui/menu/home/service_card.dart';

class ServiceTicketList extends StatelessWidget {
  final List<MapEntry<Service, List<Ticket>>> groupedTickets;

  const ServiceTicketList({super.key, required this.groupedTickets});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      itemCount: groupedTickets.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final entry = groupedTickets[index];
        final service = entry.key;
        final tickets = entry.value;

        return ServiceCard(
          service: service,
          tickets: tickets,
        );
      },
    );
  }
}
