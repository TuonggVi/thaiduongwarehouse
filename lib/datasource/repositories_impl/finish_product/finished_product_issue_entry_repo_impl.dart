
import '../../../domain/entities/finish_product/finished_product_issue_entry.dart';
import '../../../domain/repositories/finish_product/finished_product_issue_entry_repository.dart';
import '../../service/finish_product/finished_product_issue_entry_service.dart';

class FinishedProductIssueEntryRepoImpl implements FinishedProductIssueEntryRepository {
  final FinishedProductIssueEntryService finishedProductIssueService;
  FinishedProductIssueEntryRepoImpl(this.finishedProductIssueService);
  @override
  Future<List<FinishedProductIssueEntry>> getFinishedProductIssueEntryByItem(
      String warehouseId, String itemId, DateTime startDate, DateTime endDate) {
    final entries = finishedProductIssueService.getFinishedProductIssueEntryByItem(
        startDate, endDate, itemId, warehouseId);
    return entries;
  }

  @override
  Future<List<FinishedProductIssueEntry>> getFinishedProductIssueEntryByPO(String purchaseOrderNumber, String finishedProductIssueId) {
    final entries = finishedProductIssueService.getFinishedProductIssueEntryByPo(purchaseOrderNumber, finishedProductIssueId);
    return entries;
  }

  @override
  Future<List<FinishedProductIssueEntry>> getFinishedProductIssueEntryByReceiver(
      String receiver, DateTime startDate, DateTime endDate) {
    final entries = finishedProductIssueService.getFinishedProductIssueEntryByReceiver(
        startDate, endDate, receiver);
    return entries;
  }
}
