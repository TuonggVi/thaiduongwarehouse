import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/goods_issue_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';

class GoodsIssueService {
  List bodyJson = [];

  Future<ErrorPackageModel> postNewGoodsIssue(GoodsIssue goodsIssue) async {
    List bodyJson = [];
    for (int i = 0; i < goodsIssue.entries!.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "itemId": goodsIssue.entries![i].item!.itemId.toString(),
        "unit": goodsIssue.entries![i].item!.unit.toString(),
        "requestedQuantity":
            double.tryParse(goodsIssue.entries![i].requestQuantity.toString())
      };
      bodyJson.add(dimensionJson);
    }
    final res =
        await http.post(Uri.parse('${Constants.baseUrl}/api/GoodsIssues'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': '*/*',
            },
            body: jsonEncode(
              <String, dynamic>{
                "goodsIssueId": goodsIssue.goodsIssueId.toString(),
                "receiver": goodsIssue.receiver.toString(),
                "timestamp": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                //"timestamp": "2023-04-18",
                // "employeeId": 'NV01',
                "employeeId": "NV1",
                "entries": bodyJson
              },
            ));
    if (res.statusCode == 200) {
      return ErrorPackageModel(
        "success",
      );
    } else {
      return ErrorPackageModel("fail");
    }
  }

  Future<List<GoodsIssueModel>> getUncompletedGoodsIssue() async {
    final res = await http.get(
      Uri.parse('${Constants.baseUrl}/api/GoodsIssues?isExported=false'),
      // Uri.parse('${Constants.baseUrl}/api/GoodsIssues?isExported=false'),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Accept': '*/*',
      //   'Authorization': 'Bearer ',
      // },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<GoodsIssueModel> allIssues = body
          .map(
            (dynamic item) => GoodsIssueModel.fromJson(item),
          )
          .toList();
      return allIssues;
    }
    if (res.statusCode == 204) {
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<GoodsIssueModel>> getCompletedGoodsIssue(
      DateTime startDate, DateTime endDate) async {
    final res = await http.get(
      Uri.parse(
          '${Constants.baseUrl}api/GoodsIssues?isExported=true&StartDate=$startDate&EndDate=$endDate'),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Accept': '*/*',
      //   'Authorization': 'Bearer ',
      // },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<GoodsIssueModel> allIssues = body
          .map(
            (dynamic item) => GoodsIssueModel.fromJson(item),
          )
          .toList();
      return allIssues;
    }
    if (res.statusCode == 204) {
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<GoodsIssueModel> getGoodsIssueById(String goodsIssueId) async {
    final res = await http.get(
        Uri.parse('${Constants.baseUrl}api/GoodsIssues/$goodsIssueId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        });
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      GoodsIssueModel issue = GoodsIssueModel.fromJson(body);

      return issue;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<ErrorPackageModel> updateGoodsIssueEntry(
      String goodsIssueId, String itemEntryId, double newQuantity) async {
    return ErrorPackageModel(
      "success",
    );
  }

  Future<ErrorPackageModel> addGoodsIssueEntry(
      String goodsIssueId, GoodsIssueEntry goodsIssueEntry) async {
    return ErrorPackageModel(
      "success",
    );
  }

  Future<ErrorPackageModel> updateGoodsIssueLot(
      String goodsIssueId, String goodsIssueLotId, double newQuantity) async {
    return ErrorPackageModel(
      "success",
    );
  }

  Future<ErrorPackageModel> addLotToGoodsIssue(
      String goodsIssueId, String itemId, List<GoodsIssueLot> lots) async {
    List bodyJson = [];
    for (int i = 0; i < lots.length; i++) {
      List bodySublot = [];
      for (int j = 0; j < lots[i].goodsIssueSublot.length; j++) {
        Map<String, dynamic> dimensionSublot = {
          "locationId": lots[i].goodsIssueSublot[j].locationId.toString(),
          "quantityPerLocation": double.tryParse(
              lots[i].goodsIssueSublot[j].quantityPerLocation.toString()),
        };
        bodySublot.add(dimensionSublot);
      }
      Map<String, dynamic> dimensionJson = {
        "goodsIssueLotId": lots[i].goodsIssueLotId.toString(),
        "itemId": itemId,
        "unit": lots[i].unit.toString(),
        "itemLotLocations": bodySublot,
        "note": lots[i].note.toString(),
        //"employeeId": 'NV01',
        "employeeId": "NV1"
      };
      bodyJson.add(dimensionJson);
    }
    final res = await http.patch(
        Uri.parse(
            '${Constants.baseUrl}api/GoodsIssues/$goodsIssueId/goodsIssueLots'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
        body: jsonEncode(bodyJson));
    if (res.statusCode == 200) {
      return ErrorPackageModel(
        "success",
      );
    } else {
      return ErrorPackageModel("fail");
    }
  }

  Future<ErrorPackageModel> patchRequestQuantity(GoodsIssue goodsIssue) async {
    List bodyJson = [];
    for (int i = 0; i < goodsIssue.entries!.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "itemId": goodsIssue.entries![i].item!.itemId.toString(),
        "unit": goodsIssue.entries![i].item!.unit.toString(),
        "requestedQuantity":
            double.tryParse(goodsIssue.entries![i].requestQuantity.toString()),
      };
      bodyJson.add(dimensionJson);
    }
    String? id = goodsIssue.goodsIssueId;
    final res = await http.patch(
        Uri.parse('${Constants.baseUrl}api/GoodsIssues/$id/goodsIssueEntries'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
        body: jsonEncode(bodyJson));
    if (res.statusCode == 200) {
      return ErrorPackageModel(
        "success",
      );
    } else {
      return ErrorPackageModel("fail");
    }
  }

  Future<ErrorPackageModel> removeGoodsIssueEntry(
      GoodsIssue goodsIssue, int index) async {
    // Kiểm tra xem vị trí yêu cầu có hợp lệ không
    if (index < 0 || index >= goodsIssue.entries!.length) {
      return ErrorPackageModel("Vị trí không tồn tại");
    }

    // Lấy id của yêu cầu cần xóa
    String? entryId =
        goodsIssue.entries![index].lots![0].goodsIssueLotId.toString();
    String goodsIssueId = goodsIssue.goodsIssueId.toString();
    String itemId = goodsIssue.entries![index].item!.itemId;
    String? unit = goodsIssue.entries![index].item!.unit;

    try {
      final Uri uri = Uri.parse(
        '${Constants.baseUrl}api/GoodsIssues/$goodsIssueId/goodsIssueEntry?$entryId',
      ).replace(
        queryParameters: {
          'ItemId': itemId,
          'Unit': unit ?? '', // ?? operator is used to handle nullable values
        },
      );

      final res = await http.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
      );

      if (res.statusCode == 200) {
        // Xóa yêu cầu khỏi danh sách entries của goodsIssue
        goodsIssue.entries!.removeAt(index);
        return ErrorPackageModel("success");
      } else {
        return ErrorPackageModel("fail");
      }
    } catch (e) {
      return ErrorPackageModel("fail");
    }
  }
}

  // // xóa yêu cầu phiếu xuất kho
  // Future<ErrorPackageModel> removeGoodsIssueEntry(
  //   GoodsIssue goodsIssue, GoodsIssueEntry goodsIssueEntry) async {
  //   String id = goodsIssue.goodsIssueId.toString();
  //   String lotId = goodsIssueEntry.toString();
  //   List<String> lotIds = [lotId];
  // if (lotIds.isEmpty) {
  //   return ErrorPackageModel("fail");
  // }

  //   final res = await http.delete(
  //       Uri.parse(
  //           '${Constants.baseUrl}api/GoodsIssues/$id/goodsIssueEntry?ItemId=&Unit='),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Accept': '*/*',
  //       },
  //       body: jsonEncode(lotIds));

  //   if (res.statusCode == 200) {
  //     return ErrorPackageModel("success");
  //   } else {
  //     return ErrorPackageModel("fail");
  //   }
  // }
  // xóa phiếu yêu cầu xuất kho
//   Future<ErrorPackageModel> removeGoodsIssue(GoodsIssue goodsIssue) async {
//     String id = goodsIssue.goodsIssueId.toString();
//     final res =
//         await http.delete(Uri.parse('${Constants.baseUrl}api/GoodsIssues/$id'),
//             headers: <String, String>{
//               'Content-Type': 'application/json; charset=UTF-8',
//               'Accept': '*/*',
//             },
//             body: jsonEncode(id));
//     if (res.statusCode == 200) {
//       return ErrorPackageModel("success");
//     } else {
//       return ErrorPackageModel("fail");
//     }
//   }
//}
