import 'package:dio/dio.dart';
import 'package:downloading_manager/core/constant/assets_manager.dart';

/// Throws a DioException with a connection error type. This is used to
/// simulate a network connection error when fetching remote data.
DioException noConnection() => DioException(
  requestOptions: RequestOptions(),
  type: DioExceptionType.connectionError,
);

/// Throws a DioException with a Bad Response type. This is used to
/// simulate a bad response error when fetching remote data.
DioException badResponse(Response response) {
  final dioError = DioException(
    requestOptions: response.requestOptions,
    error: response.statusMessage,
    type: DioExceptionType.badResponse,
    response: response,
  );
  return dioError;
}

/// Returns a string indicating the type of file represented by the given
/// [fileName]. The type is determined by the file extension.
///
/// The supported file types are:
///
/// - image: jpg, jpeg, png, gif, bmp, webp
/// - video: mp4, avi, mov, mkv, wmv
/// - audio: mp3, wav, flac, aac
/// - document: pdf
/// - archive: zip, rar, 7z
/// - file: all other extensions
String getFileType(String fileName) {
  final extension = fileName.split('.').last.toLowerCase();
  switch (extension) {
    case 'jpg':
    case 'jpeg':
    case 'png':
    case 'gif':
    case 'bmp':
    case 'webp':
      return 'image';
    case 'mp4':
    case 'avi':
    case 'mov':
    case 'mkv':
    case 'wmv':
      return 'video';
    case 'mp3':
    case 'wav':
    case 'flac':
    case 'aac':
      return 'audio';
    case 'pdf':
      return 'document';
    case 'zip':
    case 'rar':
    case '7z':
      return 'archive';
    default:
      return 'file';
  }
}

class ScrollItems {
  final String image;
  final String name;
  final int color;

  ScrollItems({required this.image, required this.name, required this.color});
}

final dataItems = <ScrollItems>[
  ScrollItems(
    name: "Chicken",
    image: AssetsManager.downloadingImg,
    color: 0xFFFFA4D8,
  ),
  ScrollItems(
    name: "Burger",
    image: AssetsManager.downloadingImg,
    color: 0xFF99C5FD,
  ),
  ScrollItems(
    name: "Noodles",
    image: AssetsManager.downloadingImg,
    color: 0xFF40AC9C,
  ),
  ScrollItems(
    name: "Lemon",
    image: AssetsManager.downloadingImg,
    color: 0xFFD6F670,
  ),
  ScrollItems(
    name: "Rum",
    image: AssetsManager.downloadingImg,
    color: 0xFFE7668E,
  ),

  ScrollItems(
    name: "Cheese",
    image: AssetsManager.downloadingImg,
    color: 0xFF99C5FD,
  ),

  ScrollItems(
    name: "CocaCola",
    image: AssetsManager.downloadingImg,
    color: 0xFFFFA4D8,
  ),
  ScrollItems(
    name: "Ice Cream",
    image: AssetsManager.downloadingImg,
    color: 0xFF447C12,
  ),

  ScrollItems(
    name: "Pizza",
    image: AssetsManager.downloadingImg,
    color: 0xFFB1D1FF,
  ),
  ScrollItems(
    name: "Chicken",
    image: AssetsManager.downloadingImg,
    color: 0xFFFFA4D8,
  ),
  ScrollItems(
    name: "Burger",
    image: AssetsManager.downloadingImg,
    color: 0xFF99C5FD,
  ),
  ScrollItems(
    name: "Noodles",
    image: AssetsManager.downloadingImg,
    color: 0xFF40AC9C,
  ),
];
