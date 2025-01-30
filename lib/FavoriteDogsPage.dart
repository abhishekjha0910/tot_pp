import 'package:flutter/material.dart';
import 'dogii.dart';

class FavoriteDogsPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteDogs;

  const FavoriteDogsPage({
    Key? key,
    required this.favoriteDogs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Dogs"),
        backgroundColor: Colors.teal,
      ),
      body: favoriteDogs.isEmpty
          ? Center(
        child: Text(
          "No favorite dogs yet!",
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
      )
          : ListView.builder(
        itemCount: favoriteDogs.length,
        itemBuilder: (context, index) {
          final favoriteDog = favoriteDogs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Dogii(
                    dogName: favoriteDog['name'],
                    dogAge: favoriteDog['dog']['age'] ?? 0, // Ensure age is passed
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                title: Text(
                  favoriteDog['name'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Breed: ${favoriteDog['dog']['breed_group'] ?? 'Unknown'}'),
                trailing: Icon(Icons.favorite, color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }
}
