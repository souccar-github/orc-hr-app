part of 'month_bloc.dart';

abstract class MonthState extends Equatable {
  const MonthState();
}

class MonthInitial extends MonthState {
  @override
  List<Object> get props => [];
}
