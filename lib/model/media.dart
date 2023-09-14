class Media {
  final String? artistName;
  final String? collectionName;
  final String? trackName;
  final String? artworkUrl;
  final String? previewUrl;

  Media(
      {this.artistName,
      this.collectionName,
      this.trackName,
      this.artworkUrl,
      this.previewUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Media &&
          runtimeType == other.runtimeType &&
          artistName == other.artistName &&
          collectionName == other.collectionName &&
          trackName == other.trackName &&
          artworkUrl == other.artworkUrl &&
          previewUrl == other.previewUrl;

  @override
  int get hashCode =>
      artistName.hashCode ^
      collectionName.hashCode ^
      trackName.hashCode ^
      artworkUrl.hashCode ^
      previewUrl.hashCode;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      artistName: json['artistName'] as String?,
      collectionName: json['collectionName'] as String?,
      trackName: json['trackName'] as String?,
      artworkUrl: json['artworkUrl100'] as String?,
      previewUrl: json['previewUrl'] as String?,
    );
  }
}
