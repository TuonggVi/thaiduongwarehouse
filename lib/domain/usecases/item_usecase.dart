import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/item_repository.dart';

class ItemUsecase {
  final ItemRepository itemRepository;
  ItemUsecase(this.itemRepository);
  Future<List<Item>> getAllItem() async {
    final items = itemRepository.getAllItems();
    return items;
  }
   Future<ErrorPackage> postNewItems
    (Item item) async {
    final status = itemRepository.postNewItems(
       item);
    return status;
  }

  // Future<Item> getItemByItemId(String itemId) async {
  //   final item = itemRepository.getItemByItemId(itemId);
  //   return item;
  // }
}
