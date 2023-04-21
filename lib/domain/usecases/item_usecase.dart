import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/item_repository.dart';
//import 'package:mobile_warehouse_thaiduong/domain/repositories/location_repository.dart';

class ItemUsecase {
  final ItemRepository itemRepository;
  ItemUsecase(this.itemRepository);
  Future<List<Item>> getAllItem() async {
    final items = itemRepository.getAllItem();
    return items;
  }
 Future<List<ItemClass>> getAllItemClass() async{
    final itemClass = itemRepository.getAllItemClass();
    return itemClass;
  }
Future<List<Item>> getItemByWarehouseId(
     String itemClassId ) async {
    final items =
        itemRepository.getItemByWarehouseId(itemClassId);
    return items;
  }
}
