// Nama: Putri Ari Laksmi
// NIM: 2415051091

class Course {
  final int id;
  final String code;
  final String title;
  final int credits;
  final String status;

  Course({
    this.id = 0,
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      code: json['code']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      credits: json['credits'] is int
          ? json['credits'] as int
          : int.tryParse(json['credits']?.toString() ?? '') ?? 0,
      status: json['status']?.toString() ?? 'planned',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != 0) 'id': id,
      'code': code,
      'title': title,
      'credits': credits,
      'status': status,
    };
  }
}