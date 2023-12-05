import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Constants/constants.dart';
import 'package:societyadminapp/Widgets/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/My%20Button/my_button.dart';
import 'package:societyadminapp/Widgets/My%20TextForm%20Field/my_textform_field.dart';

import '../../../Routes/set_routes.dart';
import '../../../Widgets/My Back Button/my_back_button.dart';
import '../../../Widgets/UpIcon/up_icon.dart';
import '../Controller/add_event_controller.dart';

class AddEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AddEventScreenController>(
            init: AddEventScreenController(),
            builder: (controller) {
              return WillPopScope(
                onWillPop: () async {
                  Get.offNamed(eventsscreen, arguments: controller.user);

                  return true;
                },
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        MyBackButton(
                          text: 'Add Event',
                          onTap: () {
                            Get.offNamed(eventsscreen,
                                arguments: controller.user);
                          },
                        ),
                        32.ph,
                        SvgPicture.asset(
                          "assets/event_vector.svg",
                        ),
                        52.ph,
                        MyTextFormField(
                          controller: controller.eventTitleController,
                          validator: emptyStringValidator,
                          hintText: 'Enter Event Title',
                          labelText: 'Event Title',
                        ),
                        MyTextFormField(
                          controller: controller.eventDescriptionController,
                          validator: emptyStringValidator,
                          hintText: 'Enter Event Description',
                          labelText: 'Event Description',
                        ),
                        MyTextFormField(
                          onTap: () {
                            controller.StartDate(context);
                          },
                          suffixIcon: SvgPicture.asset(
                              "assets/add_event_icon.svg",
                              fit: BoxFit.scaleDown),
                          controller: controller.eventStartDateController,
                          validator: emptyStringValidator,
                          hintText: 'Enter Event Start Date',
                          labelText: 'Start Date',
                        ),
                        MyTextFormField(
                          onTap: () {
                            controller.EndDate(context);
                          },
                          suffixIcon: SvgPicture.asset(
                              "assets/add_event_icon.svg",
                              fit: BoxFit.scaleDown),
                          controller: controller.eventEndDateController,
                          validator: emptyStringValidator,
                          hintText: 'Enter Event End Date',
                          labelText: 'End Date',
                        ),
                        MyTextFormField(
                          controller: controller.startTimeController,
                          validator: emptyStringValidator,
                          labelText: 'Start Time ',
                          hintText: 'Start Time',
                          readOnly: true,
                          onTap: () {
                            controller.selectStartTime(context);
                          },
                        ),
                        MyTextFormField(
                          controller: controller.endTimeController,
                          validator: emptyStringValidator,
                          labelText: 'End Time ',
                          hintText: 'End Time',
                          readOnly: true,
                          onTap: () {
                            controller.selectEndTime(context);
                          },
                        ),
                        53.ph,
                        MyButton(
                          loading: controller.isLoading,
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.isLoading == false) {
                                controller.addEventApi(
                                    startTime: controller.startTime!,
                                    endTime: controller.endTime!,
                                    userid: controller.userdata.userid!,
                                    token: controller.userdata.bearerToken!,
                                    eventTitle:
                                        controller.eventTitleController.text,
                                    eventDescription: controller
                                        .eventDescriptionController.text,
                                    eventStartDate: controller
                                        .eventStartDateController.text,
                                    eventEndDate:
                                        controller.eventEndDateController.text);
                              }
                            } else {
                              return null;
                            }
                          },
                          textColor: Colors.white,
                          color: primaryColor,
                          name: 'Save Event',
                          maxLines: 1,
                        ),
                        35.ph,
                        UpIcon(),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
