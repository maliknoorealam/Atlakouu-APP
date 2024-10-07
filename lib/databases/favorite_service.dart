import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Add an expert to favorites
  Future<void> addFavorite(String userId, String expertId) async {
    await _fireStore.collection('Favorites').add({
      'userID': userId,
      'expertID': expertId,
    });
  }

  // Remove an expert from favorites
  Future<void> removeFavorite(String userId, String expertId) async {
    QuerySnapshot query = await _fireStore
        .collection('Favorites')
        .where('userID', isEqualTo: userId)
        .where('expertID', isEqualTo: expertId)
        .get();

    if (query.docs.isNotEmpty) {
      await query.docs.first.reference.delete();
    }
  }

  // Check if an expert is already favorited
  Future<bool> isFavorite(String userId, String expertId) async {
    QuerySnapshot query = await _fireStore
        .collection('Favorites')
        .where('userID', isEqualTo: userId)
        .where('expertID', isEqualTo: expertId)
        .get();

    return query.docs.isNotEmpty;
  }

  // Fetch all favorite experts for a user
  Future<List<String>> fetchFavorites(String userId) async {
    QuerySnapshot query = await _fireStore
        .collection('Favorites')
        .where('userID', isEqualTo: userId)
        .get();

    return query.docs.map((doc) => doc['expertID'] as String).toList();
  }
}
