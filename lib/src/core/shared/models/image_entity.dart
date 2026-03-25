import 'dart:io';

import '../../../config/res/config_imports.dart';

class ImageEntity {
  final int id;
  final File? file;
  final String image;
  final String? fileType;
  final String? thumbnail;

  const ImageEntity({
    required this.id,
    this.file,
    required this.image,
    this.thumbnail,
    this.fileType,
  });

  bool get isNetworkImage => image.isNotEmpty && file == null;
  bool get isLocalFile => file != null;

  factory ImageEntity.initial() {
    return const ImageEntity(id: 0, image: '');
  }
  factory ImageEntity.fromJson(Map<String, dynamic> json) => ImageEntity(
    id: json['id'],
    image: json['file'],
    fileType: json['file_type'] ?? '',
    thumbnail: json['thumbnail'] ?? '',
  );

  factory ImageEntity.insertLocalFile(File? file) => ImageEntity(
    id: ConstantManager.zero,
    image: ConstantManager.emptyText,
    file: file,
  );

  ImageEntity copyWith({File? value}) {
    return ImageEntity(id: id, image: image, file: value);
  }
}
