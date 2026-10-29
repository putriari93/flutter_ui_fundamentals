// Nama: Putri Ari Laksmi
// NIM: 2415051091

import '../models/course.dart';

abstract class CourseDataSource {
  Future<List<Course>> getCourses();
  Future<Course> createCourse(Course course);
  Future<Course> updateCourse(int id, Course course);
  Future<void> deleteCourse(int id);
}