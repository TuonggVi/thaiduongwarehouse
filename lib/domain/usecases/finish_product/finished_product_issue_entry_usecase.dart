import 'package:mobile_warehouse_thaiduong/domain/repositories/other/export_history_repository.dart';

import '../../entities/finish_product/finished_product_issue_entry.dart';
import '../../entities/other/export_history_entry.dart';
import '../../repositories/finish_product/finished_product_issue_entry_repository.dart';

class FinishedProductIssueEntryUsecase {
  final FinishedProductIssueEntryRepository finishedProductIssueEntryRepository;
  FinishedProductIssueEntryUsecase(this.finishedProductIssueEntryRepository);

  Future<List<FinishedProductIssueEntry>> getFinishedProductIssueEntryByPO(String purchaseOrderNumber, String finishedProductIssueId) {
    final entries = finishedProductIssueEntryRepository.getFinishedProductIssueEntryByPO(purchaseOrderNumber, finishedProductIssueId);
    return entries;
  }

  Future<List<FinishedProductIssueEntry>> getFinishedProductIssueEntryByReceiver(
      String receiver, DateTime startDate, DateTime endDate) {
    final entries = finishedProductIssueEntryRepository.getFinishedProductIssueEntryByReceiver(
        receiver, startDate, endDate);
    return entries;
  }

  Future<List<FinishedProductIssueEntry>> getFinishedProductIssueEntryByItem(
      String warehouseId, String itemId, DateTime startDate, DateTime endDate) {
    final entries = finishedProductIssueEntryRepository.getFinishedProductIssueEntryByItem(
        warehouseId, itemId, startDate, endDate);
    return entries;
  }
}
