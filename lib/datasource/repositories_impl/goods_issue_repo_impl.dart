import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/goods_issue_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/goods_issue_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/goods_issue_repository.dart';

class GoodsIssueRepoImpl implements GoodsIssueRepository {
  final GoodsIssueService goodsIssueService;
  GoodsIssueRepoImpl(this.goodsIssueService);
  @override
  Future<ErrorPackageModel> addGoodsIssueEntry(
      String goodsIssueId, GoodsIssueEntry goodsIssueEntry) async {
    final status =
        goodsIssueService.addGoodsIssueEntry(goodsIssueId, goodsIssueEntry);
    return status;
  }

  @override
  Future<ErrorPackageModel> addLotToGoodsIssue(
      String goodsIssueId, List<GoodsIssueLot> lots) async {
    final status = goodsIssueService.addLotToGoodsIssue(goodsIssueId, lots);
    return status;
  }

  @override
  Future<List<GoodsIssueModel>> getCompletedGoodsIssue() async {
    final goodsIssues = goodsIssueService.getCompletedGoodsissue();
    return goodsIssues;
  }

  @override
  Future<GoodsIssueModel> getGoodsIssueById(String goodsIssueId) async {
    final goodsIssue = goodsIssueService.getGoodsIssueById(goodsIssueId);
    return goodsIssue;
  }

  @override
  Future<List<GoodsIssue>> getUncompletedGoodsIssue() async {
    final goodsIssues = goodsIssueService.getUncompletedGoodsIssue();
    return goodsIssues;
  }

  @override
  Future<ErrorPackageModel> postNewGoodsIssue(
      String goodsIssueId,
      String purchaseOrderNumber,
      DateTime timestamp,
      String receiver,
      List<GoodsIssueEntry> entries) async {
    final status = goodsIssueService.postNewGoodsIssue(
        goodsIssueId, purchaseOrderNumber, timestamp, receiver, entries);
    return status;
  }

  @override
  Future<ErrorPackage> updateGoodsIssueEntry(
      String goodsIssueId, String itemEntryId, double newQuantity) async {
    final status = goodsIssueService.updateGoodsIssueEntry(
        goodsIssueId, itemEntryId, newQuantity);
    return status;
  }

  @override
  Future<ErrorPackage> updateGoodsIssueLot(
      String goodsIssueId, String goodsIssueLotId, double newQuantity) async {
    final status = goodsIssueService.updateGoodsIssueLot(
        goodsIssueId, goodsIssueLotId, newQuantity);
    return status;
  }

  // truy xuat lich su xuat kho
  @override
  Future<List<GoodsIssueLot>> getGoodsIssueHistoryByPO(
      String purchaseOrderNumber) {
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsIssueLot>> getGoodsIssueHistoryByReceiver(
    DateTime startDate,
    DateTime endDate,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsIssueLot>> getGoodsIssueHistoryByItemId(
    DateTime startDate,
    DateTime endDate,
    String itemId,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<List<GoodsIssueLot>> getGoodsIssueHistory(
    String itemClass,
    DateTime startDate,
    DateTime endDate,
    String itemId,
    String department,
    //String receiver,
    //String purchaseOrderNumber
  ) {
    throw UnimplementedError();
  }

}
