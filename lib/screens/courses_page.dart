// Nama: Putri Ari Laksmi
// NIM: 2415051091

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../models/course_state.dart';
import '../widgets/error_view.dart';
import 'add_course_page.dart';
import 'edit_course_page.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  void _showDeleteDialog(BuildContext context, Course course) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus course "${course.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(dialogContext);

              final success = await context.read<CourseState>().removeCourse(course);

              if (!context.mounted) return;

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Course berhasil dihapus!')),
                );
              } else {
                final errorMsg = context.read<CourseState>().error ?? 'Gagal menghapus course';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
                );
              }
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Course')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCoursePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, CourseState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return ErrorView(
        message: state.error!,
        onRetry: () => context.read<CourseState>().loadCourses(),
      );
    }

    if (state.courses.isEmpty) {
      return const Center(
        child: Text(
          'Data course belum tersedia',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: state.courses.length,
      itemBuilder: (context, index) {
        final course = state.courses[index];
        final isFav = state.isFavorite(course);

        return ListTile(
          title: Text(course.title),
          subtitle: Text('Code: ${course.code} | Status: ${course.status}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditCoursePage(course: course),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _showDeleteDialog(context, course),
              ),
              IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                onPressed: () => state.toggleFavorite(course),
              ),
            ],
          ),
        );
      },
    );
  }
}