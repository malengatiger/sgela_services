import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mistral_sgela_ai/mistral_sgela_ai.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get_it/get_it.dart';
import 'package:sgela_services/services/mistral_client_service.dart';
import 'package:sgela_services/sgela_util/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../repositories/basic_repository.dart';
import '../services/accounting_service.dart';
import '../services/agriculture_service.dart';
import '../services/auth_service.dart';
import '../services/busy_stream_service.dart';
import '../services/chat_gpt_service.dart';
import '../services/conversion_service.dart';
import '../services/firestore_service.dart';
import '../services/gemini_chat_service.dart';
import '../services/local_data_service.dart';
import '../services/math_service.dart';
import '../services/physics_service.dart';
import '../services/skunk_service.dart';
import '../services/you_tube_service.dart';
import 'dark_light_control.dart';
import 'dio_util.dart' as di;
import 'environment.dart';
import 'functions.dart';

Future<void> registerServices(FirebaseFirestore firebaseFirestore, FirebaseAuth firebaseAuth, Gemini gemini) async {
  const mm  = '🍎🍎🍎🍎🍎🍎RegisterServices';
  pp('$mm registerServices: initialize service singletons with GetIt .... 🍎🍎🍎');

  var lds = LocalDataService();
  await lds.init();
  Dio dio = Dio();
  var dioUtil = di.DioUtil(dio, lds);
  var repository = BasicRepository(dioUtil, lds, dio);
  var prefs = Prefs(await SharedPreferences.getInstance());
  var dlc = DarkLightControl(prefs);
  var cWatcher = ColorWatcher(dlc, prefs);

  var mistralService = MistralService(ChatbotEnvironment.getMistralAPIKey());
  GetIt.instance.registerLazySingleton<MistralServiceClient>(
          () => MistralServiceClient(mistralService));
  pp('$mm ... MistralServiceClient registered lazy! key: ${ChatbotEnvironment.getMistralAPIKey()}');
  GetIt.instance.registerLazySingleton<BusyStreamService>(
          () => BusyStreamService());
  GetIt.instance.registerLazySingleton<MathService>(() => MathService());
  GetIt.instance.registerLazySingleton<GeminiChatService>(() => GeminiChatService(dioUtil));
  GetIt.instance
      .registerLazySingleton<AgricultureService>(() => AgricultureService());
  GetIt.instance.registerLazySingleton<PhysicsService>(() => PhysicsService());
  GetIt.instance
      .registerLazySingleton<BasicRepository>(() => repository);
  GetIt.instance
      .registerLazySingleton<AccountingService>(() => AccountingService());
  GetIt.instance.registerLazySingleton<LocalDataService>(() => lds);
  GetIt.instance.registerLazySingleton<YouTubeService>(
          () => YouTubeService(dioUtil, lds));

  GetIt.instance.registerLazySingleton<Prefs>(
          () => prefs);
  GetIt.instance.registerLazySingleton<ColorWatcher>(
          () => cWatcher);
  GetIt.instance.registerLazySingleton<DarkLightControl>(
          () => dlc);
  GetIt.instance.registerLazySingleton<Gemini>(
          () => gemini);
  GetIt.instance.registerLazySingleton<ChatGptService>(
          () => ChatGptService());
  GetIt.instance.registerLazySingleton<di.DioUtil>(
          () => dioUtil);
  //
  // var app = await Firebase.initializeApp(
  //   name: ChatbotEnvironment.getFirebaseName(),
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  var firestoreService = FirestoreService(prefs,
      cWatcher, FirebaseFirestore.instance, lds);
  var country =await firestoreService.getLocalCountry();
  if (country != null) {
    pp('$mm local country: ${country.toJson()}');
  }

  GetIt.instance.registerLazySingleton<FirestoreService>(
          () => firestoreService);

  GetIt.instance.registerLazySingleton<AuthService>(() => AuthService(
      firebaseAuth, prefs, firestoreService));
  GetIt.instance.registerLazySingleton<SkunkService>(() => SkunkService(dioUtil,lds));
  GetIt.instance.registerLazySingleton<ConversionService>(() => ConversionService(dioUtil));

  pp('$mm : GetIt has registered 18 services.  🔵🔵 Cool!! 🍎🍎🍎');

  try {
    mistralService.listModels(debug: true);
  } catch (e,s) {
    pp('$mm ERROR: $e - $s');
  }

}