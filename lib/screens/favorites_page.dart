// Nama: Putri Ari Laksmi
// NIM: 24150511091

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course_state.dart';
import 'course_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mata Kuliah Favorit'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<CourseState>(
        builder: (context, state, child) {
          final favCourses = state.favoriteCourses;

          if (favCourses.isEmpty) {
            return const Center(
              child: Text('Belum ada mata kuliah favorit.'),
            );
          }

          return ListView.builder(
            itemCount: favCourses.length,
            itemBuilder: (context, index) {
              final course = favCourses[index];
              return ListTile(
                title: Text(course.title),
                subtitle: Text('${course.code} • ${course.credits} SKS'),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => state.toggleFavorite(course.code),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseDetailPage(
                        course: course,
                        isFavorite: state.isFavorite(course.code),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}