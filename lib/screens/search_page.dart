import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> allItems = [
    'Phantom',
    'Miracullors',
    'Munjya',
    'Squid Game',
    'Never Have I Ever',
    'Main Tera Hero',
    'Ashqui 2',
    'Stree',
    'Stree 2',
    'Bhediya',
  ];

  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    filteredItems = allItems; // Initially show all items
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      // Filter items based on the search query
      filteredItems = allItems
          .where((item) =>
          item.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18),
          cursorColor: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white, size: 30),
            onPressed: () {
              _searchController.clear(); // Clear the search input
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(10.0),
        child: filteredItems.isEmpty
            ? const Center(
          child: Text(
            'No results found',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
            : ListView.builder(
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                filteredItems[index],
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle item tap if needed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${filteredItems[index]}'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
