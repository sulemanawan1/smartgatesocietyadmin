import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Houses/Controller/houses_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/Empty%20List/empty_list.dart';
import 'package:societyadminapp/Widgets/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/My%20Back%20Button/my_back_button.dart';

import '../../../../Widgets/Loader/loader.dart';
import '../../../../Widgets/MyFloatingButton/My_Floating_Button.dart';
import '../../Widget/house_N_street_card.dart';

class Houses extends GetView<HouseController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HouseController>(
        init: HouseController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (controller.user.structureType == 5) {
                await Get.offNamed(
                    structureType5HouseOrBuildingMiddlewareScreen,
                    arguments: controller.user);
              } else if (controller.user.structureType == 1) {
                await Get.offNamed(streets, arguments: controller.user);
              } else if (controller.user.structureType == 2) {
                await Get.offNamed(streets,
                    arguments: [controller.user, controller.blockid]);
              } else if (controller.user.structureType == 3) {
                await Get.offNamed(streets, arguments: [
                  controller.user,
                  controller.blockid,
                  controller.phaseid
                ]);
              }

              return false;
            },
            child: SafeArea(
              child: Scaffold(
                  floatingActionButton: MyFloatingButton(
                    onPressed: () {
                      if (controller.user.structureType == 5) {
                        Get.offNamed(addhouses, arguments: controller.user);
                      } else if (controller.user.structureType == 1) {
                        Get.offNamed(addhouses,
                            arguments: [controller.user, controller.streetid]);
                      } else if (controller.user.structureType == 2) {
                        Get.offNamed(addhouses, arguments: [
                          controller.user,
                          controller.streetid,
                          controller.blockid
                        ]);
                      } else if (controller.user.structureType == 3) {
                        Get.offNamed(addhouses, arguments: [
                          controller.user,
                          controller.streetid,
                          controller.blockid,
                          controller.phaseid
                        ]);
                      }

                      // Get.offAndToNamed(addblocks,arguments: [controller.pid,controller.bearerToken]);
                    },
                  ),
                  body: Column(
                    children: [
                      MyBackButton(
                        text: 'Houses',
                        onTap: () {
                          if (controller.user.structureType == 5) {
                            Get.offNamed(
                                structureType5HouseOrBuildingMiddlewareScreen,
                                arguments: controller.user);
                          } else if (controller.user.structureType == 1) {
                            Get.offNamed(streets, arguments: controller.user);
                          } else if (controller.user.structureType == 2) {
                            Get.offNamed(streets, arguments: [
                              controller.user,
                              controller.blockid
                            ]);
                          } else if (controller.user.structureType == 3) {
                            Get.offNamed(streets, arguments: [
                              controller.user,
                              controller.blockid,
                              controller.phaseid
                            ]);
                          }
                        },
                      ),
                      16.ph,
                      Expanded(
                          child:
                              // (controller.structuretype == 2 ||
                              //         controller.structuretype == 3 ||
                              //         controller.structuretype == 4)
                              //     ?
                              FutureBuilder(
                                  future: (controller.user.structureType == 5)
                                      ? controller.housesApi(
                                          dynamicid: controller.user.societyid!,
                                          bearerToken:
                                              controller.user.bearerToken!)
                                      : controller.housesApi(
                                          dynamicid: controller.streetid,
                                          bearerToken:
                                              controller.user.bearerToken!),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data != null &&
                                          snapshot.data.data.length != 0) {
                                        return ListView.builder(
                                          itemCount: snapshot.data.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CustomCardHouseStreet(
                                              onTap: () {},
                                              widget: Container(
                                              
                                                height: 43.h,
                                                width: 43.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/house1.png'))),
                                              ),
                                              text: snapshot
                                                  .data.data[index].address
                                                  .toString(),
                                              firstHeight: 64.h,
                                              firstWidth: 324.w,
                                              firstcolor: HexColor('#F3F3F3'),
                                              sHeight: 43.h,
                                              sWidth: 43.w,
                                              smargin:   EdgeInsets.only(left: 8.w, top: 11.h),
                                          
                                              scolor: Color.fromRGBO(255, 153, 0, 0.14) 
                                            );
                                          },
                                        );
                                      } else {
                                        return EmptyList(name: 'No Houses');
                                      }
                                    } else if (snapshot.hasError) {
                                      return Icon(Icons.error_outline);
                                    } else {
                                      return Loader();
                                    }
                                  })),
                    ],
                  )),
            ),
          );
        });
  }
}
