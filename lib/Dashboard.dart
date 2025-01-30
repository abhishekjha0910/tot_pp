import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'DogDetailsPage.dart';
import 'FavoriteDogsPage.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<dynamic> dogs = []; // List to store fetched dog data
  List<dynamic> filteredDogs = []; // List to store filtered data
  List<Map<String, dynamic>> favoriteDogs = []; // List of favorite dogs
  String searchQuery = ""; // Query for search
  bool isSearchActive = false; // To track if the search bar is active
  bool isLoading = true; // Loading state
  String errorMessage = ""; // Error message if fetch fails

  // Function to fetch all dogs data
  Future<void> fetchDogs() async {
    try {
      final response = await http.get(Uri.parse('https://freetestapi.com/api/v1/dogs'));
      if (response.statusCode == 200) {
        setState(() {
          dogs = json.decode(response.body);
          isLoading = false;
          errorMessage = "";
        });
      } else {
        throw Exception("Failed to load dogs data. Status: \${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Unable to fetch data. Please check your connection.";
      });
    }
  }

  // Function to search dogs by query
  void searchDogs(String query) {
    setState(() {
      searchQuery = query;
      filteredDogs = dogs
          .where((dog) => dog['name']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();
    });
  }

  // Function to add a dog to favorites
  void _addToFavorites(dynamic dog, String dogName) {
    setState(() {
      favoriteDogs.add({'name': dogName, 'dog': dog});
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDogs(); // Fetch dogs data on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteDogsPage(favoriteDogs: favoriteDogs),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main content of the dashboard
          Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 16.0, right: 16.0),
            child: Column(
              children: [
                if (isLoading) ...[
                  Center(child: CircularProgressIndicator()),
                ] else if (errorMessage.isNotEmpty) ...[
                  Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(fontSize: 18, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: isSearchActive
                        ? (filteredDogs.isEmpty
                        ? Center(
                      child: Text(
                        searchQuery.isEmpty
                            ? 'Start typing to search for dogs...'
                            : 'No results found!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemCount: filteredDogs.length,
                      itemBuilder: (context, index) {
                        final dog = filteredDogs[index];
                        return ListTile(
                          leading: dog['image'] != null
                              ? Image.network(dog['image'], width: 50, height: 50)
                              : Icon(Icons.pets, size: 50, color: Colors.grey),
                          title: Text(dog['name'] ?? 'Unknown Name'),
                          subtitle: Text(dog['breed_group'] ?? 'Unknown Breed'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DogDetailPage(
                                  dog: dog,
                                  onAddFavorite: (dog, dogName) {
                                    _addToFavorites(dog, dogName);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ))
                        : Center(
                      child: Text(
                        'Search for a dog or click the favorite icon to view favorites!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),

          // Search Bar (At the top of the screen)
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Search Icon
                  Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                  ),
                  // Search Bar
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        onTap: () {
                          setState(() {
                            isSearchActive = true; // Activate search
                          });
                        },
                        onChanged: searchDogs, // Call search function on change
                        decoration: InputDecoration(
                          hintText: 'Search by name...',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  // Close Icon (Reset Search)
                  if (isSearchActive)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          searchQuery = ""; // Clear search query
                          filteredDogs = []; // Clear filtered list
                          isSearchActive = false; // Deactivate search
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
