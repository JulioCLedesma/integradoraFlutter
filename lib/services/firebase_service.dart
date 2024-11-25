import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; //
import '../models/movie.dart';


class FirebaseService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Stream<User?> get userStream => _auth.authStateChanges();

  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {

      rethrow;
    }
  }


  Future<UserCredential> register(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

   Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

    Future<void> addMovie(Movie movie) async {
    await _firestore.collection('movies').add(movie.toMap());
  }


  Stream<List<Movie>> getMoviesStream() {
    return _firestore.collection('movies').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Movie.fromSnapshot(doc)).toList());
  }

  Future<void> deleteMovie(String movieId) async {
    await _firestore.collection('movies').doc(movieId).delete();
  }
}