// Nama: Putri Ari Laksmi
// NIM: 24150511091

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../models/course_state.dart';
import '../widgets/error_view.dart';
import 'add_course_page.dart';
import 'edit_course_page.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  Future<void> _confirmDelete(BuildContext context, Course course) async {
    final state = context.read<CourseState>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus "${course.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final success = await state.removeCourse(course.code);

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course berhasil dihapus!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menghapus course'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseState>();

    Widget bodyContent;

    if (state.isLoading) {
      bodyContent = const Center(child: CircularProgressIndicator());
    } else if (state.error != null) {
      bodyContent = ErrorView(
        message: state.error!,
        onRetry: state.loadCourses,
      );
    } else if (state.courses.isEmpty) {
      bodyContent = const Center(child: Text('Data course belum tersedia'));
    } else {
      bodyContent = ListView.builder(
        itemCount: state.courses.length,
        itemBuilder: (context, index) {
          final course = state.courses[index];
          return ListTile(
            title: Text(course.title),
            subtitle: Text('${course.code} • ${course.credits} SKS'),
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
                  onPressed: () => _confirmDelete(context, course),
                ),
                IconButton(
                  icon: Icon(
                    state.isFavorite(course.code)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: state.isFavorite(course.code) ? Colors.red : null,
                  ),
                  onPressed: () => state.toggleFavorite(course.code),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body: bodyContent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCoursePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}