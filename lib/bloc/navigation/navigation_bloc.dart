import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisdom_pos_test/bloc/navigation/navigation_event.dart';
import 'package:wisdom_pos_test/bloc/navigation/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationSelected(0)) {
    on<SelectTabEvent>((event, emit) {
      emit(NavigationSelected(event.tabIndex));
    });
  }
}
