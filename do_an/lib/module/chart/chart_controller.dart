import 'package:do_an/net_working/models/chart.dart';
import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/net_working/responstory/all_responstory.dart';
import 'package:get/get.dart';

class ChartController extends GetxController {
  final _respon = Responstory();
  final chartData = Rxn<ChartModel>();
  List<int?> listIdSong = [];
  final RxList<TrackModel> tracks = RxList.empty();



  Future getChartData() async {
    final value = await _respon.getChart();
    chartData.value = value;

    tracks.clear();
    final size = chartData.value?.tracks?.data?.length;
    if (size != null) {
      for (int i = 0; i < (size > 15 ? 15 : size); i++) {
        listIdSong.add(chartData.value?.tracks?.data![i].id);
      }
    }
    List<TrackModel?> results = await Future.wait(
      List.generate(listIdSong.length,
          (index) => _respon.getTrack(listIdSong[index].toString())),
    );
    List<TrackModel> filteredResults =
        results.where((item) => item != null).cast<TrackModel>().toList();
    tracks.value = filteredResults;
  }

  String shortenText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }
}
