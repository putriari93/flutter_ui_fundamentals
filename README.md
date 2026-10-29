# flutter_ui_fundamentals

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Course Explorer v2 - Flutter UI Fundamentals

**Nama:** Putri Ari Laksmi  
**NIM:** 2415051091  

## Arsitektur Aplikasi & Dependency Direction

Aplikasi ini menerapkan *Separation of Concerns* dengan alur ketergantungan (*dependency direction*) searah:
`Screen/Widget` -> `Provider (CourseState)` -> `CourseRepository` -> `CourseService` -> `Data Source (JSON)`

### Tanggung Jawab Folder:
* **`models/`**: Menyimpan struktur data murni (misal: `Course`) dan *application state holder* (`CourseState`).
* **`services/`**: Menangani pembacaan data mentah dari sumber luar (`rootBundle` / `student_data.json`) dan proses `jsonDecode`.
* **`repositories/`**: Menjadi perantara antara service dan provider untuk mengolah atau memetakan data mentah menjadi objek model.
* **`providers/`**: Mengelola *reactive state* (`isLoading`, `error`, `courses`, `favorites`) dan memanggil `notifyListeners()`.
* **`screens/`**: Menampilkan antarmuka pengguna (*UI Pages*) tanpa menyimpan *business logic* atau pemanggilan data mentah.
* **`widgets/`**: Menyimpan komponen UI yang reusable (seperti `ResponsiveShell`).

## REST API Endpoint Documentation
- **Endpoint:** https://jsonplaceholder.typicode.com/posts
- **HTTP Method:** GET
- **Status Code:** 200 OK
- **JSON Fields:** `id`, `code`, `title`, `credits`, `status`