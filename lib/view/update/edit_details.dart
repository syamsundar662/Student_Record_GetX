import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/model/model.dart';
import 'package:student_record/utils/image/image_picker.dart';
import 'package:student_record/utils/validation/validation.dart';
import 'package:student_record/view/home/main_page.dart';
import 'package:student_record/view/update/widgets/form_fields.dart';

// ignore: must_be_immutable
class EditDetails extends GetView<StudentController> {
  final StudentController studentController = Get.put(StudentController());
  EditDetails({super.key, required this.data});
  final Student data;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();

  initializingValues() {
    nameController.text = data.name;
    ageController.text = data.age;
    phoneController.text = data.phone;
    mailController.text = data.mail;
    studentController.studentImg.value = data.image!;
  }

  XFile? pickImg;
  @override
  Widget build(BuildContext context) {
    initializingValues();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Details'),
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          studentController.studentImg.value = '';
          return true;
        },
        child: SafeArea(
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
                                backgroundImage: NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/001/840/612/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg'),
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
                      data: data.name,
                      controllers: nameController,
                      hint: 'Name',
                      function: isValidName,
                    ),
                    kheight,
                    EditFormFieldWidget(
                      data: data.age,
                      controllers: ageController,
                      hint: 'Age',
                      function: isValidAge,
                    ),
                    kheight,
                    EditFormFieldWidget(
                      data: data.phone,
                      controllers: phoneController,
                      hint: 'Phone',
                      function: isValidMobileNumber,
                    ),
                    kheight,
                    EditFormFieldWidget(
                      data: data.mail,
                      controllers: mailController,
                      hint: 'Gmail',
                      function: isValidEmail,
                    ),
                    kheight,
                    SizedBox(
                      height: sHeight * .059,
                      width: sWidth / 2.5,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        onPressed: () {
                          submitClick(context);
                        },
                        color: const Color.fromARGB(84, 104, 126, 169),
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
      ),
    );
  }

  void submitClick(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else if (studentController.studentImg.value.isEmpty) {
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
    final image = studentController.studentImg.value;
   
    final updateStudentData =
        Student(name: name, age: age, phone: phone, mail: mail, image: image);
    await studentController.updateStudent(updateStudentData, data.id!);
    pickImg = null;
    Get.offUntil(MaterialPageRoute(builder: (_)=>HomePage()),(route) => false); 
    // studentController.studentImg.value = '';
    Get.snackbar(
      "Update",
      'Updated Successfully',
      snackPosition: SnackPosition.BOTTOM,
    ); 
  }
}
