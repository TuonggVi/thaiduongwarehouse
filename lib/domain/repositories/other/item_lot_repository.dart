import 'package:mobile_warehouse_thaiduong/domain/entities/other/item_lot.dart';

import '../../entities/error_package.dart';

abstract class ItemLotRepository {
  Future<ItemLot> getItemLotById(String lotId);
  Future<List<ItemLot>> getItemLotsByItemId(String itemId);
  Future<List<ItemLot>> getItemLotsByLocation(String locationId);
  Future<List<ItemLot>> getIsolatedItemLots();
  Future<List<ItemLot>> getExpiredItemLots(int month);
  Future<List<ItemLot>> getUnderStockminItemLots(String itemClassId);
  Future<ErrorPackage> patchIsolationItemLot(bool isolated, String itemLotId);
  Future<ErrorPackage> postIsolationItemLot(bool isolated, ItemLot itemLot);
  Future<ErrorPackage> patchUnIsolationItemLot(bool isolated, ItemLot itemLot);
}
