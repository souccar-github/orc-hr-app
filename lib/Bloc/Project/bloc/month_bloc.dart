import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'month_event.dart';
part 'month_state.dart';

class MonthBloc extends Bloc<MonthEvent, MonthState> {
  MonthBloc() : super(MonthInitial());

  @override
  Stream<MonthState> mapEventToState(
    MonthEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
