import 'package:dio/dio.dart';

import 'Models/ModelsStudents.dart';
import 'Models/ModelsCourses.dart';

const String localhost = "http://10.0.2.2:1200/";

class CoursesApi {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getAllStudents() async {
    final response = await _dio.get('/getAllStudents');

    return response.data['learners'];
  }

  Future<List> getAllCourses() async {
    final response = await _dio.get('/getAllCourses');

    return response.data['programs'];
  }

  Future deleteCourses(String id) async {
    await _dio.post('/deleteCourseById', data: {"id": id});
  }

  Future changeFname(String id, String fname) async {
    await _dio.post('/editStudentById', data: {"id": id, "fname": fname});
  }
}
