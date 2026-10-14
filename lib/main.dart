//14

import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';

import 'core/app_routes.dart';
import 'core/dependencias.dart';
import 'view/cadastrar_usuario_view.dart';
import 'view/login_view.dart';
import 'view/perfil_view.dart';
import 'view/recuperar_senha_view.dart';
import 'view/sobre_view.dart';
import 'view/home_view.dart';
import 'view/cadastrar_veiculo_view.dart';
import 'view/historico_view.dart';
import 'view/monitoramento_view.dart';
import 'view/cadastrar_manutencao_view.dart';

class AppColors {
  static const primary = Color(0xFFBBDDFF);
  static const secondary = Color(0xFFFFFFFF);
  static const accent = Color(0xFF1976D2); // destaques: foco, botões, loading
}

void main(){
  configurarDependencias();

  runApp(
    DevicePreview(
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.cadastrarUsuario: (context) => const CadastrarUsuarioView(),
        AppRoutes.login: (context) => const LoginView(),
        AppRoutes.perfil: (context) => const PerfilView(),
        AppRoutes.recuperarSenha: (context) => const RecuperarSenhaView(),
        AppRoutes.sobre: (context) => const SobreView(),
        AppRoutes.home: (context) => const HomeView(),
        AppRoutes.cadastrarVeiculo: (context) => const CadastrarVeiculoView(),
        AppRoutes.historico: (context) => const HistoricoView(),
        AppRoutes.monitoramento: (context) => const MonitoramentoView(),
        AppRoutes.cadastrarManutencao: (context) => const CadastrarManutencaoView(),
      },

      // suas rotas / initialRoute aqui
      home: const HomeView(),

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.secondary,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.accent,
          surface: AppColors.secondary,
          onSurface: Colors.black, // texto e ícones pretos por padrão
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black, // título e ícones (menu/drawer) pretos
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: true,
          elevation: 0,
        ),

        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.primary,
          surfaceTintColor: Colors.transparent,
        ),

        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
          textColor: Colors.black,
        ),

        cardTheme: const CardThemeData( // CardTheme se o Flutter for < 3.27
          color: AppColors.primary,
          surfaceTintColor: Colors.transparent,
          elevation: 2,
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.black,
          ),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.accent, width: 2),
          ),
          floatingLabelStyle: TextStyle(color: AppColors.accent),
        ),

        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.accent,
        ),
      ),

      
    );
  }
}