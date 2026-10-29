// Nama: Putri Ari Laksmi
// NIM: 2415051091

import 'package:flutter/foundation.dart';
import 'course.dart';
import '../repositories/course_repository.dart';
import '../services/course_api_service.dart';

class CourseState extends ChangeNotifier {
  final CourseRepository _repository;

  List<Course> _courses = [];
  final List<Course> _favorites = [];
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;

  CourseState([CourseRepository? repository])
      : _repository = repository ?? CourseRepository(CourseApiService());

  // Getters
  List<Course> get courses => _courses;
  List<Course> get favorites => _favorites;
  List<Course> get favoriteCourses => _favorites;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  String? get errorMessage => _error;

  // Fetch Courses dari API
  Future<void> loadCourses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _courses = await _repository.getCourses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Tambah Course Baru (HTTP POST)
  Future<bool> addCourse(Course course) async {
    _isSaving = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.createCourse(course);
      await loadCourses(); // Refresh daftar course dari server setelah add
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  // Toggle Favorit
  bool isFavorite(dynamic item) {
    if (item is Course) {
      return _favorites.contains(item);
    } else if (item is String) {
      return _favorites.any((c) => c.code == item);
    }
    return false;
  }

  void toggleFavorite(dynamic item) {
    Course? course;
    if (item is Course) {
      course = item;
    } else if (item is String) {
      try {
        course = _courses.firstWhere((c) => c.code == item);
      } catch (_) {
        course = null;
      }
    }

    if (course != null) {
      if (_favorites.contains(course)) {
        _favorites.remove(course);
      } else {
        _favorites.add(course);
      }
      notifyListeners();
    }
  }

  // Edit & Hapus Lokal
  Future<bool> editCourse(String code, Course updatedCourse) async {
    _isSaving = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _courses.indexWhere((c) => c.code == code);
    if (index != -1) {
      _courses[index] = updatedCourse;
      _isSaving = false;
      notifyListeners();
      return true;
    }
    _isSaving = false;
    notifyListeners();
    return false;
  }

  Future<bool> removeCourse(String code) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _courses.removeWhere((c) => c.code == code);
    _favorites.removeWhere((c) => c.code == code);
    notifyListeners();
    return true;
  }
}