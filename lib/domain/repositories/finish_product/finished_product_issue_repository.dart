import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/finish_product/finished_product_issue_entry.dart';
import '../../entities/finish_product/finished_product_issue.dart';

abstract class FinishedProductIssueRepository {
  Future<ErrorPackage> postNewFinishedProductIssue(
    FinishedProductIssue finishProductIssue);
  Future<List<FinishedProductIssue>> getUncompletedFinishedProductIssue();
  Future<List<FinishedProductIssue>> getCompletedFinishedProductIssue(DateTime startDate, DateTime endDate);
  Future<FinishedProductIssue> getFinishedProductIssueById(String finishedProductIssueId);
  Future<ErrorPackage> updateFinishedProductIssueEntry(
      String finishedProductIssueId, String purchaseOrdernumber, double newQuantity);
      // thêm lô vào phiếu nhập kho
  Future<ErrorPackage> addFinishedProductIssueEntry(
      String finishedProductIssueId,String purchaseOrdernumber, FinishedProductIssueEntry finishedProductIssueEntry);
  Future<ErrorPackage> updateFinishedProductIssueLot(
      String finishedProductIssueId, String purchaseOrdernumber, double newQuantity);
}
