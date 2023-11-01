import 'package:mobile_warehouse_thaiduong/domain/entities/other/inventory_log_entry.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/inventory_repository.dart';

class Inventoryusecase {
  final InventoryRepository inventoryRepository;
  Inventoryusecase(this.inventoryRepository);
  //truy xuất lịch sử theo thời gian
  Future<List<InventoryLogEntry>> getInventoryByTime(
      DateTime startDate, DateTime endDate) async {
    final logEntries =
        inventoryRepository.getInventoryByTime(startDate, endDate);
    return logEntries;
  }
// truy xuất lịch sử xuất theo bộ phận
  Future<List<InventoryLogEntry>> getInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId) async {
    final logEntries = inventoryRepository.getInventoryByItemClass(
        startDate, endDate, itemClassId);
    return logEntries;
  }
// truy xuất lịch sử theo mã sp
  Future<List<InventoryLogEntry>> getInventoryByItemId(
      DateTime startDate, DateTime endDate, String itemId) async {
    final logEntries =
        inventoryRepository.getInventoryByItemId(startDate, endDate, itemId);
    return logEntries;
  }
}
