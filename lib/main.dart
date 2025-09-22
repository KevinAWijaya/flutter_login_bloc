import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdom_pos_test/bloc/auth/login_bloc.dart';
import 'package:wisdom_pos_test/bloc/navigation/navigation_bloc.dart';
import 'package:wisdom_pos_test/core/color.dart';
import 'package:wisdom_pos_test/data/repositories/auth_repository.dart';
import 'package:wisdom_pos_test/data/repositories/service_repository.dart';
import 'package:wisdom_pos_test/data/repositories/session_repository.dart';
import 'package:wisdom_pos_test/data/repositories/ticket_repository.dart';
import 'package:wisdom_pos_test/data/services/api_client.dart';
import 'package:wisdom_pos_test/ui/auth/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final apiClient = ApiClient();
  final authRepository = AuthRepository(apiClient: apiClient);
  final serviceRepository = ServiceRepository(apiClient: apiClient);
  final ticketRepository = TicketRepository(apiClient: apiClient);
  final sessionRepository = SessionRepository();

  runApp(MyApp(
    authRepository: authRepository,
    serviceRepository: serviceRepository,
    ticketRepository: ticketRepository,
    sessionRepository: sessionRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final ServiceRepository serviceRepository;
  final TicketRepository ticketRepository;
  final SessionRepository sessionRepository;

  const MyApp({super.key, required this.authRepository, required this.serviceRepository, required this.ticketRepository, required this.sessionRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<ServiceRepository>.value(value: serviceRepository),
        RepositoryProvider<TicketRepository>.value(value: ticketRepository),
        RepositoryProvider<SessionRepository>.value(value: sessionRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(authRepository, sessionRepository),
          ),
          BlocProvider(
            create: (context) => NavigationBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wisdom POS',
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: VColor.surface,
            textTheme: GoogleFonts.montserratTextTheme(),
          ),
          home: const LoginPage(),
        ),
      ),
    );
  }
}
