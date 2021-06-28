part of 'entranceexit_bloc.dart';

abstract class EntranceexitEvent {
}

class PostEntranceExitRequest extends EntranceexitEvent{
  final EntranceExitRequest model;

  PostEntranceExitRequest(this.model);
}

class GetPendingEntranceexitRequests extends EntranceexitEvent{
}

class GetMyPendingRequests extends EntranceexitEvent{
}

class AcceptEntranceexitRequest extends EntranceexitEvent{
  final int workflowId;
  final int recordId;
  final String note;

  AcceptEntranceexitRequest(this.workflowId, this.recordId, this.note);
}

class RejectEntranceexitRequest extends EntranceexitEvent{
  final int workflowId;
  final int recordId;
  final String note;

  RejectEntranceexitRequest(this.workflowId, this.recordId, this.note);
}

class PendingEntranceexitRequest extends EntranceexitEvent{
  final int workflowId;
  final int recordId;
  final String note;

  PendingEntranceexitRequest(this.workflowId, this.recordId, this.note);
}
