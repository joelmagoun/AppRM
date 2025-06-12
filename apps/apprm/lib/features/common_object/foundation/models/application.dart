class Application {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? description;
  final String? secret;

  Application({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.name,
    this.description,
    this.secret,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      name: json['name'] as String?,
      description: json['description'] as String?,
      secret: json['secret'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'name': name,
        'description': description,
        'secret': secret,
      };
}
