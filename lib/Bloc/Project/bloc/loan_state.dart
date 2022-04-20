part of 'loan_bloc.dart';

abstract class LoanState {}

class LoanInitial extends LoanState {}

class LoanError extends LoanState {
  final String error;
  LoanError(this.error);
}

class LoanLoading extends LoanState {}
class GetLoanEmpsSuccessfully extends LoanState {
  final List<ListItem> items;

  GetLoanEmpsSuccessfully(this.items);
}

class GetMyPendingRequestsSuccessfully extends LoanState {
  final List<WorkflowInfo> list;

  GetMyPendingRequestsSuccessfully(this.list);
}

class DaysLoading extends LoanState {}

class PostLoanRequestSuccessfully extends LoanState {}

class AcceptLoanRequestSuccessfully extends LoanState {}

class PendingLoanRequestSuccessfully extends LoanState {}

class RejectLoanRequestSuccessfully extends LoanState {}

class GetPendingLoanRequestsSuccessfully extends LoanState {
  final List<LoanRequest> items;

  GetPendingLoanRequestsSuccessfully(this.items);
}
