
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';

import '../../../domain/entities/finish_product/finished_product_issue.dart';
import '../../../domain/entities/finish_product/finished_product_issue_entry.dart';
import '../../models/finish_product/finished_product_issue_model.dart';


class FinishedProductIssueService {
  List bodyJson = [];
  Future<ErrorPackageModel> postNewFinishedProductIssue(
      FinishedProductIssue finishedProductIssue) async {
    List bodyJson = [];
    for (int i = 0; i < finishedProductIssue.entries.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "itemId": finishedProductIssue.entries[i].item.itemId.toString(),
        "unit": finishedProductIssue.entries[i].item.unit.toString(),    
      };
      bodyJson.add(dimensionJson);
    }
    final res =
        await http.post(Uri.parse('${Constants.baseUrl}/api/FinishedProductIssues'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': '*/*',
            },
            body: jsonEncode(
              <String, dynamic>{
              //   "FinishedProductIssueId": finishedProductIssue.finishedProductIssueId.toString(),
              //   "receiver": finishedProductIssue.receiver.toString(),
              //   "timestamp": DateFormat('yyyy-MM-dd').format(DateTime.now()),
              //   //"timestamp": "2023-04-18",
              //   "employeeId": "NV01",
              //   "entries": bodyJson
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

  Future<List<FinishedProductIssueModel>> getUncompletedFinishedProductIssue() async {
    final res = await http.get(
      Uri.parse('${Constants.baseUrl}api/FinishedProductIssues/Unconfirmed'),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Accept': '*/*',
      //   'Authorization': 'Bearer ',
      // },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<FinishedProductIssueModel> allIssues = body
          .map(
            (dynamic item) => FinishedProductIssueModel.fromJson(item),
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

  Future<List<FinishedProductIssueModel>> getCompletedFinishedProductIssue(
      DateTime startDate, DateTime endDate) async {
    final res = await http.get(
      Uri.parse(
          '${Constants.baseUrl}api/FinishedProductIssues?StartDate=$startDate&EndDate=$endDate'),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Accept': '*/*',
      //   'Authorization': 'Bearer ',
      // },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<FinishedProductIssueModel> allIssues = body
          .map(
            (dynamic item) => FinishedProductIssueModel.fromJson(item),
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

  Future<FinishedProductIssueModel> getFinishedProductIssueById(String finishedProductIssueId) async {
    final res = await http.get(
        Uri.parse('${Constants.baseUrl}api/FinishedProductissues/$finishedProductIssueId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        });
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      FinishedProductIssueModel issue = FinishedProductIssueModel.fromJson(body);

      return issue;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<ErrorPackageModel> updateFinishedProductIssueEntry(
      String finishedProductIssueId, String itemEntryId, double newQuantity) async {
    return ErrorPackageModel(
      "success",
    );
  }

  Future<ErrorPackageModel> addFinishedProductIssueEntry(
      String finishedProductIssueId, FinishedProductIssueEntry finishedProductIssueEntry) async {
    return ErrorPackageModel(
      "success",
    );
  }

  Future<ErrorPackageModel> updateFinishedProductIssueLot(
      String finishedProductIssueId, double newQuantity) async {
    return ErrorPackageModel(
      "success",
    );
  }

  // Future<ErrorPackageModel> addLotToFinishedProductIssue(
  //     String finishedProductIssueId, String itemId, List<finishedProductIssueLot> lots) async {
  //   List bodyJson = [];
  //   for (int i = 0; i < lots.length; i++) {
  //     Map<String, dynamic> dimensionJson = {
  //       "FinishedProductIssueLotId": lots[i].FinishedProductIssueLotId.toString(),
  //       "itemId": itemId,
  //       "quantity": double.tryParse(lots[i].quantity.toString()),
  //       "sublotSize": double.tryParse(lots[i].sublotSize.toString()),
  //       "note": lots[i].note.toString(),
  //       "employeeId": "NV01"
  //     };
  //     bodyJson.add(dimensionJson);
  //   }
  //   final res = await http.patch(
  //       Uri.parse(
  //           '${Constants.baseUrl}api/FinishedProductIssues/$finishedProductIssueId/FinishedProductIssueLots'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Accept': '*/*',
  //       },
  //       body: jsonEncode(bodyJson));
  //   if (res.statusCode == 200) {
  //     return ErrorPackageModel(
  //       "success",
  //     );
  //   } else {
  //     return ErrorPackageModel("fail");
  //   }
  // }
}
