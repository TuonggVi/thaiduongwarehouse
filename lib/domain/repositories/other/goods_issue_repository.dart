import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';

abstract class GoodsIssueRepository {
  Future<ErrorPackage> postNewGoodsIssue(
    GoodsIssue goodsIssue);
  Future<List<GoodsIssue>> getUncompletedGoodsIssue();
  Future<List<GoodsIssue>> getCompletedGoodsissue(DateTime startDate, DateTime endDate);
  Future<GoodsIssue> getGoodsIssueById(String goodsIssueId);
  Future<ErrorPackage> addLotToGoodsIssue(
      String goodsIssueId,String itemId,  List<GoodsIssueLot> lots);


  Future<ErrorPackage> updateGoodsIssueEntry(
      String goodsIssueId, String itemEntryId, double newQuantity);
  Future<ErrorPackage> addGoodsIssueEntry(
      String goodsIssueId, GoodsIssueEntry goodsIssueEntry);
  Future<ErrorPackage> updateGoodsIssueLot(
      String goodsIssueId, String goodsIssueLotId, double newQuantity);
        Future<ErrorPackage> patchRequestQuantity(
      GoodsIssue goodsIssue);
}
