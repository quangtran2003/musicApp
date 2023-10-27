import 'package:do_an/net_working/chart.dart';
import 'package:do_an/net_working/models/tracklist_playlist.dart';
import 'package:get/get.dart';

import 'package:do_an/responstory/all_responstory.dart';

class ChartController extends GetxController {
  final _chartRespon = Responstory();
  final chart = Rxn<ChartModel>();

  Future getChart() async {
    final value = await _chartRespon.getChart();
    chart.value = value;
  }

  Future getTracklistPlaylist() async {}
}
