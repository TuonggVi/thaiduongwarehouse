import 'package:mobile_warehouse_thaiduong/domain/repositories/other/export_history_repository.dart';

import '../../entities/other/export_history_entry.dart';

class ExportHistoryUsecase {
  final ExportHistoryRepoitory exportHistoryRepoitory;
  ExportHistoryUsecase(this.exportHistoryRepoitory);

  Future<List<ExportHistoryEntry>> getExportHistoryByPO(String poNumber) {
    final entries = exportHistoryRepoitory.getExportHistoryByPO(poNumber);
    return entries;
  }

  Future<List<ExportHistoryEntry>> getExportHistoryByReceiver(
      String receiver, DateTime startDate, DateTime endDate) {
    final entries = exportHistoryRepoitory.getExportHistoryByReceiver(
        receiver, startDate, endDate);
    return entries;
  }

  Future<List<ExportHistoryEntry>> getExportHistoryByItem(
      String warehouseId, String itemId, DateTime startDate, DateTime endDate) {
    final entries = exportHistoryRepoitory.getExportHistoryByItem(
        warehouseId, itemId, startDate, endDate);
    return entries;
  }
}
