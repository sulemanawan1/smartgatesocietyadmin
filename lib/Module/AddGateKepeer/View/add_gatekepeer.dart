import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:societyadminapp/Module/AddGateKepeer/Controller/add_gate_kepeer_controller.dart';
import 'package:societyadminapp/Widgets/Extensions/extensions.dart';

import '../../../Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/CustomImagePicker/custom_image_picker.dart';
import '../../../Widgets/My Back Button/my_back_button.dart';
import '../../../Widgets/My Button/my_button.dart';
import '../../../Widgets/My Password TextForm Field/my_password_textform_field.dart';
import '../../../Widgets/My TextForm Field/my_textform_field.dart';
import '../../../Widgets/UpIcon/up_icon.dart';

class AddGateKeeper extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AddGateKeeperScreenController>(
            init: AddGateKeeperScreenController(),
            builder: (controller) {
              return WillPopScope(
                onWillPop: () async {
                  Get.offNamed(gatekeeperscreen, arguments: controller.user);

                  return true;
                },
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          MyBackButton(
                            text: 'Add Gatekeeper',
                            onTap: () {
                              Get.offNamed(gatekeeperscreen,
                                  arguments: controller.user);
                            },
                          ),
                          25.35.ph,
                          CustomImagePicker(
                            backgroundImage: controller.imageFile == null
                                ? AssetImage('assets/user.png') as ImageProvider
                                : FileImage(
                                    File(controller.imageFile!.path),
                                  ),
                            camOnPressed: () {
                              controller.getFromCamera(ImageSource.camera);
                            },
                            galOnPressed: () {
                              controller.getFromGallery(ImageSource.gallery);
                            },
                          ),
                          31.96.ph,
                          MyTextFormField(
                            controller: controller.fNameController,
                            validator: emptyStringValidator,
                            hintText: 'First Name',
                            labelText: 'First Name',
                          ),
                          MyTextFormField(
                            controller: controller.lNameController,
                            validator: emptyStringValidator,
                            hintText: 'Last Name',
                            labelText: 'Last Name',
                          ),
                          MyTextFormField(
                            textInputType: TextInputType.number,
                            controller: controller.cnicController,
                            validator: emptyStringValidator,
                            hintText: 'Cnic',
                            labelText: 'Cnic',
                          ),
                          MyTextFormField(
                            controller: controller.addressController,
                            validator: emptyStringValidator,
                            hintText: 'Address',
                            labelText: 'Address',
                          ),
                          MyTextFormField(
                            textInputType: TextInputType.number,
                            controller: controller.mobilenoController,
                            validator: emptyStringValidator,
                            hintText: 'Mobile No',
                            labelText: 'Mobile No ',
                          ),
                          MyTextFormField(
                            textInputType: TextInputType.number,
                            controller: controller.gatenoController,
                            validator: emptyStringValidator,
                            hintText: 'Gate No',
                            labelText: 'Gate No ',
                          ),
                          MyPasswordTextFormField(
                            maxLines: 1,
                            controller: controller.passwordController,
                            obscureText: controller.isHidden,
                            togglePasswordView: controller.togglePasswordView,
                            validator: emptyStringValidator,
                            hintText: 'Enter Password',
                            labelText: 'Password',
                          ),
                          56.ph,
                          MyButton(
                            loading: controller.isLoading,
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                if (controller.isLoading == false) {
                                  if (controller.imageFile?.path == null) {
                                    Get.snackbar(
                                        'Warning', 'Select an image !');
                                  } else {
                                    controller.addGateKeeperApi(
                                        file: controller.imageFile!,
                                        fName: controller.fNameController.text,
                                        lName: controller.lNameController.text,
                                        cnic: controller.cnicController.text,
                                        address:
                                            controller.addressController.text,
                                        mobileno:
                                            controller.mobilenoController.text,
                                        gateno:
                                            controller.gatenoController.text,
                                        password:
                                            controller.passwordController.text,
                                        bearerToken:
                                            controller.user!.bearerToken!,
                                        subadminid: controller.user!.userid!,
                                        societyid: controller.user!.societyid!);
                                  }
                                }
                              }
                            },
                            name: 'Save',
                          ),
                          32.ph,
                          UpIcon(),
                          18.2.ph,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
