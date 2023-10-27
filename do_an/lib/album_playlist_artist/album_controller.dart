import 'package:do_an/net_working/models/album.dart';
import 'package:do_an/responstory/all_responstory.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  final respon = Responstory();
  final albumData = Rxn<AlbumModel>();

  Future<void> getAlbum(int id) async {
    final value = await respon.getAlbum(id.toString());
    albumData.value = value;
  }
}
