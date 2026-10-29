// Nama: Putri Ari Laksmi
// NIM: 2415051091

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/course_state.dart';
import 'widgets/responsive_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Panggil ..loadCourses() saat state pertama kali dibuat
      create: (_) => CourseState()..loadCourses(),
      child: MaterialApp(
        title: 'Course Explorer v2',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ResponsiveShell(),
      ),
    );
  }
}