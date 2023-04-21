// ignore_for_file: unused_import

import 'package:mobile_warehouse_thaiduong/datasource/service/goods_receipt_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/goods_receipt_repository.dart';

class GoodsReceiptRepoImpl implements GoodsReceiptRepository {
  final GoodsReceiptService goodsReceiptService;
  GoodsReceiptRepoImpl(this.goodsReceiptService);
  @override
  Future<List<GoodsReceipt>> getCompletedGoodsReceipts() {
    final goodsReceipts = goodsReceiptService.getCompletedGoodsReceipts();
    return goodsReceipts;
  }

  @override
  Future<List<GoodsReceipt>> getUnCompletedGoodsReceipts() {
    final goodsReceipts = goodsReceiptService.getUnCompletedGoodsReceipts();
    return goodsReceipts;
  }

  @override
  Future<ErrorPackage> postNewGoodsReceipt(
      String goodsReceiptId, List<GoodsReceiptLot> lots) {
    final status =
        goodsReceiptService.postNewGoodsReceipt(goodsReceiptId, lots);
    return status;
  }

  @override
  Future<ErrorPackage> updateDetailLotReceipt(
      String goodsReceiptLotId,
      String itemId,
      double quantity,
      double? sublotSize,
      String purchaseOrderNumber,
      String? locationId,
      DateTime? productionDate,
      DateTime? expirationDate) {
    final status = goodsReceiptService.updateDetailLotReceipt(
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

  // truy xuat lich su nhap kho
  @override
  Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryByPO(
      String purchaseOrderNumber) {
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryBySupplier(
    DateTime startDate,
    DateTime endDate,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryByItemId(
    DateTime startDate,
    DateTime endDate,
    String itemId,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsReceiptLot>> getGoodsReceiptsHistory(
      String itemClass,
      DateTime startDate,
      DateTime endDate,
      String itemId,
      String department,
      String receiver,
      String purchaseOrderNumber) {
    throw UnimplementedError();
  }

  // thử giao diện
  @override
  Future<List<GoodsReceiptLot>> getGoodsReceiptsHistoryTest(String warehouse) {
    final goodsReceiptLot =
        goodsReceiptService.getGoodsReceiptsHistoryTest(warehouse);
    return goodsReceiptLot;
  }
}
