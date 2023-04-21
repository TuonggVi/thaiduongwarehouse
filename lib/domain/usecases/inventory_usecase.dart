import 'package:mobile_warehouse_thaiduong/domain/entities/inventory_log_entry.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/inventory_repository.dart';

class InventoryUsecase {
  final InventoryRepository inventoryRepository;
  InventoryUsecase(this.inventoryRepository);
  Future<List<InventoryLogEntry>> getInventoryByTime(
      String startDate, String endDate) async {
    final logEntries =
        inventoryRepository.getInventoryByTime(startDate, endDate);
    return logEntries;
  }

  Future<List<InventoryLogEntry>> getInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId) async {
    final logEntries = inventoryRepository.getInventoryByItemClass(
        startDate, endDate, itemClassId);
    return logEntries;
  }

  Future<List<InventoryLogEntry>> getInventoryByItemId(
      DateTime startDate, DateTime endDate, String itemId) async {
    final logEntries =
        inventoryRepository.getInventoryByItemId(startDate, endDate, itemId);
    return logEntries;
  }

  // thử giao diện
  Future<List<InventoryLogEntry>> getInventoryLotByItemClassId(
    DateTime dateTime, 
      String itemClassId
      ) async {
    final logEntries =
        inventoryRepository.getInventoryLotByItemClassId(
          dateTime, 
          itemClassId);
    return logEntries;
  }
}
