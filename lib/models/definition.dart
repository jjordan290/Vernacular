class Definition {
  final String source;
  final String text;
  final String partOfSpeech;

  Definition(
      {required this.source, required this.text, required this.partOfSpeech});

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      source: json['source'],
      text: json['text'],
      partOfSpeech: json['partOfSpeech'],
    );
  }

  get toList => null;
}
