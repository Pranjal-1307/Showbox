import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:showbox/common/utils.dart';
import 'package:showbox/models/tv_series_model.dart';
import 'package:showbox/models/upcomingMovies.dart';
import 'package:showbox/screens/settings.dart';
import 'package:showbox/widgets/movie_card_widget.dart';
import 'package:showbox/service/api_services.dart';
import '../widgets/custom_carousel.dart';
import 'new_hot_screen.dart';
import 'search_screen.dart';

const String imageUrl = "https://image.tmdb.org/t/p/w500";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingFuture;
  late Future<UpcomingMovieModel> nowPlayingFuture;
  late Future<TvsSeriesModel> topRatedSeries;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final apiService = ApiServices();
    upcomingFuture = apiService.getUpcomingMovies();
    nowPlayingFuture = apiService.getNowPlayingMovies();
    topRatedSeries = apiService.getTopRatedSeries(); // Fetch top-rated TV series
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    MoreScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgorundColor,
        title: Image.asset(
          "assets/logo.png",
          height: 120,
          width: 140,
          alignment: Alignment.centerLeft,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                // Add search functionality
              },
              child: const Icon(
                Icons.notifications,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.blue, // Replace this with user profile image
              height: 27,
              width: 27,
              // Example for loading a user profile image
              // child: Image.asset("assets/profile.png", fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      backgroundColor: Colors.black, // Set background color to black
      body: Container(
        color: Colors.black, // Ensure the body background is also black
        child: _selectedIndex == 0
            ? SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top-Rated TV Series Carousel
                  FutureBuilder<TvsSeriesModel>(
                    future: topRatedSeries,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Failed to load top-rated TV series',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return CustomCarouselSlider(data: snapshot.data!);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Now Playing Movies Section
                  SizedBox(
                    height: 250,
                    child: FutureBuilder<UpcomingMovieModel>(
                      future: nowPlayingFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              'Failed to load now playing movies',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return MovieCardWidget(
                            future: nowPlayingFuture,
                            headLineText: 'Now Playing Movies',
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'No data available',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Upcoming Movies Section
                  SizedBox(
                    height: 250,
                    child: FutureBuilder<UpcomingMovieModel>(
                      future: upcomingFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              'Failed to load upcoming movies',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return MovieCardWidget(
                            future: upcomingFuture,
                            headLineText: 'Upcoming Movies',
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'No data available',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            : _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 35),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library_outlined, size: 35),
            label: 'New & Hot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 35),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black,
        elevation: 0,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}


