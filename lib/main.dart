// Nama: Putri Ari Laksmi
// NIM: 2415051091

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/course_state.dart';
import 'repositories/course_repository.dart';
import 'services/course_api_service.dart';
import 'widgets/responsive_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Rakit Service -> Repository -> Provider
  final apiService = CourseApiService('https://jsonplaceholder.typicode.com');
  final repository = CourseRepository(apiService);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(repository)..loadCourses(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer v2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ResponsiveShell(),
    );
  }
}