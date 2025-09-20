import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisdom_pos_test/bloc/navigation/navigation_bloc.dart';
import 'package:wisdom_pos_test/bloc/navigation/navigation_state.dart';
import 'package:wisdom_pos_test/bloc/service/sales_bloc.dart';
import 'package:wisdom_pos_test/data/repositories/service_repository.dart';
import 'package:wisdom_pos_test/data/repositories/ticket_repository.dart';
import 'package:wisdom_pos_test/ui/menu/home_page.dart';
import 'package:wisdom_pos_test/ui/menu/menu_page.dart';
import 'package:wisdom_pos_test/ui/menu/new_order_page.dart';
import 'package:wisdom_pos_test/ui/menu/report_page.dart';
import 'package:wisdom_pos_test/ui/navigation/bottom_navigation.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceRepo = RepositoryProvider.of<ServiceRepository>(context);
    final ticketRepo = RepositoryProvider.of<TicketRepository>(context);

    return BlocProvider(
      create: (context) => SalesBloc(serviceRepository: serviceRepo, ticketRepository: ticketRepo),
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            int selectedIndex = 0;
            if (state is NavigationSelected) {
              selectedIndex = state.selectedIndex;
            }

            switch (selectedIndex) {
              case 1:
                return const NewOrderScreen();
              case 2:
                return const ReportScreen();
              case 3:
                return const MenuScreen();
              default:
                return const HomePage();
            }
          },
        ),
        bottomNavigationBar: const CustomBottomNavigationBarPage(),
      ),
    );
  }
}
