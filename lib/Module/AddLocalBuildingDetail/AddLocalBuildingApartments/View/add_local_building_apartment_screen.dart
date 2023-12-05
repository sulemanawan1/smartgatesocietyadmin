import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Routes/set_routes.dart';
import '../../../AddSocietyDetail/Widget/Cutom_Add_Building_Apartment_Screen.dart';
import '../Controller/add_local_building_apartment_controller.dart';

class AddLocalBuildingApartmentsScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLocalBuildingApartmentsController>(
        init: AddLocalBuildingApartmentsController(),
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                Get.offAndToNamed(localbuildingapartmentscreen,
                    arguments: [controller.user, controller.fid]);

                return true;
              },
              child: AddBuildingApartmentCustom(
                fKey: controller.formKey,
                backonTap: () {
                  Get.offAndToNamed(localbuildingapartmentscreen,
                      arguments: [controller.user, controller.fid]);
                },
                fromController: controller.fromController,
                toController: controller.toController,
                buttonLoading: controller.isLoading,
                buttonOnPressed: () {
                  if (!controller.isLoading) {
                    controller.addApartmentsApi(
                      bearerToken: controller.user.bearerToken!,
                      from: controller.fromController.text.toString(),
                      to: controller.toController.text.toString(),
                      fid: controller.fid!,
                    );
                  }
                },
              ));
        });
  }
}
