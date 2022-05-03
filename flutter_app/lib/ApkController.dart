import 'dart:io';

import 'package:archive/archive.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path_provider/path_provider.dart';



class ApkController extends GetxController{
  var list="请选择要解压的文件".obs;
  var unzipPath="".obs;


  @override
  void onReady() {
    super.onReady();
    loadResult();


  }

  unzip(String pwd) async {

    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      try {
        //File file = File(result.files.single.path);

        final zipFile = File(result.files.single.path);

        String destinationDir = zipFile.parent.path;
        if (Platform.isAndroid) {
          var dir = await getExternalStorageDirectory();
          destinationDir = dir.path;
          //print(path);  // [/storage/emulated/0, /storage/B3AE-4D28]
        }

        final bytes = File(result.files.single.path).readAsBytesSync();
        Archive archive;
        // Decode the Zip file
        if (pwd.isNotEmpty) {
          archive = ZipDecoder().decodeBytes(
              bytes, verify: true, password: pwd);
        } else {
          archive = ZipDecoder().decodeBytes(bytes);
        }
        // print("success:${destinationDir.path}");
        // Extract the contents of the Zip archive to disk.
        for (final file in archive) {
          final filename = file.name;
          if (file.isFile) {
            final data = file.content as List<int>;
            File(destinationDir + '/' + filename)
              ..createSync(recursive: true)
              ..writeAsBytesSync(data);
          } else {
            Directory(destinationDir + '/' + filename).create(recursive: true);
          }
        }

        print("success:${destinationDir}");
        unzipPath.value = "解压成功,文件路径：" + destinationDir;
      }catch(e){
        unzipPath.value="解压失败："+e.toString();
      }

    } else {
      // User canceled the picker
    }
  }

  loadResult() async {


    //var ret = await mock();
    //list.value=ret;
  }

  Future<String> mock() async {
    var result = await Process.run('ls', ['-l']);
    print("result.stdout:"+result.stdout);
    return result.stdout;
  }

}