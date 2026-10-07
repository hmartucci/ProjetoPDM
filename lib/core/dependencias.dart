//13

import 'package:get_it/get_it.dart';
import 'package:p1/controller/cadastrar_usuario_controller.dart';
import 'package:p1/controller/login_controller.dart';
import 'package:p1/controller/perfil_controller.dart';
import 'package:p1/controller/recuperar_senha_controller.dart';
import 'package:p1/controller/sobre_controller.dart';

final g = GetIt.instance;

void configurarDependencias(){
  g.registerSingleton<CadastrarUsuarioController>(CadastrarUsuarioController());
  g.registerSingleton<LoginController>(LoginController());
  g.registerSingleton<PerfilController>(PerfilController());
  g.registerSingleton<RecuperarSenhaController>(RecuperarSenhaController());
  g.registerSingleton<SobreController>(SobreController());
}

