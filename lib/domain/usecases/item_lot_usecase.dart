import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/item_lot_repository.dart';

class ItemLotUsecase {
  final ItemLotRepository itemLotRepository;
  ItemLotUsecase(this.itemLotRepository);
  Future<ItemLot> getItemLotById(String lotId) async {
    final itemLot = itemLotRepository.getItemLotById(lotId);
    return itemLot;
  }

  Future<List<ItemLot>> getItemLotsByItemId(String itemId) async{
    final itemLots = itemLotRepository.getItemLotsByItemId(itemId);
    return itemLots;
  }

  Future<List<ItemLot>> getItemLotsByLocation(String locationId)async {
    final itemLots = itemLotRepository.getItemLotsByLocation(locationId);
    return itemLots;
  }
  Future<List<ItemLot>> getIsolatedItemLots() async{
    final itemLots = itemLotRepository.getIsolatedItemLots();
    return itemLots;
  }
  Future<List<ItemLot>> getExpiredItemLots(DateTime dateTime)async {
     final itemLots = itemLotRepository.getExpiredItemLots(dateTime);
    return itemLots;
  }

  Future<List<ItemLot>> getUnderStockminItemLots(String itemClass)async {
     final itemLots = itemLotRepository.getUnderStockminItemLots(itemClass);
    return itemLots;
  }
}