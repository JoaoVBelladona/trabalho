import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class LoginService {

        static criarUsuario(String email, String senha) async {
        return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha);  
    }

        static loginUsuario(String email, String senha) async {
        return FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha);
    }

        static sairUsuario() async {
        return FirebaseAuth.instance.signOut();
    }

    static User? get getUsuarioAtual =>
        FirebaseAuth.instance.currentUser;
    

    static Stream<User?> get sessaousuario => 
        FirebaseAuth.instance.authStateChanges();
        
}