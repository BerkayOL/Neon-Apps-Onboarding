class TrackModel {
  final int id;
  final String title;
  final String artist;
  final String imageUrl;
  final String description;

  TrackModel({
    required this.title,
    required this.artist,
    required this.id,
    required this.imageUrl,
    required this.description,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      id: json['id'] as int? ?? 0,
      title: json['title']?.toString() ?? 'İsimsiz Şarkı',
      artist: json['brand']?.toString() ?? 'Bilinmeyen Sanatçı',
      imageUrl: json['thumbnail']?.toString() ?? '',
      description: json['description']?.toString() ?? 'Açıklama bulunmuyor',
    );
  }
}
