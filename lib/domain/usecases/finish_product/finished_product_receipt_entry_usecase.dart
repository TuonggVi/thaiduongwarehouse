
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/import_history_repository.dart';

import '../../entities/other/import_history_entry.dart';

class ImportHistoryUsecase {
  final ImportHistoryRepoitory importHistoryRepoitory;
  ImportHistoryUsecase(this.importHistoryRepoitory);
  Future<List<ImportHistoryEntry>> getImportHistoryByPO(String poNumber) {
    final entries = importHistoryRepoitory.getImportHistoryByPO(poNumber);
    return entries;
  }

  Future<List<ImportHistoryEntry>> getImportHistoryBySupplier(
      String supplier, DateTime startDate, DateTime endDate) {
    final entries = importHistoryRepoitory.getImportHistoryBySupplier(
        supplier, startDate, endDate);
    return entries;
  }

  Future<List<ImportHistoryEntry>> getImportHistoryByItem(
      String warehouseId, String itemId, DateTime startDate, DateTime endDate) {
    final entries = importHistoryRepoitory.getImportHistoryByItem(
        warehouseId, itemId, startDate, endDate);
    return entries;
  }
}
