import 'package:mobile_warehouse_thaiduong/domain/entities/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/goods_receipt_repository.dart';

import '../entities/error_package.dart';

class GoodsReceiptUsecase {
  final GoodsReceiptRepository goodsReceiptRepository;
  GoodsReceiptUsecase(this.goodsReceiptRepository);
  Future<ErrorPackage> postNewGoodsReceipt(
      String goodsReceiptId, List<GoodsReceiptLot> lots) async {
    final status =
        goodsReceiptRepository.postNewGoodsReceipt(goodsReceiptId, lots);
    return status;
  }

  Future<ErrorPackage> updateDetailLotReceipt(
      String goodsReceiptLotId,
      String itemId,
      double quantity,
      double? sublotSize,
      String purchaseOrderNumber,
      String? locationId,
      DateTime? productionDate,
      DateTime? expirationDate) async {
    final status = goodsReceiptRepository.updateDetailLotReceipt(
        goodsReceiptLotId,
        itemId,
        quantity,
        sublotSize,
        purchaseOrderNumber,
        locationId,
        productionDate,
        expirationDate);
    return status;
  }

  Future<List<GoodsReceipt>> getCompletedGoodsReceipts() async {
    final goodsReceipts = goodsReceiptRepository.getCompletedGoodsReceipts();
    return goodsReceipts;
  }

  Future<List<GoodsReceipt>> getUnCompletedGoodsReceipts() async {
    final goodsReceipts = goodsReceiptRepository.getUnCompletedGoodsReceipts();
    return goodsReceipts;
  }
  // truy xuat lich su nhap kho
  Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryByPO(
      String purchaseOrderNumber) async {
    final goodsReceipts = goodsReceiptRepository.getGoodsReceiptsHistoryByPO(
        purchaseOrderNumber);
    return goodsReceipts;
  }

    Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryBySupplier(
      DateTime startDate,
      DateTime endDate,
    ) async {
    final goodsReceipts = goodsReceiptRepository.getGoodsReceiptsHistoryBySupplier(
        startDate,
        endDate,
    );
    return goodsReceipts;
  }
  
    Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryByItemId(
      DateTime startDate,
      DateTime endDate,
      String itemId,
    ) async {
    final goodsReceipts = goodsReceiptRepository.getGoodsReceiptsHistoryByItemId(
        startDate,
        endDate,
        itemId
    );
    return goodsReceipts;
  }
  Future<List<GoodsReceiptLot>> getGoodsReceiptsHistory(
      String itemClass,
      DateTime startDate,
      DateTime endDate,
      String itemId,
      String department,
      String receiver,
      String purchaseOrderNumber) async {
    final goodsReceipts = goodsReceiptRepository.getGoodsReceiptsHistory(
        itemClass,
        startDate,
        endDate,
        itemId,
        department,
        receiver,
        purchaseOrderNumber);
    return goodsReceipts;
  }
  // test giao diện
    Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryTest(
      String itemClass,
      ) async {
    final goodsReceipts = goodsReceiptRepository.getGoodsReceiptsHistoryTest(
        itemClass,
      );
    return goodsReceipts;
  }
}
