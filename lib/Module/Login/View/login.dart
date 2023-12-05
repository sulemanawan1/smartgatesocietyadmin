import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:societyadminapp/Constants/constants.dart';
import 'package:societyadminapp/Module/Login/Controller/login_controller.dart';
import 'package:societyadminapp/Widgets/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/My%20Button/my_button.dart';
import 'package:societyadminapp/Widgets/My%20Password%20TextForm%20Field/my_password_textform_field.dart';
import 'package:societyadminapp/Widgets/My%20TextForm%20Field/my_textform_field.dart';

import '../../../Widgets/UpIcon/up_icon.dart';

class Login extends GetView {
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#FFFFFF'),
        body: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(44.w, 45.h, 44.w, 0),
                      child: Image.asset(
                        "assets/login_vector.jpg",
                      ),
                    ),
                    65.ph,
                    Text(
                      "Welcome Back",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        color: HexColor('#4D4D4D'),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 36.font,
                      ),
                    ),
                    21.ph,
                    Text(
                      "LOGIN TO YOUR ACCOUNT !",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        color: HexColor('#717171'),
                        letterSpacing: 1.3,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.font,
                      ),
                    ),
                    60.ph,
                    MyTextFormField(
                      textInputType: TextInputType.number,
                      controller: controller.userCnicController,
                      validator: emptyStringValidator,
                      hintText: 'Enter Cnic',
                      labelText: 'Cnic',
                    ),
                    MyPasswordTextFormField(
                        controller: controller.userPasswordController,
                        validator: emptyStringValidator,
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        togglePasswordView: controller.togglePasswordView,
                        obscureText: controller.isHidden),
                    18.ph,
                    MyButton(
                      loading: controller.loading,
                      height: 43.h,
                      width: 173.w,
                      color: primaryColor,
                      onPressed: () {
                        if (!controller.loading) {
                          if (_formKey.currentState!.validate()) {
                            if (!controller.loading) {
                              controller.loginApi(
                                  controller.userCnicController.text,
                                  controller.userPasswordController.text);
                            }
                          }
                        }
                      },
                      name: 'Login',
                    ),
                    20.ph,
                    SvgPicture.asset('assets/line.svg'),
                    20.6.ph,
                    UpIcon(),
                  ]),
                ),
              );
            }),
      ),
    );
  }
}
