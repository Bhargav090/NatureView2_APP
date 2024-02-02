import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:natureview2/screens/fav_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  late List<String> natureImageUrls;
  List<String> favoriteImages = [];

  @override
  void initState() {
    super.initState();
    natureImageUrls = [];
    fetchImages();
    fetchFavorites();
  }

  Future<void> fetchImages() async {
    try {
      final ListResult result =
          await FirebaseStorage.instance.ref().list();
      final List<String> urls =
          await Future.wait(result.items.map((e) => e.getDownloadURL()));
      setState(() {
        natureImageUrls = urls;
      });
    } catch (error) {
      print('Error during fetchImages: $error');
    }
  }

  Future<void> fetchFavorites() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final favoritesSnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(user!.uid)
          .get();

      if (favoritesSnapshot.exists) {
        final List<dynamic> favorites = favoritesSnapshot.data()?['images'] ?? [];
        setState(() {
          favoriteImages = List<String>.from(favorites);
        });
      }
    } catch (error) {
      print('Error during fetchFavorites: $error');
    }
  }

  Future<void> toggleFavorite(String imageUrl) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final favoritesRef =
          FirebaseFirestore.instance.collection('favorites').doc(user!.uid);

      setState(() {
        if (favoriteImages.contains(imageUrl)) {
          favoriteImages.remove(imageUrl);
        } else {
          favoriteImages.add(imageUrl);
        }
      });

      await favoritesRef.update({'images': FieldValue.arrayUnion(favoriteImages)});
    } catch (error) {
      print('Error during toggleFavorite: $error');
    }
  }

  Future<void> downloadImage(String imageUrl) async {
    try {
      final imageBytes = await FirebaseStorage.instance
          .refFromURL(imageUrl)
          .getData();

      final filePath = '/storage/emulated/0/Download/nature_image.jpg';
      await File(filePath).writeAsBytes(imageBytes!);

      print('Image downloaded successfully: $filePath');
    } catch (error) {
      print('Error during downloadImage: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'NatureView2',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.065,
            color: const Color(0xFF3396B4),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: const Color.fromARGB(255, 66, 66, 66),
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.email?.split('@').first ?? '',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: const Color(0xFF3396B4),
                    fontWeight:  FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: natureImageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = natureImageUrls[index];
          final isFavorite = favoriteImages.contains(imageUrl);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: MediaQuery.of(context).size.width * 0.005,
                            blurRadius: MediaQuery.of(context).size.width * 0.01,
                            offset: Offset(0, MediaQuery.of(context).size.width * 0.015),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.76,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: MediaQuery.of(context).size.width * 0.12,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                          onPressed: () {
                            toggleFavorite(imageUrl);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.download,
                            size: MediaQuery.of(context).size.width * 0.12,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            downloadImage(imageUrl);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_rounded, color:Colors.red),
            Text('Fav')
          ],
        ),
        onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavScreen(
                favImages: favoriteImages,
              ),
            ));
      }),
      // bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
