import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Services/Shared%20Preferences/MySharedPreferences.dart';

import '../../../../Model/User.dart';
import '../../../Constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    getUserSharedPreferencesData();
  }

  void getUserSharedPreferencesData() async {
    User user = await MySharedPreferences.getUserData();
    print(user.bearerToken);
    if (user.bearerToken == "") {
      Timer(Duration(seconds: 3), () => Get.offAndToNamed(login));
    } else {
      Timer(Duration(seconds: 3),
          () => Get.offAndToNamed(homescreen, arguments: user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(138.w, 116.h, 138.w, 0),
              child: SvgPicture.asset('assets/splashsvg.svg'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(67.01.w, 18.h, 67.87.w, 0),
              child: SvgPicture.asset('assets/smartgate.svg'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(67.w, 7.h, 68.w, 0),
              child: Container(
                  height: 3,
                  width: 240,
                  child: SvgPicture.asset('assets/splashdivider.svg')),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(88.w, 4.h, 89.w, 0),
              child: Text(
                'SMART WAY OF LIVING',
                textAlign: TextAlign.center,
                style: GoogleFonts.inriaSerif(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                    color: primaryColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(56.w, 79.h, 56.w, 0),
              child: SvgPicture.asset('assets/splashsvg2.svg'),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.h, 46.h, 0.h, 0),
                child: Container(
                  width: double.infinity,
                  height: 237.h,
                  child: SvgPicture.asset(
                    'assets/splashsvg3.svg', fit: BoxFit.cover,
                    // fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
