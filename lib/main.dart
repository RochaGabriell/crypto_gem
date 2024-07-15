import 'package:crypto_gem/domain/services/coins.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:crypto_gem/routes/router.dart';
import 'package:crypto_gem/configs/http.dart';
import 'package:crypto_gem/theme/theme.dart';

import 'package:crypto_gem/domain/repositories/coins.dart';
import 'package:crypto_gem/domain/stores/coins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = HttpService().dio;

    return ChangeNotifierProvider(
      create: (_) => CoinsStore(CoinsRepository(CoinsService(dio))),
      child: MaterialApp(
        // App
        title: 'CryptoGem',
        theme: AppTheme.darkThemeMode,
        debugShowCheckedModeBanner: false,
        // Routes
        onGenerateRoute: browserRoute,
        initialRoute: '/',
        // Internationalization
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
      ),
    );
  }
}
