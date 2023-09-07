import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/model/model.dart';
import 'package:student_record/view/full_details/widgets/cards.dart';
import 'package:student_record/view/update/edit_details.dart';

class FullDetails extends StatelessWidget {
  const FullDetails({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
             CircleAvatar(radius: 80,backgroundImage: FileImage(File(student.image!)),),
            kheight,
            Expanded(child: FieldCard(student: student)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor:const Color.fromARGB(93, 25, 132, 168),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                  onPressed: (){ 
                  Get.to(EditDetails(data:student ,)); 
                },child:const Icon(Icons.edit,color: Color.fromARGB(172, 255, 255, 255),),),
                kwidget,
              ],
            )
          ],
        ),
      )
    );
  }
}

