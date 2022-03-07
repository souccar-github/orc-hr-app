part of 'advance_bloc.dart';

abstract class AdvanceState {}

class AdvanceInitial extends AdvanceState {}

class AdvanceError extends AdvanceState {
  final String error;
  AdvanceError(this.error);
}

class AdvanceLoading extends AdvanceState {}
class GetDesAmountSuccessfully extends AdvanceState {
  final double desAmount;

  GetDesAmountSuccessfully(this.desAmount);
}

class GetSpentDaysSuccessfully extends AdvanceState {
  final String days;
  GetSpentDaysSuccessfully(this.days);
}

class GetMyPendingRequestsSuccessfully extends AdvanceState {
  final List<WorkflowInfo> list;

  GetMyPendingRequestsSuccessfully(this.list);
}

class DaysLoading extends AdvanceState {}

class PostAdvanceRequestSuccessfully extends AdvanceState {}

class AcceptAdvanceRequestSuccessfully extends AdvanceState {}

class PendingAdvanceRequestSuccessfully extends AdvanceState {}

class RejectAdvanceRequestSuccessfully extends AdvanceState {}

class GetPendingAdvanceRequestsSuccessfully extends AdvanceState {
  final List<AdvanceRequest> items;

  GetPendingAdvanceRequestsSuccessfully(this.items);
}
