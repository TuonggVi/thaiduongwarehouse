import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/goods_issue_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/other/goods_issue_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/goods_issue_repository.dart';

class GoodsIssueRepoImpl implements GoodsIssueRepository {
  final GoodsIssueService goodsIssueService;
  GoodsIssueRepoImpl(this.goodsIssueService);
  @override
  // thêm entry vào phiếu nhập
  Future<ErrorPackageModel> addGoodsIssueEntry(
      String goodsIssueId, GoodsIssueEntry goodsIssueEntry) async {
    final status =
        goodsIssueService.addGoodsIssueEntry(goodsIssueId, goodsIssueEntry);
    return status;
  }
// thêm lô vào entry
  @override
  Future<ErrorPackageModel> addLotToGoodsIssue(
      String goodsIssueId, String itemId, List<GoodsIssueLot> lots) async {
    final status = goodsIssueService.addLotToGoodsIssue(goodsIssueId,itemId, lots);
    return status;
  }
// 
  @override
  Future<List<GoodsIssueModel>> getCompletedGoodsissue(DateTime startDate, DateTime endDate) async {
    final goodsIssues = goodsIssueService.getCompletedGoodsIssue(startDate,endDate);
    return goodsIssues;
  }

  @override
  Future<GoodsIssueModel> getGoodsIssueById(String goodsIssueId)async {
    final goodsIssue = goodsIssueService.getGoodsIssueById(goodsIssueId);
    return goodsIssue;
  }

  @override
  Future<List<GoodsIssue>> getUncompletedGoodsIssue() async{
    final goodsIssues = goodsIssueService.getUncompletedGoodsIssue();
    return goodsIssues;
  }

  @override
  Future<ErrorPackageModel> postNewGoodsIssue(
     GoodsIssue goodsIssue)async {
    final status = goodsIssueService.postNewGoodsIssue(
      goodsIssue);
    return status;
  }
// sửa số lượng yêu cầu xuất
  @override
  Future<ErrorPackage> updateGoodsIssueEntry(
      String goodsIssueId, String itemEntryId, double newQuantity) async{
    final status = goodsIssueService.updateGoodsIssueEntry(
        goodsIssueId, itemEntryId, newQuantity);
    return status;
  }
// sửa thông tin lô
  @override
  Future<ErrorPackage> updateGoodsIssueLot(
      String goodsIssueId, String goodsIssueLotId, double newQuantity)async {
    final status = goodsIssueService.updateGoodsIssueLot(
        goodsIssueId, goodsIssueLotId, newQuantity);
    return status;
  }
  
  @override
  Future<ErrorPackage> patchRequestQuantity(GoodsIssue goodsIssue) {
   final status = goodsIssueService.patchRequestQuantity(
        goodsIssue);
    return status;
  }
  

}
