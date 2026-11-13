import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalhodisp/firebase_options.dart';
import 'package:trabalhodisp/pages/cadastro_page.dart';
import 'package:trabalhodisp/pages/principal_page.dart';
import 'package:trabalhodisp/services/loginService.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}

final emailController = TextEditingController();
final passwordController = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  showMensagem(String msg, {bool error = true} ){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
         content: Text(msg), 
         backgroundColor: error ?  Colors.red : Colors.green
         )
     );
  }

  entrar() async {
    try{
      await LoginService.loginUsuario(emailController.text, passwordController.text);
      showMensagem('Login realizado com sucesso', error: false);
      print('Login realizado com sucesso');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          showMensagem('Email invalido');
          break;
        case 'user-not-found':
          showMensagem('Usuario não encontrado');
          break;
        case 'wrong-password':
          showMensagem('Senha incorreta');
          break;
        default:
          print('Email: ${emailController.text}');
          print('Senha: ${passwordController.text}');
          print('Erro desconhecido: ${e.message}');
          showMensagem(e.message ?? 'Erro desconhecido');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
            ),
            height: 500,
            width: 600,
            padding: const EdgeInsets.all(16.0),
            child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.email),
                                  labelText: 'Email',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
                                ),
                              ),

                              const SizedBox(height: 30.0),
                              TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.lock),
                                  labelText: 'Senha',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
                                ),
                                obscureText: true,
                              ),

                              Row(
                                children: [
                                  SizedBox(width: 50.0),
                                  TextButton(
                                    onPressed: () {
                                      print('Botão de cadastro pressionado');
                                      
                                           Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => const CadastroPage())
                                          );
                                    },
                                    child: const Text('Não possui conta? Cadastre-se'),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 70.0),

                              ElevatedButton(
                                onPressed: () async {
                                  try{
                                    await entrar();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) => const PrincipalPage())
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    showMensagem('Erro ao realizar login: ${e.message}');
                                  }
                                },
                                child: const Text('Entrar') 
                              ),
                            ],
                          )),
          ),
        ),
      );
  }
}
