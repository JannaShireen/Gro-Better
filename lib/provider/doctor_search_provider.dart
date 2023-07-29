import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorSearchProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot<Object?>> _searchResults = [];

  List<QueryDocumentSnapshot<Object?>> get searchResults => _searchResults;

  Future<void> searchDoctors(String query) async {
    try {
      QuerySnapshot<Object?> snapshot =
          await FirebaseFirestore.instance.collection('Experts').get();
      // Fetch all names from the 'Expert' collection
      List<dynamic> expertNames =
          snapshot.docs.map((doc) => doc['Name']).toList();

      // Convert the query to lowercase for case-insensitive matching
      String lowercaseQuery = query.toLowerCase();

      // Search for the query in the list of expert names
      List<QueryDocumentSnapshot<Object?>> matchingDocs = snapshot.docs
          .where((doc) =>
              doc['Name'].toString().toLowerCase().contains(lowercaseQuery))
          .toList();

      // Update the search results with the matching documents
      _searchResults = matchingDocs;

      // Notify listeners about the updated search results
      notifyListeners();

      print("Matching doctors: $matchingDocs");
    } catch (e) {
      print('error $e');
    }
  }
}
