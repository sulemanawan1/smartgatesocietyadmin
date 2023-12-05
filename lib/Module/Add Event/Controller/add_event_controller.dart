import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Constants/constants.dart';

import '../../../Constants/api_routes.dart';
import '../../../Model/User.dart';
import '../../../Routes/set_routes.dart';

class AddEventScreenController extends GetxController {
  var user = Get.arguments;
  late final User userdata;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    userdata = this.user;
  }

  final formKey = new GlobalKey<FormState>();
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventStartDateController = TextEditingController();
  TextEditingController eventEndDateController = TextEditingController();
  int eventActive = 0;
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  String? startTime;
  String? endTime;
  Future selectStartTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    print('time.$picked');
    var currentTime =
        '${picked!.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    currentTime.toString();

    startTime = currentTime.toString().split(' ')[0].trim();
    startTimeController.text =
        formatTimeToAMPM(currentTime.toString().split(' ')[0].trim());

    update();
  }

  Future selectEndTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    var currentTime =
        '${picked!.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    currentTime.toString();

    endTime = currentTime.toString().split(' ')[0].trim();
    endTimeController.text =
        formatTimeToAMPM(currentTime.toString().split(' ')[0].trim());

    update();
  }

  Future StartDate(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: new DateTime(2030),
        context: context);
    if (picked != null) picked.toString();

    eventStartDateController.text = await picked.toString().split(' ')[0];
    eventEndDateController.text = await picked.toString().split(' ')[0];
    update();
  }

  Future EndDate(context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: new DateTime(2030));
    if (picked != null) picked.toString();

    eventEndDateController.text = picked.toString().split(' ')[0];

    update();
  }

  Future addEventApi({
    required int userid,
    required String token,
    required String eventTitle,
    required String eventDescription,
    required String eventStartDate,
    required String eventEndDate,
    required String startTime,
    required String endTime,
  }) async {
    print(userid);
    print(token);

    isLoading = true;
    update();

    final response = await Http.post(
      Uri.parse(Api.addEvent),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "userid": userid,
        "title": eventTitle,
        "description": eventDescription,
        "startdate": eventStartDate,
        "enddate": eventEndDate,
        "starttime": startTime,
        "endtime": endTime,
        "active": "1",
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      var data = jsonDecode(response.body);
      print(data);
      print(response.statusCode);

      Get.offNamed(eventsscreen, arguments: user);

      myToast(msg: 'Event Add Successfully');
    } else if (response.statusCode == 403) {
      isLoading = false;
      update();
      var data = jsonDecode(response.body.toString());

      (data['errors'] as List)
          .map((e) => myToast(
                msg: e.toString(),
              ))
          .toList();
    } else {
      isLoading = false;
      update();
      myToast(msg: 'Failed to Add Event');
    }
  }
}
