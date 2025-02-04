import 'package:flutter/material.dart';
import 'package:memora_app/features/album/presentation/album_description.dart';
import 'package:memora_app/features/album/presentation/pages/cover_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlbumOverview extends StatefulWidget {
  const AlbumOverview({super.key});

  @override
  State<AlbumOverview> createState() => _AlbumOverviewState();
}

class _AlbumOverviewState extends State<AlbumOverview> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("albums").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Quelque chose s\'est mal passé');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          // TODO: Ajouter un "Créer votre premier album"
          return Text('Aucun albums pour le moment');
        }

        List<dynamic> albums = [];
        for (var element in snapshot.data!.docs) {
          albums.add(element);
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 644,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final title = albums[index]['title'];
                final backgroundImage = albums[index]['background_image'];
                final dateStart = albums[index]['date_start'];
                final dateEnd = albums[index]['date_end'];
                // final members = albums[index]['members'];

                return Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CoverPage(
                        title: title,
                        backgroundImage: backgroundImage,
                        dateStart: dateStart,
                        dateEnd: dateEnd,
                        // members: members,
                      ),
                      SizedBox(height: 24),
                      AlbumDescription(),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
