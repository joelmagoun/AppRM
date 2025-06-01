class ExternalObjectItem<T> {
  final String id;
  final String title;
  final String? subTitle;
  final List<({String key, String label})>? sortFields;
  final T? raw;
  final Map<String, dynamic>? rawJson;

  ExternalObjectItem({
    required this.id,
    required this.title,
    this.subTitle,
    this.sortFields,
    this.raw,
    this.rawJson,
  });

  factory ExternalObjectItem.fromJson(Map<String, dynamic> json) {
    return ExternalObjectItem<T>(
      id: json['id'],
      title: json['title'],
      subTitle: json['subTitle'],
      sortFields:
          json['sortFields'].map((e) => (key: e['key'], label: e['label'])),
      raw: json['raw'] is T ? json['raw'] : null,
      rawJson: json['rawJson'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['sortFields'] =
        sortFields?.map((e) => {'key': e.key, 'label': e.label});
    data['raw'] = raw;
    data['rawJson'] = rawJson;

    return data;
  }
}
