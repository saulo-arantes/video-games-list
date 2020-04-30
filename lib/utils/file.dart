import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<List<int>> testCompressFile(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minWidth: 2300,
    minHeight: 1500,
    quality: 94,
    rotate: 90,
  );

  print(file.lengthSync());
  print(result.length);

  return result;
}
