// Nama: Putri Ari Laksmi
// NIM: 24150511091

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../models/course_state.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;
  final bool isFavorite;

  const CourseDetailPage({
    super.key,
    required this.course,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode: ${course.code}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Bobot: ${course.credits} SKS'),
            const SizedBox(height: 8),
            Text('Status: ${course.status}'),
            const SizedBox(height: 16),
            Text(course.title, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Consumer<CourseState>(
                builder: (context, state, child) {
                  final isFav = state.favorites.contains(course.code);
                  return ElevatedButton.icon(
                    onPressed: () => state.toggleFavorite(course.code),
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                    label: Text(isFav ? 'Hapus dari Favorit' : 'Jadikan Favorit'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}