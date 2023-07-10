import 'package:mobile_warehouse_thaiduong/datasource/service/other/inventory_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/inventory_log_entry.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/inventory_repository.dart';

class InventoryRepoImpl implements InventoryRepository {
  final InventoryService inventoryService;
  InventoryRepoImpl(this.inventoryService);
  @override
  Future<List<InventoryLogEntry>> getInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId) {
    final inventoryLog = inventoryService.getInventoryByItemClass(
        startDate, endDate, itemClassId);
    return inventoryLog;
  }

  @override
  Future<List<InventoryLogEntry>> getInventoryByItemId(
      DateTime startDate, DateTime endDate, String itemId) {
    final inventoryLog =
        inventoryService.getInventoryByItemId(startDate, endDate, itemId);
    return inventoryLog;
  }

  @override
  Future<List<InventoryLogEntry>> getInventoryByTime(
      DateTime startDate, DateTime endDate) {
    final inventoryLog =
        inventoryService.getInventoryByTime(startDate, endDate);
    return inventoryLog;
  }
}
