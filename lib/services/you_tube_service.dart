import 'package:dio/dio.dart';

import '../data/youtube_data.dart';
import '../sgela_util/dio_util.dart';
import '../sgela_util/environment.dart';
import '../sgela_util/functions.dart';
import 'local_data_service.dart';

class YouTubeService {
  static const mm = '🥦🥦🥦YouTubeService: 🍎';
  final DioUtil dioUtil;
  final LocalDataService localDataService;

  YouTubeService(this.dioUtil, this.localDataService);

  Future<List<YouTubeData>> searchByTag(
      {required int subjectId,
      required int maxResults,
      required int tagType}) async {
    pp('$mm searchByTag: subjectId: $subjectId');
    String url = ChatbotEnvironment.getSkunkUrl();
    String mUrl = '${url}searchVideosByTag';
    List<YouTubeData> youTubeDataList = [];
    var res = await dioUtil.sendGetRequest(path: mUrl, params: {
      'subjectId': subjectId,
      'maxResults': maxResults,
      'tagType': tagType
    });
    // Assuming the response data is a list of youTubeDataList

    List<dynamic> responseData = res.data;
    for (var linkData in responseData) {
      YouTubeData ytd = YouTubeData.fromJson(linkData);
      youTubeDataList.add(ytd);
    }

    pp("$mm YouTubeData found: ${youTubeDataList.length}, "
        "subjectId: $subjectId maxResults: $maxResults tagType: $tagType");
    if (youTubeDataList.isNotEmpty) {
      localDataService.addYouTubeData(youTubeDataList);
    }
    return youTubeDataList;
  }

/*
(@RequestParam("query") String query,
                                               @RequestParam("maxResults") Long maxResults,
                                               @RequestParam("subjectId") Long subjectId) throws Exception { */
  Future<List<YouTubeData>> searchByText(
      {required String query,
      required int subjectId,
      required int maxResults}) async {
    pp('$mm searchByText: subjectId: $subjectId');
    String url = ChatbotEnvironment.getSkunkUrl();
    String mUrl = '${url}searchVideos';
    List<YouTubeData> youTubeDataList = [];
    Response res = await dioUtil.sendGetRequest(path: mUrl, params: {
      'subjectId': subjectId,
      'maxResults': maxResults,
      'query': query
    });
    // Assuming the response data is a list of youTubeDataList

    List<dynamic> responseData = res.data;
    for (var linkData in responseData) {
      YouTubeData ytd = YouTubeData.fromJson(linkData);
      youTubeDataList.add(ytd);
    }

    pp("$mm YouTubeData found: ${youTubeDataList.length}, "
        "subjectId: $subjectId maxResults: $maxResults query: $query");
    if (youTubeDataList.isNotEmpty) {
      localDataService.addYouTubeData(youTubeDataList);
    }
    return youTubeDataList;
  }
}
