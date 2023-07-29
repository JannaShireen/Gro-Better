import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gro_better/model/experts.dart';
import 'package:gro_better/provider/doctor_search_provider.dart';
import 'package:gro_better/screens/experts/widgets/doctor_profile.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

class DoctorSearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  DoctorSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for Expert'),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              cursorColor: Colors.black,
              controller: _searchController,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                labelText: 'Search for doctors',
                labelStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Step 3: Access the DoctorSearchProvider instance and call the searchDoctors method
                    final provider = Provider.of<DoctorSearchProvider>(context,
                        listen: false);
                    provider.searchDoctors(_searchController.text.trim());
                    debugPrint(
                        'Search doctors called with query: ${_searchController.text.trim()}');
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
    );
  }

  Widget _buildSearchResults() {
    // Step 2: Use the Consumer widget to listen for changes in DoctorSearchProvider
    return Consumer<DoctorSearchProvider>(builder: (context, provider, _) {
      if (_searchController.text.trim().isEmpty) {
        // Show an empty container if no search query is entered yet
        return Container();
      } else if (provider.searchResults == null) {
        // Show a loading indicator while searching
        return const Center(child: CircularProgressIndicator());
      } else if (provider.searchResults.isEmpty) {
        // Show "No doctors found" if the search query returns no results
        return const Center(
            child: Text(
          'No doctors found',
          style: textStyle2,
        ));
      } else {
        final List<ExpertInfo> experts = provider.searchResults
            .map((doc) => ExpertInfo.fromSnap(doc))
            .toList();
        // Show the search results if there are matching doctors
        return ListView.builder(
            itemCount: experts.length,
            itemBuilder: (context, index) {
              final expert = experts[index];
              // DocumentSnapshot doctor = provider.searchResults[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorProfile(
                              expert: expert,
                            )),
                  );
                },
                child: Container(
                  width: 180,
                  height: 160,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(12),
                  child: Card(
                    color: const Color.fromARGB(255, 194, 246, 217),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          width: 70,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border:
                                  Border.all(color: Colors.green, width: 1.5)),
                          child: Image.network(
                            expert.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          expert.name,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 7, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                        subtitle: Text(
                          expert.category,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 18, 11, 11)),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      }
    });
  }
}
