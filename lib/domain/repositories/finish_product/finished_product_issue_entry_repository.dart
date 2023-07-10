
import '../../entities/finish_product/finished_product_issue_entry.dart';

abstract class FinishedProductIssueEntryRepository {
  Future<List<FinishedProductIssueEntry>> getFinishedProductIssueEntryByPO(String purchaseOrderNumber, String finishedProductIssueId);
  Future<List<FinishedProductIssueEntry>> getFinishedProductIssueEntryByReceiver(
      String receiver, DateTime startDate, DateTime endDate);
  Future<List<FinishedProductIssueEntry>> getFinishedProductIssueEntryByItem(
      String warehouseId, String itemId, DateTime startDate, DateTime endDate);
}
