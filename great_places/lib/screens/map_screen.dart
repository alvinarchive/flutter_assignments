import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: -6.1205, longitude: 106.7538),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Map'),
          actions: [
            if (widget.isSelecting)
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    Navigator.of(context).pop(_pickedLocation);
                  })
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initialLocation.latitude,
              widget.initialLocation.longitude,
            ),
            zoom: 16,
          ),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: _pickedLocation == null && widget.isSelecting
              ? {}
              : {
                  Marker(
                      markerId: MarkerId('m1'),
                      position: _pickedLocation ??
                          LatLng(widget.initialLocation.latitude,
                              widget.initialLocation.longitude)),
                },
        ));
  }
}
