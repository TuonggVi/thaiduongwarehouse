import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';

abstract class GoodsReceiptRepository {
  Future<ErrorPackage> postNewGoodsReceipt(
       GoodsReceipt goodsReceipt);
  Future<ErrorPackage> updateDetailLotReceipt(
  GoodsReceipt goodsReceipt  );
  Future<List<GoodsReceipt>> getCompletedGoodsReceipts(DateTime startDate, DateTime endDate);
  Future<List<GoodsReceipt>> getUnCompletedGoodsReceipts();
  Future<ErrorPackage> patchNewGoodsReceipt(
       GoodsReceipt goodsReceipt);
}
