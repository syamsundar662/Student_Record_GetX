import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_record/model/model.dart';

class Sql with ChangeNotifier {
  //private constructor
  Sql._();

  // Singleton instance variable
  static final Sql instance = Sql._();

  // Factory constructor to return the singleton instance
  factory Sql() => instance;

  late Database db;

  Future initialiseDatabase() async {
    db = await openDatabase(
      'student.db',
      version: 1,
      onCreate: (db, version) async => await db.execute(
          'CREATE TABLE Student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, phone TEXT, mail TEXT, image TEXT)'),
    );
    await getData();
  }

  Future<bool> insertInToDb(Student model) async {
    try {
      db.rawInsert(
          'INSERT INTO Student(name, age, phone, mail, image) VALUES(?, ?, ?, ?, ?)',
          [model.name, model.age, model.phone, model.mail, model.image]);
      await getData();
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<List<Student>> getData() async {
    List<Student> studentList = [];
    List<Map<String, Object?>> list =
        await db.rawQuery('SELECT * FROM Student');
    for (var map in list) {
      final student = Student.fromMap(map);
      studentList.add(student);
    }
    return studentList;
  }

  updateTable(Student model, int id) async {
     await db.rawUpdate(
          'UPDATE Student SET name= ?,age= ?,phone= ?,mail= ?,image= ? WHERE id= ?',
          [
            model.name,
            model.age,
            model.phone,
            model.mail,
            model.image,
            id
          ]);
  }

  Future<void> deleteData(int id) async {
    await db.delete(
      'Student',
      where: 'id = ?',
      whereArgs: [id],
    );

    // studentListNotifier.value.removeWhere((element) => element.id == id);
    // studentListNotifier.notifyListeners();
  }
}
