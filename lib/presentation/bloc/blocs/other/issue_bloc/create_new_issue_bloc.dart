import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/info_issuecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/issue_event/create_new_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/issue_state/create_new_issue_state.dart';

class CreateIssueBloc extends Bloc<CreateNewIssueEvent, CreaNewIssueState> {
  GoodsIssueUseCase goodsIssueUseCase;
  InfoUsecase infoUsecase;

  CreateIssueBloc(this.goodsIssueUseCase, this.infoUsecase)
      : super(CreateNewIssueInitialState(null)) {
    // thêm entry vào phiếu nhập
    on<AddIssueEntryEvent>((event, emit) async {
      emit(UpdateEntryToGoodsIssueLoading(DateTime.now()));
      try {
        event.goodsIssue.entries!.add(event.issueEntry);
        emit(UpdateEntryToGoodsIssueSuccess(
          DateTime.now(),
          event.goodsIssue,
        ));
      } catch (e) {
        // emit(LoginStateLoginFailure(DateTime.now()));
      }
    });
    // cập nhật thông tin entry
    on<UpdateIssueEntryEvent>((event, emit) async {
      emit(UpdateEntryToGoodsIssueLoading(DateTime.now()));
      try {
        event.goodsIssue.entries!.removeAt(event.index);
        event.goodsIssue.entries!.insert(event.index, event.issueEntry);
        emit(UpdateEntryToGoodsIssueSuccess(
          DateTime.now(),
          event.goodsIssue,
        ));
      } catch (e) {
        // emit(LoginStateLoginFailure(DateTime.now()));
      }
    });

    on<LoadIssueEntryEvent>((event, emit) async {
      emit(UpdateEntryToGoodsIssueLoading(DateTime.now()));
      try {
        emit(UpdateEntryToGoodsIssueSuccess(
          DateTime.now(),
          event.goodsIssue,
        ));
      } catch (e) {
        // emit(LoginStateLoginFailure(DateTime.now()));
      }
    });
  
    on<PostNewGoodsIssueEvent>((event, emit) async {
      emit(PostNewGoodsIssueLoadingState(DateTime.now()));
      try {
        final status =
            await goodsIssueUseCase.postNewGoodsIssue(event.goodsIssue);
        if (status.detail == 'success') {
          emit(PostNewGoodsIssueSuccessState(
              DateTime.now(), 'success', event.goodsIssue));
        } else {
          emit(PostNewGoodsIssueFailState(
              DateTime.now(), 'fail', event.goodsIssue));
        }
      } catch (e) {
        emit(PostNewGoodsIssueFailState(
            DateTime.now(), 'fail', event.goodsIssue));
      }
    });
    // sai thông tin, trả về phiếu để sửa
    on<UpdateIssueFailEvent>((event, emit) async {
      try {
        event.goodsIssue.goodsIssueId == ''
            ? emit(CreateNewIssueInitialState(null))
            : emit(UpdateEntryToGoodsIssueSuccess(
                DateTime.now(),
                event.goodsIssue,
              ));
      } catch (e) {
        emit(CreateNewIssueInitialState(null));
        // emit(LoginStateLoginFailure(DateTime.now()));
      }
    });
  }
}
