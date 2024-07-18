import 'package:favorite_places_app/providers/user_places_notifier.dart';
import 'package:favorite_places_app/screens/new_place_screen.dart';
import 'package:favorite_places_app/widgets/places_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lstUserPalces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Places'),
        actions: [
          /* NEW PLACE ACTION -> Opens NewPlaceScreen */
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const NewPlaceScreen(),
              ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlacesListWidget(
          lstPlaces: lstUserPalces,
        ),
      ),
    );
  }
}
