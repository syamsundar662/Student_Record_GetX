import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/model/model.dart';
import 'package:student_record/utils/image/image_picker.dart';
import 'package:student_record/utils/validation/validation.dart';
import 'package:student_record/view/update/widgets/form_fields.dart';

// ignore: must_be_immutable
class Registration extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  Registration({super.key});
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final mailController = TextEditingController();

  XFile? pickImg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registration'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  kheight,
                  InkWell(
                    onTap: () async {
                              pickImg = await imagePicker();
                              if (pickImg != null) {
                                studentController.studentImg(pickImg!.path);
                              }
                            },
                    child: Obx(() {
                      return studentController.studentImg.value.isEmpty
                          ? const CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/001/840/612/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg'),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(
                                  File(studentController.studentImg.value)),
                            );
                    }),
                  ),
                  kheight,
                  EditFormFieldWidget(
                    controllers: nameController,
                    
                    hint: 'Name',
                   function: isValidName,
                  ),
                  kheight,
                  EditFormFieldWidget(
                    function: isValidAge,
                    controllers: ageController,
                    hint: 'Age',
                    
                  ),
                  kheight,
                  EditFormFieldWidget(
                    function: isValidMobileNumber,
                    controllers: phoneController, hint: 'Phone'),
                  kheight,
                  EditFormFieldWidget(
                    function: isValidEmail,
                    controllers: mailController,
                    hint: 'Gmail',
                  ),
                  kheight,
                  SizedBox(
                    height: sHeight*.059,
                    width: sWidth/2.5,
                    child: MaterialButton(
                       shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      onPressed: () {
                        submitClick(context);
                      },
                      color:const Color.fromARGB(84, 104, 126, 169),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

    void submitClick(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else if (pickImg == null) {
      Get.snackbar(
        "Image",
        'Image is required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final mail = mailController.text;
    final image = pickImg;

    final students = Student(
        name: name, age: age, phone: phone, mail: mail, image: image!.path);
    await StudentController().addStudents(students);
    studentController.studentImg.value = '';
     Get.snackbar(
      "Successfull",
      'Student added successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
    clear();
  }

  clear() {
    nameController.clear();
    ageController.clear();
    phoneController.clear();
    mailController.clear();
  }
}
