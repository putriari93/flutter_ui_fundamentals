// Nama: Putri Ari Laksmi
// NIM: 2415051091

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/supabase_config.dart';
import 'models/course_state.dart';
import 'repositories/course_repository.dart';
import 'services/course_supabase_service.dart';
import 'widgets/responsive_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase Client
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  // Menggunakan CourseSupabaseService sebagai data source
  final supabaseService = CourseSupabaseService();
  final repository = CourseRepository(supabaseService);

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