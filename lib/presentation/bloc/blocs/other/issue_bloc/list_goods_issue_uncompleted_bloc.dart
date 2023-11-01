import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/issue_event/list_goods_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/issue_state/list_goods_issue_state.dart';

import '../../../../../domain/entities/error_package.dart';

class ListGoodsIssueUncompletedBloc
    extends Bloc<GoodsIssueEvent, GoodsIssueState> {
  GoodsIssueUseCase goodsIssueUseCase;
  ListGoodsIssueUncompletedBloc(this.goodsIssueUseCase)
      : super(LoadGoodsIssuesLoadingState(DateTime.now())) {
    on<LoadGoodsIssuesEvent>((event, emit) async {
      emit(LoadGoodsIssuesLoadingState(DateTime.now()));
      try {
        
        final issues = await goodsIssueUseCase.getUncompletedGoodsIssue();
        for (var element in issues) {
          for (var e in element.entries!) {
            e.lots!.isNotEmpty
                ? {
                    for (var a in e.lots!)
                      {
                        // số lượng đã xuất = tổng số lượng trong từng lô thêm vào entry
                        e.actualQuantity = e.actualQuantity! +
                            double.parse(a.quantity.toString())
                      }
                  }
                : {};
          }
        }
        issues.isEmpty
            ? emit(LoadGoodsIssuesFailState(
                DateTime.now(), 'Không có danh sách hiển thị'))
            : emit(LoadGoodsIssuesSuccessState(DateTime.now(), issues , issues.first, event.goodsIssueLot));
      } catch (e) {
        emit(LoadGoodsIssuesFailState(DateTime.now(), 'Lỗi hệ thống'));
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });

    on<PatchRequestQuantityEvent>((event, emit) async {
      emit(PatchRequestQuantityLoadingState(DateTime.now()));
      try {
        final status =
            await goodsIssueUseCase.patchRequestQuantity(event.goodsIssue);

        status.detail == 'success'
            ? emit(PatchRequestQuantitySuccessState(DateTime.now(), status,
                event.goodsIssue))
            : emit(PatchRequestQuantityFailState(
                DateTime.now(), ErrorPackage('Thất bại')));
      } catch (e) {
        emit(PatchRequestQuantityFailState(
            DateTime.now(), ErrorPackage('Thất bại')));
      }
    });
  }
}
