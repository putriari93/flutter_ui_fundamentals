// Nama: Putri Ari Laksmi
// NIM: 2415051091

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course.dart';
import 'course_data_source.dart';

class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    try {
      final data = await supabase
          .from('courses')
          .select()
          .order('id');

      return (data as List)
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('=== ERROR SUPABASE GET: $e ===');
      rethrow;
    }
  }

  @override
  Future<Course> createCourse(Course course) async {
    try {
      final row = await supabase
          .from('courses')
          .insert(course.toJson())
          .select()
          .single();

      return Course.fromJson(row);
    } catch (e) {
      debugPrint('=== ERROR SUPABASE INSERT: $e ===');
      rethrow;
    }
  }

  @override
  Future<Course> updateCourse(int id, Course course) async {
    try {
      final row = await supabase
          .from('courses')
          .update(course.toJson())
          .eq('id', id)
          .select()
          .single();

      return Course.fromJson(row);
    } catch (e) {
      debugPrint('=== ERROR SUPABASE UPDATE: $e ===');
      rethrow;
    }
  }

  @override
  Future<void> deleteCourse(int id) => throw UnimplementedError();
}