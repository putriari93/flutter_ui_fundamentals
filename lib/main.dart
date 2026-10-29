// Nama: Putri Ari Laksmi
// NIM: 24150511091

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter_ui_fundamentals/config/supabase_config.dart';
import 'package:flutter_ui_fundamentals/models/course_state.dart';
import 'package:flutter_ui_fundamentals/repositories/course_repository.dart';
import 'package:flutter_ui_fundamentals/services/course_supabase_service.dart';
import 'package:flutter_ui_fundamentals/widgets/responsive_shell.dart'; // Import shell navigasi

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Panggil fungsi API service
  final apiService = CourseApiService();
  await apiService.fetchCourses();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseState(
        repository: CourseRepository(CourseSupabaseService()),
      )..loadCourses(),
      child: MaterialApp(
        title: 'Course Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ResponsiveShell(), // Ganti dari CoursesPage() ke ResponsiveShell()
      ),
    );
  }
}