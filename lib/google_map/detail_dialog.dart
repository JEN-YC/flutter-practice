import 'package:flutter/material.dart';

Future<void> asyncDialog(BuildContext context, int adultMask, int childMask,
    String phone, String updateTime) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return MaskDetailWidget(
        adultMask: adultMask,
        childMask: childMask,
        phone: phone,
        updateTime: updateTime,
      );
    },
  );
}

class MaskDetailWidget extends StatelessWidget {
  final int adultMask;
  final int childMask;
  final String phone;
  final String updateTime;

  MaskDetailWidget(
      {this.adultMask, this.childMask, this.phone, this.updateTime});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Card(
          color: Colors.brown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    'Phone: $phone',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
              ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Remaining number of adult masks : $adultMask',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  )),
              ListTile(
                  leading: Icon(Icons.child_friendly),
                  title: Text(
                    'Remaining number of child masks : $childMask',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}