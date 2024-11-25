import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; //
import '../models/movie.dart';


class FirebaseService extends ChangeNotifier { // Extiende ChangeNotifier
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


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
    notifyListeners(); // <--- Agregar aquí
  }

  Future<void> addMovie(Movie movie) async {
    await _firestore.collection('movies').add({
      'title': movie.title,
      'year': movie.year,
      'director': movie.director,
      'genre': movie.genre,
      'synopsis': movie.synopsis,
      'imageUrl': movie.imageUrl,
    });
  }

  Future<void> updateMovie(Movie movie) async {
    try {
      await _firestore.collection('movies').doc(movie.id).update(movie.toMap());
      notifyListeners(); 
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMovie(String movieId) async {
    try {
      await _firestore.collection('movies').doc(movieId).delete();
      notifyListeners(); // <--- Agregar aquí
    } catch (e) {
      rethrow;
    }
  }


  //  No necesitas notifyListeners() en getMoviesStream() porque es un Stream
  //  y ya notifica automáticamente a los listeners cuando hay nuevos datos
  Stream<List<Movie>> getMoviesStream() { 
    return _firestore.collection('movies').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Movie.fromSnapshot(doc)).toList();
    });
  }


  //  No necesitas notifyListeners() para getMovie() si solo se usa para
  // obtener una unica película y no se actualiza la lista en la UI directamente.
  Future<DocumentSnapshot> getMovie(String movieId) {
    return _firestore.collection('movies').doc(movieId).get();
  }
}