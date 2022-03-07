part of 'advance_bloc.dart';

abstract class AdvanceEvent {}

class InitMainAdvancesBalancePage extends AdvanceEvent {}

class PostAdvanceRequest extends AdvanceEvent {
  final AdvanceRequest advance;
  PostAdvanceRequest(this.advance);
}

class GetPendingAdvanceRequests extends AdvanceEvent {}
class GetDesAmount extends AdvanceEvent {}

class AcceptAdvanceRequest extends AdvanceEvent {
  final int workflowId;
  final int advanceId;
  final String note;

  AcceptAdvanceRequest(this.workflowId, this.advanceId, this.note);
}

class GetMyPendingRequests extends AdvanceEvent {}

class RejectAdvanceRequest extends AdvanceEvent {
  final int workflowId;
  final int advanceId;
  final String note;

  RejectAdvanceRequest(this.workflowId, this.advanceId, this.note);
}

class PendingAdvanceRequest extends AdvanceEvent {
  final int workflowId;
  final int advanceId;
  final String note;

  PendingAdvanceRequest(this.workflowId, this.advanceId, this.note);
}
