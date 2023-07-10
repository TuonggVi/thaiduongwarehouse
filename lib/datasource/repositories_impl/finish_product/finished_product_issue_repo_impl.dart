// ignore_for_file: override_on_non_overriding_member

import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';


import '../../../domain/entities/finish_product/finished_product_issue.dart';
import '../../../domain/entities/finish_product/finished_product_issue_entry.dart';
import '../../../domain/repositories/finish_product/finished_product_issue_repository.dart';
import '../../models/finish_product/finished_product_issue_model.dart';
import '../../service/finish_product/finished_product_issue_service.dart';


class FinishedProductIssueRepoImpl implements FinishedProductIssueRepository {
  final FinishedProductIssueService finishedProductIssueService;
  FinishedProductIssueRepoImpl(this.finishedProductIssueService);
  @override
  // thêm phiếu nhập kho theo id
  // Future <đầu ra> phương thức (tham số đầu vào) async {}
  Future<ErrorPackageModel> addFinishedProductIssueEntry(
      String finishedProductIssueId,String purchaseOrdernumber, FinishedProductIssueEntry finishedProductIssueEntry) async {
    final status =
        finishedProductIssueService.addFinishedProductIssueEntry(finishedProductIssueId,finishedProductIssueEntry);
    return status;
  }
  // lô nhập kho đã hoàn thành (tìm kiếm theo thời gian)
  @override
  Future<List<FinishedProductIssueModel>> getCompletedFinishedProductIssue(DateTime startDate, DateTime endDate) async {
    final finishedProductIssues = finishedProductIssueService.getCompletedFinishedProductIssue(startDate,endDate);
    return finishedProductIssues;
  }
// Load lô nhập kho theo id
  @override
  Future<FinishedProductIssueModel> getFinishedProductIssueById(String finishedProductIssueId)async {
    final finishedProductIssue = finishedProductIssueService.getFinishedProductIssueById(finishedProductIssueId);
    return finishedProductIssue;
  }
// lô nhập kho chưa hoàn thành
  @override
  Future<List<FinishedProductIssue>> getUncompletedFinishedProductIssue() async{
    final finishedProductIssues = finishedProductIssueService.getUncompletedFinishedProductIssue();
    return finishedProductIssues;
  }
// post lô mới
  @override
  Future<ErrorPackageModel> postNewFinishedProductIssue(
     FinishedProductIssue finishedProductIssue)async {
    final status = finishedProductIssueService.postNewFinishedProductIssue(
      finishedProductIssue);
    return status;
  }
// cập nhật phiếu nhập kho
  @override
  Future<ErrorPackage> updateFinishedProductIssueEntry(
      String finishedProductIssueId, String purchaseOrdernumber, double newQuantity) async{
    final status = finishedProductIssueService.updateFinishedProductIssueEntry(
        finishedProductIssueId, purchaseOrdernumber, newQuantity);
    return status;
  }
// cập nhật lô trong phiếu nhập kho
  @override
  Future<ErrorPackage> updateFinishedProductIssueLot(
      String finishedProductIssueId, String finishedProductIssueLotId, double newQuantity)async {
    final status = finishedProductIssueService.updateFinishedProductIssueLot(
        finishedProductIssueId, newQuantity);
    return status;
  }

}
