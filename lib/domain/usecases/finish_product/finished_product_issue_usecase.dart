
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import '../../entities/finish_product/finished_product_issue.dart';
import '../../repositories/finish_product/finished_product_issue_repository.dart';

class FinishedProductIssueUseCase {
  final FinishedProductIssueRepository finishedProductIssueRepository;
  FinishedProductIssueUseCase( this.finishedProductIssueRepository);
 

  Future<ErrorPackage> postNewFinishedProductIssue(
    FinishedProductIssue finishedProductIssue) async {
    final status = finishedProductIssueRepository.postNewFinishedProductIssue(
       finishedProductIssue);
    return status;
  }

  Future<List<FinishedProductIssue>> getUncompletedFinishedProductIssue() async {
    final finishedProductIssues = finishedProductIssueRepository.getUncompletedFinishedProductIssue();
    return finishedProductIssues;
  }

  Future<List<FinishedProductIssue>> getCompletedFinishedProductIssue(DateTime startDate, DateTime endDate) async {
    final finishedProductIssues = finishedProductIssueRepository.getCompletedFinishedProductIssue(startDate, endDate);
    return finishedProductIssues;
  }

  Future<FinishedProductIssue> getFinishedProductIssueById(String finishedProductIssueId, String purchaseOrdernumber) async {
    final finishedProductIssue = finishedProductIssueRepository.getFinishedProductIssueById(finishedProductIssueId);
    return finishedProductIssue;
  }

  Future<ErrorPackage> updateFinishedProductIssueEntry(
      String finishedProductIssueId, String purchaseOrdernumber, double newQuantity) async {
    final status = finishedProductIssueRepository.updateFinishedProductIssueEntry(
        finishedProductIssueId, purchaseOrdernumber, newQuantity);
    return status;
  }

  Future<ErrorPackage> addFinishedProductIssueEntry(
      String finishedProductIssueId, purchaseOrdernumber, newQuantity) async {
    final status =
        finishedProductIssueRepository.addFinishedProductIssueEntry(finishedProductIssueId, purchaseOrdernumber, newQuantity);
    return status;
  }

 

}
