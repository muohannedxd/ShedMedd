import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageListController extends GetxController {
  RxList<XFile> imageList = <XFile>[].obs;

  int get length => imageList.length;
    bool get isEmpty => imageList.isEmpty;


  String pathAtIndex(int index) {
    if (index >= 0 && index < imageList.length) {
      return imageList[index].path;
    } else {
      return "";
    }
  }

  void addImage(XFile image) {
    imageList.add(image);
  }

  void removeImage(int index) {
    if (index >= 0 && index < imageList.length) {
      imageList.removeAt(index);
    }
  }

  void clear() {
    imageList.clear();
  }
}
