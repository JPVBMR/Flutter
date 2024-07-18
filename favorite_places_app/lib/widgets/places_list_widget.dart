import 'package:favorite_places_app/models/place_model.dart';
import 'package:favorite_places_app/screens/place_details_screen.dart';
import 'package:flutter/material.dart';

class PlacesListWidget extends StatelessWidget {
  const PlacesListWidget({
    super.key,
    required this.lstPlaces,
  });

  final List<PlaceModel> lstPlaces;

  @override
  Widget build(BuildContext context) {
    if (lstPlaces.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: lstPlaces.length,
      itemBuilder: (ctx, index) => ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PlaceDetailsScreen(
                placeRecord: lstPlaces[index],
              ),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(lstPlaces[index].imageFile),
        ),
        title: Text(
          lstPlaces[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
