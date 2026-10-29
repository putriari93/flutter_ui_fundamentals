// Nama: Putri Ari Laksmi
// NIM: 2415051091

class Course {
  final int? id;
  final String code;
  final String title;
  final int credits;
  final String status;

  const Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    this.status = 'planned',
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      code: (json['code'] as String?) ?? 'COURSE-${json['id']}',
      title: (json['title'] as String?) ?? '',
      credits: (json['credits'] as int?) ?? 3,
      status: (json['status'] as String?) ?? 'planned',
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'code': code,
        'title': title,
        'credits': credits,
        'status': status,
      };
}