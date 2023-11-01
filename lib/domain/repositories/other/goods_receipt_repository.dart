import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';

abstract class GoodsReceiptRepository {
  // tạo mới phiếu nhập kho
  Future<ErrorPackage> postNewGoodsReceipt(GoodsReceipt goodsReceipt);
  // cập nhật thông tin phiếu nhập
  Future<ErrorPackage> updateDetailLotReceipt(GoodsReceipt goodsReceipt);
  // lấy phiếu đã hoàn thành
  Future<List<GoodsReceipt>> getCompletedGoodsReceipts(
      DateTime startDate, DateTime endDate);
  // lấy phiếu chưa hoàn thành
  Future<List<GoodsReceipt>> getUnCompletedGoodsReceipts();
  // thêm lô vào phiếu nhập (entry)
  Future<ErrorPackage> patchNewGoodsReceipt(GoodsReceipt goodsReceipt);
  // xóa phiếu nhập sai
  Future<ErrorPackage> removeGoodsReceiptLot(GoodsReceipt goodsReceipt, GoodsReceiptLot goodsReceiptLot);
  Future<ErrorPackage> patchRequestQuantity(GoodsReceipt goodsReceipt);
  
}
