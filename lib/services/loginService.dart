import 'package:firebase_auth/firebase_auth.dart';

class LoginService {

         criarUsuario(String nome, String email, String senha) {
        return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha);
    }

        loginUsuario(String email, String senha) async {
        return FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha);
    }

    Future<void> sairUsuario() async {
        return FirebaseAuth.instance.signOut();
    }

    static User? get getUsuarioAtual =>
        FirebaseAuth.instance.currentUser;
    

    static Stream<User?> get sessaousuario => 
        FirebaseAuth.instance.authStateChanges();
        
}