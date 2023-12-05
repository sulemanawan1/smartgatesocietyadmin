import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

import '../../../../Model/User.dart';
import '../../../Constants/api_routes.dart';
import '../Model/notice_board_model.dart';

class NoticeBoardController extends GetxController {
  var user = Get.arguments;
  late Future data;

  late final User userdata;

  List<NoticeBoardModel> li = [];
  var currentNoticeBoardId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("init");
    userdata = this.user;
    data = viewNoticeBoardApi(userdata.userid!, userdata.bearerToken!);
    update();
  }

  Future<List<NoticeBoardModel>> viewNoticeBoardApi(
      int subadminid, String token) async {
    final response = await Http.get(
      Uri.parse(Api.viewAllNotices + "/" + subadminid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      li = (data["data"] as List)
          .map((e) => NoticeBoardModel(
                id: e['id'],
                noticetitle: e['noticetitle'],
                noticedetail: e['noticedetail'],
                startdate: e['startdate'],
                enddate: e['enddate'],
                starttime: e['starttime'],
                endtime: e['endtime'],
                status: e['status'],
                subadminid: e['subadminid'],
              ))
          .toList();
      update();
      return li;
    }
    return li;
  }

  Future deleteNoticeBoardApi(int noticeid, String token) async {
    print(noticeid.toString());
    print(token);

    final response = await Http.get(
      Uri.parse(Api.deleteNotice + "/" + noticeid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());
    var mydata = data['data'];

    print('my data.......$mydata');

    if (response.statusCode == 200) {
      this.data = viewNoticeBoardApi(userdata.userid!, userdata.bearerToken!);
      Get.back();
      update();
    }
  }
}
