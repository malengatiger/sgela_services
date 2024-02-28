import 'package:dart_mistral_api/dart_mistral_api.dart';

class MistralClientService {
  final MistralService mistralService;

  MistralClientService(this.mistralService);

  Future<List<MistralModel>> getModels(
      {required String apiKey, bool? debug}) async {
    List<MistralModel> models = [];
    models = await mistralService.listModels(debug: debug);
    return models;
  }

  Future<MistralResponse?> sendRequest(
      MistralRequest request, bool? debug) async {
    MistralResponse? response;
    response = await mistralService.sendMistralRequest(
        mistralRequest: request, debug: debug);
    return response;
  }

  Future<MistralEmbeddingResponse?> sendEmbeddingRequest(
      MistralEmbeddingRequest request, bool? debug) async {
    MistralEmbeddingResponse? response;
    response = await mistralService.sendEmbeddingRequest(
        embeddingRequest: request, debug: debug);
    return response;
  }
}
