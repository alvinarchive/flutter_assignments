import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewimage(
        latitude: lat, longitude: lng);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => MapScreen(
        isSelecting: true,
      ),
    ));

    print("ALVIN $selectedLocation");

    if (selectedLocation == null) {
      return;
    }

    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: Icon(Icons.location_on),
                textColor: Theme.of(context).primaryColor,
                label: const Text('Current Location')),
            FlatButton.icon(
                onPressed: _selectOnMap,
                icon: Icon(Icons.map),
                textColor: Theme.of(context).primaryColor,
                label: const Text('Select on Map'))
          ],
        )
      ],
    );
  }
}
