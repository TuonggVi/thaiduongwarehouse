import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';

abstract class ItemLotRepository {
  Future<ItemLot> getItemLotById(String lotId);
  Future<List<ItemLot>> getItemLotsByItemId(String itemId);
  Future<List<ItemLot>> getItemLotsByLocation(String locationId);
  Future<List<ItemLot>> getIsolatedItemLots();
  Future<List<ItemLot>> getExpiredItemLots(DateTime dateTime);
  Future<List<ItemLot>> getUnderStockminItemLots(itemClass);
}
