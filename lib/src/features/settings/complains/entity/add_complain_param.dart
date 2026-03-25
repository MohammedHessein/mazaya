import 'package:flutter/widgets.dart';
import '../../../../core/extensions/form_mixin.dart';
import '../../../../core/helpers/image_helper.dart';
import '../../../../core/shared/models/image_entity.dart';

class AddComplainParam with FormMixin {
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final ValueNotifier<List<ImageEntity>> imagesNotifer =
      ValueNotifier<List<ImageEntity>>([]);

  void dispose() {
    reasonController.dispose();
    detailsController.dispose();
    imagesNotifer.dispose();
  }

  void selectImages() async {
    final result = await ImageHelper.getImages();
    final List<ImageEntity> images = [];
    for (final element in result) {
      images.add(ImageEntity.insertLocalFile(element));
    }
    imagesNotifer.value.addAll(images);
    imagesNotifer.value = [...imagesNotifer.value];
  }

  void removeImage(ImageEntity file) {
    imagesNotifer.value.remove(file);
    imagesNotifer.value = [...imagesNotifer.value];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'name': reasonController.text,
      'complaint': detailsController.text,
    };

    for (var i = 0; i < imagesNotifer.value.length; i++) {
      json.addAll({'files[$i]': imagesNotifer.value[i].file});
    }
    return json;
  }
}
