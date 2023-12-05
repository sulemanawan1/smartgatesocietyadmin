import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:societyadminapp/Widgets/Extensions/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/Dialog Box Elipse Heading/dialog_box_elipse_heading.dart';
import '../../../Widgets/My Back Button/my_back_button.dart';
import '../../../Widgets/My Button/my_button.dart';
import '../../../Widgets/ReportsScreenCard/reports_screen_card.dart';
import '../Controller/resident_reports_controller.dart';
import '../Model/ResidentReports.dart';

class UserReportsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResidentReportsController>(
      init: ResidentReportsController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Get.offNamed(viewreportscreen, arguments: controller.userdata);

          return true;
        },
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  MyBackButton(
                    text: 'Reports',
                    onTap: () {
                      Get.offNamed(viewreportscreen,
                          arguments: controller.userdata);
                    },
                  ),
                  Expanded(
                    child: FutureBuilder<List<ResidentReports>>(
                        future: controller.viewResidentsReportsApi(
                            controller.userdata.userid!,
                            controller.residentId,
                            controller.userdata.bearerToken!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null &&
                                snapshot.data!.length != 0) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return ReportsScreenCard(
                                    heading:
                                        snapshot.data![index].title.toString(),
                                    heading1: snapshot.data![index].description
                                        .toString(),
                                    heading2: convertUtcToFormattedTimeAdd5Hours(
                                            snapshot.data![index].updatedAt!) +
                                        " " +
                                        convertLaravelDateFormatToDayMonthYearDateFormat(
                                            snapshot.data![index].updatedAt!),
                                    buttonName: 'In Progress',
                                    color: HexColor('#D20C0C'),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                            content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                    'Report Detail' ?? "",
                                                    style: GoogleFonts.ubuntu(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp,
                                                        color: HexColor(
                                                            '#606470'))),
                                              ),
                                              14.h.ph,
                                              DialogBoxElipseHeading(
                                                text: "Title",
                                              ),
                                              8.95.h.ph,
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 26.w),
                                                child: Text(
                                                    snapshot.data![index]
                                                            .title ??
                                                        "",
                                                    style: GoogleFonts.ubuntu(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp,
                                                        color: HexColor(
                                                            '#606470'))),
                                              ),
                                              8.95.h.ph,
                                              DialogBoxElipseHeading(
                                                text: "Description",
                                              ),
                                              8.95.h.ph,
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 26.w),
                                                child: Text(
                                                    snapshot.data![index]
                                                            .description ??
                                                        "",
                                                    style: GoogleFonts.ubuntu(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp,
                                                        color: HexColor(
                                                            '#606470'))),
                                              ),
                                              8.95.h.ph,
                                              DialogBoxElipseHeading(
                                                text: "Mobile No",
                                              ),
                                              8.95.h.ph,
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 26.w),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        controller
                                                                .residentMobileno ??
                                                            "",
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.sp,
                                                                color: HexColor(
                                                                    '#606470'))),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    IconButton(
                                                        onPressed: () async {
                                                          controller.uri =
                                                              Uri.parse(
                                                                  "tel://${controller.residentMobileno}");

                                                          try {
                                                            await launchUrl(
                                                                controller
                                                                    .uri!);
                                                            controller.uri =
                                                                null;
                                                          } catch (e) {}
                                                        },
                                                        icon: Icon(
                                                          Icons.call,
                                                          color: Colors.green,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              8.95.h.ph,
                                              DialogBoxElipseHeading(
                                                text: "Name",
                                              ),
                                              8.95.h.ph,
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 26.w),
                                                child: Text(
                                                    controller.residentName ??
                                                        "",
                                                    style: GoogleFonts.ubuntu(
                                                        fontSize: 11.sp,
                                                        color: HexColor(
                                                            '#333333'))),
                                              ),
                                              8.95.h.ph,
                                              DialogBoxElipseHeading(
                                                text: "Address",
                                              ),
                                              8.95.h.ph,
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 26.w),
                                                child: Text(
                                                    controller
                                                            .residentAddress ??
                                                        "",
                                                    style: GoogleFonts.ubuntu(
                                                        fontSize: 11.sp,
                                                        color: HexColor(
                                                            '#333333'))),
                                              ),
                                              14.h.ph,
                                              Center(
                                                child: MyButton(
                                                  border: 4.r,
                                                  width: 67.w,
                                                  height: 22.w,
                                                  name: 'Ok',
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                              14.h.ph,
                                            ],
                                          ),
                                        )),
                                      );
                                    },
                                  );
                                },
                                itemCount: snapshot.data!.length,
                              );
                            } else {
                              return Text('no resident');
                            }
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error_outline);
                          } else {
                            return Center(
                                child: CircularProgressIndicator(
                              color: primaryColor,
                            ));
                          }
                        }),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
