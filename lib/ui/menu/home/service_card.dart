import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wisdom_pos_test/core/color.dart';
import 'package:wisdom_pos_test/data/models/service.dart';
import 'package:wisdom_pos_test/data/models/ticket.dart';

class ServiceCard extends StatefulWidget {
  final Service service;
  final List<Ticket> tickets;

  const ServiceCard({super.key, required this.service, required this.tickets});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final tickets = widget.tickets;
    final visibleTickets = _expanded ? tickets : tickets.take(2).toList();
    final remainingCount = tickets.length - 2;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    widget.service.name ?? "No Service",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: VColor.primary,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Icon(
                    _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: VColor.primary,
                    size: 18,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sales: ${tickets.length} · \$${tickets.fold<double>(0, (sum, t) => sum + (t.grandTotal ?? 0))}",
                    style: const TextStyle(
                      color: VColor.primary,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    "+ New Sales",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Tickets
          Container(
            decoration: BoxDecoration(color: VColor.backgroundCard, borderRadius: BorderRadius.circular(10)),
            child: tickets.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    decoration: BoxDecoration(
                      color: VColor.backgroundCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "No Record Found",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: VColor.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => _ticketItem(visibleTickets[index]),
                          separatorBuilder: (context, index) => Divider(color: Colors.grey.shade400, thickness: 1),
                          itemCount: visibleTickets.length),

                      // See more / Hide button
                      if (tickets.length > 2)
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _expanded = !_expanded;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: VColor.backgroundCard,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                      color: VColor.primary,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      _expanded ? "Minimize" : "See $remainingCount others",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: VColor.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget _ticketItem(Ticket ticket) {
    final totalDebt = (ticket.grandTotal ?? 0) - (ticket.payment ?? 0);
    final createdTime = ticket.created != null ? DateFormat("HH:mm").format(DateTime.parse(ticket.created!)) : "--:--";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: VColor.backgroundCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Time
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: VColor.primary,
              shape: BoxShape.circle,
            ),
            child: ticket.paid != null
                ? const Icon(
                    Icons.check,
                    color: VColor.white,
                  )
                : Text(
                    createdTime,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
          const SizedBox(width: 12),

          // Ticket Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "#${ticket.barcode}",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: VColor.primary,
                  ),
                ),
                Text(
                  "${ticket.customerName ?? 'Unknown'}"
                  "${ticket.tableDineInName != null ? ' · ${ticket.tableDineInName}' : ''}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: VColor.primary,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${(ticket.grandTotal ?? 0).toStringAsFixed(2)}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: VColor.primary,
                ),
              ),
              if (ticket.payment != ticket.grandTotal)
                Text(
                  "(\$${(totalDebt).toStringAsFixed(2)})",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: VColor.primary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
