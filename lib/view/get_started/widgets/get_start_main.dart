import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/view/register/registration.dart';
import 'package:student_record/view/get_started/widgets/get_started_buttons.dart';
import 'package:student_record/view/home/main_page.dart';

class GetStartMainSection extends StatelessWidget {
  const GetStartMainSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3),
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: sWidth/1.1,
              height: sHeight/2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromARGB(196, 255, 255, 255)
                      .withOpacity(.04)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Student Portal',
                    style: TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 30),
                  ),
                  kheight,
                  kheight,
                  GetStartButtons(
                    textTitle: 'New Registration',
                    onpress: () {
                      Get.to(() => Registration());
                    },
                  ),
                  kheight,
                  GetStartButtons(
                    textTitle: 'Student Record',
                    onpress: () {
                      Get.to(() => HomePage());
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
