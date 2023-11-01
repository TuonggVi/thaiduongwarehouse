import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/goods_receipt_repository.dart';

import '../../entities/error_package.dart';

class GoodsReceiptUsecase {
  final GoodsReceiptRepository goodsReceiptRepository;
  GoodsReceiptUsecase(this.goodsReceiptRepository);
  Future<ErrorPackage> postNewGoodsReceipt(
      GoodsReceipt goodsReceipt) async {
    final status =
        goodsReceiptRepository.postNewGoodsReceipt( goodsReceipt);
    return status;
  }
  Future<ErrorPackage> patchNewGoodsReceipt(
      GoodsReceipt goodsReceipt) async {
    final status =
        goodsReceiptRepository.patchNewGoodsReceipt( goodsReceipt);
    return status;
  }
  Future<ErrorPackage> updateDetailLotReceipt(
    GoodsReceipt goodsReceipt) async {
    final status = goodsReceiptRepository.updateDetailLotReceipt(
       goodsReceipt);
    return status;
  }

  Future<List<GoodsReceipt>> getCompletedGoodsReceipts(DateTime startDate, DateTime endDate) async {
    final goodsReceipts = goodsReceiptRepository.getCompletedGoodsReceipts(startDate,endDate);
    return goodsReceipts;
  }

  Future<List<GoodsReceipt>> getUnCompletedGoodsReceipts() async {
    final goodsReceipts = await goodsReceiptRepository.getUnCompletedGoodsReceipts();
    return goodsReceipts;
  }
 Future<ErrorPackage> removeGoodsReceiptLot(
      GoodsReceipt goodsReceipt, GoodsReceiptLot goodsReceiptLot) async {
    final status =
        goodsReceiptRepository.removeGoodsReceiptLot( goodsReceipt, goodsReceiptLot);
    return status;
  }

}
