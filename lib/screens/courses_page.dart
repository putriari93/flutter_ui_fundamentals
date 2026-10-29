// Nama: Putri Ari Laksmi
// NIM: 2415051091

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course_state.dart';
import '../widgets/error_view.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseState>();

    // 1. Loading State
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 2. Error State
    if (state.error != null) {
      return ErrorView(
        message: state.error!,
        onRetry: () => context.read<CourseState>().loadCourses(),
      );
    }

    // 3. Empty State
    if (state.courses.isEmpty) {
      return const Center(
        child: Text(
          'Data course belum tersedia',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // 4. Success State (Tampilkan List)
    return ListView.builder(
      itemCount: state.courses.length,
      itemBuilder: (context, index) {
        final course = state.courses[index];
        return ListTile(
          title: Text(course.title),
          subtitle: Text('Code: ${course.code} | Status: ${course.status}'),
          trailing: Text('${course.credits} SKS'),
        );
      },
    );
  }
}