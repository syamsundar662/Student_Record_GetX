import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record/controller/search_controller.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/view/get_started/get_started.dart';
import 'package:student_record/view/home/widgets/home_list_builder.dart';

final StudentController studentViewController = Get.put(StudentController());
final searchController = Get.put(SearchControllerGetx());

class HomePage extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    studentController.getAllStudents();

    return Scaffold(
      appBar: AppBar( 
        title: Obx(() => searchController.isSearching.value?CupertinoSearchTextField(
          onChanged: (value) {
            if(value.isNotEmpty){
              studentController.searchResult(value);
            }else{
              studentController.getAllStudents(); 
            }
          },
        ): const Text("Student Portal")),
        centerTitle: true,
        actions: [
          Obx(() {
                  return IconButton(
                      onPressed: searchController.toggleSearch,
                      icon: Icon(searchController.isSearching.value
                          ? Icons.arrow_outward_sharp
                          : Icons.search));
                }) 
        ],
        leading: IconButton(
            onPressed: () {
              Get.offUntil(
                  MaterialPageRoute(builder: (_) => const GetStarted()),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Obx(() {
            final studentList = studentController.studentList;
            if (studentList.isEmpty) {
              return const Center(
                child: Center(
                  child: Text('No records found!'),
                ),
              );
            } else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: HomeStudentListBuilder(
                      studentList: studentList,
                      studentController: studentController),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
