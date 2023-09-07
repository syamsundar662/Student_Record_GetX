import 'package:get/state_manager.dart';
import 'package:student_record/controller/db_functions.dart';
import 'package:student_record/model/model.dart';


class StudentController extends GetxController{

Sql data = Sql();
RxList<Student> studentList =  <Student>[].obs;
RxString studentImg =  ''.obs;

getAllStudents() async {
  final fetchData = await data.getData();
  studentList.assignAll(fetchData);
}

addStudents(Student student)async{
 await data.insertInToDb(student);
 getAllStudents();
}

deleteStudent(int id)async{
 await data.deleteData(id);
 getAllStudents();
}

updateStudent(Student student,int id)async{
 await data.updateTable(student,id);
 await getAllStudents();
}
searchResult(String searchQuery) async {
    List<Student> list = await data.getData();
    List<Student> resultList = list
        .where((student) =>
            student.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    studentList.assignAll(resultList);
  }
}