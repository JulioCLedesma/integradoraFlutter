import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviesgdl/models/movie.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Authentication methods
  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // ignore: avoid_print
      print('Error signing in: $e');
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
      // ignore: avoid_print
      print('Error registering user: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Firestore methods
  Future<void> addMovie(Movie movie) async {
    try {
      await _firestore.collection('movies').add(movie.toMap());
    } catch (e) {
      // ignore: avoid_print
      print('Error adding movie: $e');
      rethrow;
    }
  }

  Future<void> updateMovie(Movie movie) async {
    try {
      await _firestore.collection('movies').doc(movie.id).update(movie.toMap());
    } catch (e) {
      // ignore: avoid_print
      print('Error updating movie: $e');
      rethrow;
    }
  }

  Future<void> deleteMovie(String movieId) async {
    try {
      await _firestore.collection('movies').doc(movieId).delete();
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting movie: $e');
      rethrow;
    }
  }

  Stream<List<Movie>> getMoviesStream() {
    return _firestore.collection('movies').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Movie.fromSnapshot(doc)).toList();
    });
  }

  Future<DocumentSnapshot> getMovie(String movieId) {
    return _firestore.collection('movies').doc(movieId).get();
  }
}