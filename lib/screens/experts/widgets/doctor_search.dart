import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/shared/constants.dart';

class DoctorSearchPage extends StatefulWidget {
  const DoctorSearchPage({super.key});

  @override
  _DoctorSearchPageState createState() => _DoctorSearchPageState();
}

class _DoctorSearchPageState extends State<DoctorSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  QuerySnapshot? _searchResults;

  void _searchDoctors(String query) async {
    if (query.isNotEmpty) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Experts')
          .where('name', isEqualTo: query)
          .get();

      setState(() {
        _searchResults = snapshot;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for Expert'),
        backgroundColor: kBackgroundColor,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: gradientColor),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search doctors',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _searchDoctors(_searchController.text.trim());
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults == null) {
      return const Center(child: Text('No results'));
    }

    if (_searchResults!.docs.isEmpty) {
      return const Center(child: Text('No doctors found'));
    }

    return ListView.builder(
      itemCount: _searchResults!.docs.length,
      itemBuilder: (context, index) {
        DocumentSnapshot doctor = _searchResults!.docs[index];
        return ListTile(
          title: Text(doctor['name']),
          subtitle: Text(doctor['category']),
        );
      },
    );
  }
}
