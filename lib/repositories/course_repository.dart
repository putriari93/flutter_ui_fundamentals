// Nama: Putri Ari Laksmi
// NIM: 2415051091

import '../models/course.dart';
import '../services/course_api_service.dart';

class CourseRepository {
  final CourseApiService apiService;

  CourseRepository(this.apiService);

  Future<List<Course>> getCourses() async {
    return await apiService.getCourses();
  }

  Future<Course> createCourse(Course course) async {
    return await apiService.createCourse(course);
  }

  Future<Course> updateCourse(int id, Course course) async {
    return await apiService.updateCourse(id, course);
  }

  // METHOD DELETE (TAHAP 8)
  Future<void> deleteCourse(int id) async {
    await apiService.deleteCourse(id);
  }
}