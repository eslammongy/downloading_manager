/// create an enum for file types
enum FileType {
  image,
  video,
  audio,
  pdf,
  document,
  excel,
  powerpoint,
  json,
  zip,
  file;

  bool get isImage => this == FileType.image;
  bool get isVideo => this == FileType.video;
  bool get isAudio => this == FileType.audio;
  bool get isPdf => this == FileType.pdf;
  bool get isDocument => this == FileType.document;
  bool get isExcel => this == FileType.excel;
  bool get isPowerpoint => this == FileType.powerpoint;
  bool get isJson => this == FileType.json;
  bool get isZip => this == FileType.zip;
  bool get isFile => this == FileType.file;
}
