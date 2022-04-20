part of 'loan_bloc.dart';

abstract class LoanEvent {}

class InitMainLoansBalancePage extends LoanEvent {}

class PostLoanRequest extends LoanEvent {
  final LoanRequest loan;
  PostLoanRequest(this.loan);
}

class GetPendingLoanRequests extends LoanEvent {}
class GetLoanEmps extends LoanEvent {}

class AcceptLoanRequest extends LoanEvent {
  final int workflowId;
  final int loanId;
  final String note;

  AcceptLoanRequest(this.workflowId, this.loanId, this.note);
}

class GetMyPendingRequests extends LoanEvent {}

class RejectLoanRequest extends LoanEvent {
  final int workflowId;
  final int loanId;
  final String note;

  RejectLoanRequest(this.workflowId, this.loanId, this.note);
}

class PendingLoanRequest extends LoanEvent {
  final int workflowId;
  final int loanId;
  final String note;

  PendingLoanRequest(this.workflowId, this.loanId, this.note);
}
