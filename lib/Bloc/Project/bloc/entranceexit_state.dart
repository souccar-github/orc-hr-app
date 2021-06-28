part of 'entranceexit_bloc.dart';

abstract class EntranceexitState {
}

class EntranceexitInitial extends EntranceexitState {}

class EntranceExitError extends EntranceexitState{
  final String error;

  EntranceExitError(this.error);
}

class GetMyPendingRequestsSuccessfully extends EntranceexitState{
  final List<WorkflowInfo> list;

  GetMyPendingRequestsSuccessfully(this.list);
}

class EntranceExitLoading extends EntranceexitState{}

class PostEntranceExitRequestSuccessfully extends EntranceexitState{}

class AcceptEntranceexitRequestSuccessfully extends EntranceexitState {}

class PendingEntranceexitRequestSuccessfully extends EntranceexitState {}

class RejectEntranceexitRequestSuccessfully extends EntranceexitState {}

class GetPendingEntranceexitRequestsSuccessfully extends EntranceexitState {
  final List<EntranceExitRequest> items;

  GetPendingEntranceexitRequestsSuccessfully(this.items);
}
