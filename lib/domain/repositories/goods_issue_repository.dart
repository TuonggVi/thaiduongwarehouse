import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';

abstract class GoodsIssueRepository {
  Future<ErrorPackage> postNewGoodsIssue(
      String goodsIssueId,
      String purchaseOrderNumber,
      DateTime timestamp,
      String receiver,
      List<GoodsIssueEntry> entries);
  Future<List<GoodsIssue>> getUncompletedGoodsIssue();
  Future<List<GoodsIssue>> getCompletedGoodsIssue();
  Future<GoodsIssue> getGoodsIssueById(String goodsIssueId);
  Future<ErrorPackage> addLotToGoodsIssue(
      String goodsIssueId, List<GoodsIssueLot> lots);
  Future<ErrorPackage> updateGoodsIssueEntry(
      String goodsIssueId, String itemEntryId, double newQuantity);
  Future<ErrorPackage> addGoodsIssueEntry(
      String goodsIssueId, GoodsIssueEntry goodsIssueEntry);
  Future<ErrorPackage> updateGoodsIssueLot(
      String goodsIssueId, String goodsIssueLotId, double newQuantity);
    // truy xuat lich su xuat kho
    Future<List<GoodsIssueLot>> getGoodsIssueHistoryByPO(
      String purchaseOrderNumber);

      Future<List<GoodsIssueLot>> getGoodsIssueHistoryByReceiver(
      DateTime startDate,
      DateTime endDate,);

      Future<List<GoodsIssueLot>> getGoodsIssueHistoryByItemId(
      DateTime startDate,
      DateTime endDate,
      String itemId);
      
  Future<List<GoodsIssueLot>> getGoodsIssueHistory(
      String warehouse,
      DateTime startDate,
      DateTime endDate,
      String itemId,
      String department,
      //String receiver,
      //String purchaseOrderNumber
      );
}
