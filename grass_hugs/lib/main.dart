import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grass_hugs/firebase/auth/controller/auth_controller.dart';
import 'package:grass_hugs/models/user_model.dart';
import 'package:grass_hugs/screens/home/home.dart';
import 'package:grass_hugs/screens/onboarding/get_started.dart';
import 'package:grass_hugs/theme/app_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  Widget route(data) {
    if (data != null) {
      getData(ref, data);
      if (userModel != null) {
        return const HomePage();
      }
    }
    return const GetStarted();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp(
            title: "QuizCraft",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            home: route(data),
          ),
          error: (error, stackTrace) => const Text("Error"),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
