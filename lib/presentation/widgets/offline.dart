import 'package:flutter/material.dart';

class BuildNoInterntWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Check your Internet please ...',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400),),
          Image.asset('assets/images/offline.png'),
        ],
      ),
    );
  }
}


