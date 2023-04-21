import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_receipt.dart';

abstract class GoodsReceiptRepository {
  Future<ErrorPackage> postNewGoodsReceipt(
      String goodsReceiptId, List<GoodsReceiptLot> lots);
  Future<ErrorPackage> updateDetailLotReceipt(
      String goodsReceiptLotId,
      String itemId,
      double quantity,
      double? sublotSize,
      String purchaseOrderNumber,
      String? locationId,
      DateTime? productionDate,
      DateTime? expirationDate);
  Future<List<GoodsReceipt>> getCompletedGoodsReceipts();
  Future<List<GoodsReceipt>> getUnCompletedGoodsReceipts();
  // truy xuat lich su nhap kho
    Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryByPO(
      String purchaseOrderNumber);
      Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryBySupplier(
      DateTime startDate,
      DateTime endDate,);

      Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryByItemId(
      DateTime startDate,
      DateTime endDate,
      String itemId);

  Future<List<GoodsReceiptLot>> getGoodsReceiptsHistory(
      String itemClass,
      DateTime startDate,
      DateTime endDate,
      String itemId,
      String department,
      String receiver,
      String purchaseOrderNumber);
  // test giao diện
    Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryTest(
      String itemClass);
}
