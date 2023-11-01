import 'package:mobile_warehouse_thaiduong/datasource/service/other/goods_receipt_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/goods_receipt_repository.dart';

class GoodsReceiptRepoImpl implements GoodsReceiptRepository {
  final GoodsReceiptService goodsReceiptService;
  GoodsReceiptRepoImpl(this.goodsReceiptService);
  @override
  Future<List<GoodsReceipt>> getCompletedGoodsReceipts(
      DateTime startDate, DateTime endDate) {
    final goodsReceipts =
        goodsReceiptService.getCompletedGoodsReceipts(startDate, endDate);
    return goodsReceipts;
  }

  @override
  Future<List<GoodsReceipt>> getUnCompletedGoodsReceipts() {
    final goodsReceipts = goodsReceiptService.getUnCompletedGoodsReceipts();
    return goodsReceipts;
  }

  @override
  Future<ErrorPackage> postNewGoodsReceipt(GoodsReceipt goodsReceipt) {
    final status = goodsReceiptService.postNewGoodsReceipt(goodsReceipt);
    return status;
  }

  @override
  Future<ErrorPackage> updateDetailLotReceipt(GoodsReceipt goodsReceipt) {
    final status = goodsReceiptService.updateDetailLotReceipt(goodsReceipt);
    return status;
  }
  
  @override
  Future<ErrorPackage> patchNewGoodsReceipt(GoodsReceipt goodsReceipt) {
     final status = goodsReceiptService.patchNewGoodsReceipt(goodsReceipt);
    return status;
  }
  
  @override
  Future<ErrorPackage> removeGoodsReceiptLot(GoodsReceipt goodsReceipt, GoodsReceiptLot goodsReceiptLot) {

    final status = goodsReceiptService.removeGoodsReceiptLot(goodsReceipt, goodsReceiptLot);
    return status;
  }
  
  @override
  Future<ErrorPackage> patchRequestQuantity(GoodsReceipt goodsReceipt) {
     final status = goodsReceiptService.updateDetailLotReceipt(goodsReceipt);
    return status;
  }
}
