// Nama: Putri Ari Laksmi
// NIM: 24150511091

import '../models/course.dart';

abstract class CourseDataSource {
  Future<List<Course>> getCourses();
  Future<Course> createCourse(Course course);
  Future<Course> updateCourse(String code, Course course);
  Future<void> deleteCourse(String code);
}