// Nama: Putri Ari Laksmi
// NIM: 24150511091

class Course {
  final int? id;
  final String code;
  final String title;
  final int credits;
  final String status;
  final String description;

  const Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    this.status = 'planned',
    this.description = '',
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      code: (json['code'] as String?) ?? 'MOB0${json['id'] ?? 1}',
      title: (json['title'] as String?) ?? '',
      credits: (json['credits'] as int?) ?? 3,
      status: (json['status'] as String?) ?? 'planned',
      description: (json['description'] as String?) ?? (json['body'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'code': code,
        'title': title,
        'credits': credits,
        'status': status,
        'description': description,
      };
}