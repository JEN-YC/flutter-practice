import 'package:flutter_app/mask/mask_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_app/mask/model/mask_list.dart';

import 'detail_dialog.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController controller;
  MaskBloc maskBloc;
  LatLng initPosition = LatLng(25.0481529, 121.5136145);
  String choseCity = "臺北市";
  List<String> cityList = <String>[
    '臺北市',
    '新北市',
    '基隆市',
    '桃園市',
    '新竹市',
    '台中市',
    '高雄市',
    '宜蘭縣'
  ];
  @override
  void initState() {
    maskBloc = new MaskBloc();
    maskBloc.add(FetchMaskDataEvent("臺北市"));
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    _getCurrentPosition();
  }

  void _getCurrentPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 15)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<MaskBloc, MaskState>(
      cubit: maskBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingMaskState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetMaskState) {
          Set<Marker> markers = new Set();
          for (int i = 0; i < state.maskList.results.length; i++) {
            Mask data = state.maskList.results[i];
            Marker m = Marker(
              markerId: MarkerId(data.id),
              position: LatLng(
                data.latitude,
                data.longitude,
              ),
              infoWindow: InfoWindow(
                  title: data.name,
                  snippet: data.address,
                  onTap: () => _onTapInfoWindows(data)),
            );
            if (m != null) markers.add(m);
          }
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: choseCity,
                      icon: Icon(Icons.location_city),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                      onChanged: (String newValue) {
                        maskBloc.add(FetchMaskDataEvent(newValue));
                        setState(() {
                          choseCity = newValue;
                        });
                      },
                      items: cityList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    IconButton(
                      icon: Icon(Icons.my_location),
                      onPressed: () => _getCurrentPosition(),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: initPosition, zoom: 15),
                markers: markers,
                onMapCreated: _onMapCreated,
              ))
            ],
          );
        } else {
          return Center(
            child: Text('Faild load data'),
          );
        }
      },
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTapInfoWindows(Mask data) async {
    await asyncDialog(
        context, data.adultMask, data.childMask, data.phone, data.updateTime);
  }
}
