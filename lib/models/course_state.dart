// Nama: Putri Ari Laksmi
// NIM: 2415051091

import 'package:flutter/material.dart';
import '../repositories/course_repository.dart';
import 'course.dart';

class CourseState extends ChangeNotifier {
  final CourseRepository repository;

  List<Course> courses = [];
  Set<String> favorites = {};
  bool isLoading = false;
  bool isSaving = false;
  String? error;

  CourseState(this.repository);

  // Read: Mengambil daftar courses
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

  // Create: Menambah course
  Future<bool> addCourse(Course course) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final newCourse = await repository.createCourse(course);
      courses.add(newCourse);
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Update: Mengedit course
  Future<bool> editCourse(int id, Course course) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final updated = await repository.updateCourse(id, course);
      final index = courses.indexWhere((element) => element.id == id);
      if (index != -1) {
        courses[index] = updated;
      }
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Delete: Menghapus course
  Future<bool> removeCourse(Course course) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      await repository.deleteCourse(course.id);
      courses.removeWhere((element) => element.id == course.id);
      favorites.remove(course.code);
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Favorit Management
  void toggleFavorite(dynamic target) {
    final String code = target is Course ? target.code : target.toString();
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }
    notifyListeners();
  }

  bool isFavorite(dynamic target) {
    final String code = target is Course ? target.code : target.toString();
    return favorites.contains(code);
  }

  List<Course> get favoriteCourses {
    return courses.where((c) => favorites.contains(c.code)).toList();
  }
}