// Nama: Putri Ari Laksmi
// NIM: 24150511091

import 'package:flutter/material.dart';
import 'course.dart';
import '../repositories/course_repository.dart';
import '../services/course_api_service.dart';

class CourseState extends ChangeNotifier {
  final CourseRepository repository;

  CourseState({CourseRepository? repository})
      : repository = repository ??
            CourseRepository(CourseApiService('https://jsonplaceholder.typicode.com'));

  List<Course> courses = [];
  bool isLoading = false;
  bool isSaving = false;
  String? error;

  final Set<String> favorites = {};

  bool isFavorite(String code) => favorites.contains(code);

  void toggleFavorite(String code) {
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }
    notifyListeners();
  }

  List<Course> get favoriteCourses {
    return courses.where((course) => favorites.contains(course.code)).toList();
  }

  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addCourse(Course course) async {
    isSaving = true;
    notifyListeners();

    try {
      await repository.createCourse(course);
      await loadCourses();
      return true;
    } catch (e) {
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<bool> editCourse(String code, Course updatedCourse) async {
    isSaving = true;
    notifyListeners();

    try {
      await repository.updateCourse(code, updatedCourse);
      await loadCourses();
      return true;
    } catch (e) {
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<bool> removeCourse(String code) async {
    isSaving = true;
    notifyListeners();

    try {
      await repository.deleteCourse(code);
      // Hapus dari favorit jika ada agar tidak menjadi data yatim
      favorites.remove(code);
      await loadCourses();
      return true;
    } catch (e) {
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }
}