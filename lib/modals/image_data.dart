typedef ImageDataList = List<ImageData>;
typedef ImageDataIterable = Iterable<ImageData>;

class ImageData {
  final Map<String, dynamic> _json;

  ImageData(this._json);

  String get copyright => _json["copyright"];

  String get _dateString => _json["date"];

  String get title => _json["title"];

  String get explanation => _json["explanation"];

  String get hdUrl => _json["hdurl"];

  String get version => _json["service_version"];

  String get mediaType => _json["media_type"];

  /// Low Resolution Image
  ///
  /// Use [hdUrl] for more clear image
  String get url => _json["url"];
}
