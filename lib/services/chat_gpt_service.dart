import 'package:dart_openai/dart_openai.dart';

import '../sgela_util/functions.dart';


class ChatGptService {
  static const String mx = '🍎 🍎 🍎 ChatGptService: ';

  //
  Future createSystemPrompts() async {}

  Future sendPrompt(String prompt) async {
    // The user message to be sent to the request.
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          prompt,
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );

    pp('$mx The request to be sent .... $prompt');
    final chatStream = OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: [
        userMessage,
      ],
      seed: 423,
      n: 2,
    );

// Listen to the stream.
    var sb = StringBuffer();

    // chatStream.listen(
    //       (streamChatCompletion) {
    //     final content = streamChatCompletion.choices.first.delta.content;
    //     content?.forEach((c) {
    //       if (c.text != null) {
    //         sb.write(c.text!);
    //       }
    //     });
    //   },
    //   onDone: () {
    //     pp("\n\n$mx ............. we are done!");
    //     pp('$mx ${sb.toString()}');
    //   },
    // );
  }
  Future sendCompletion(String prompt) async {
    try {
      pp('$mx ... baseUrl: 🔵🔵 ${OpenAI.baseUrl}');
      OpenAICompletionModel completion =
          await OpenAI.instance.completion.create(
        model: "gpt-3.5-turbo",
        prompt: prompt,
        maxTokens: 20,
        temperature: 0.5,
        n: 1,
        stop: ["\n"],
        echo: true,
        seed: 42,
        bestOf: 2,
      );
      for (var choice in completion.choices) {
        pp('$mx finishReason: ${choice.finishReason} 🍎🍎🍎 text: ${choice.text}');
      }

      pp('$mx systemFingerprint: 🥦🥦 ${completion.systemFingerprint}'); // ...
      pp('$mx completion id: 🥦🥦 ${completion.id}'); // ...
    } catch (e) {
      pp('$mx ERROR: $e');
    }
  }

  Future printModels() async {
    List<OpenAIModelModel> models = await OpenAI.instance.model.list();
    for (var model in models) {
      pp('$mx model id: ${model.id} 🍎 owner: ${model.ownedBy} 🍎permission: ${model.havePermission}');
    }
  }
}
