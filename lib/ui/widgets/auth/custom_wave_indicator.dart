import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../helper/utils.dart';

class CustomWaveIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Utils.linearGradient,
      ),
      child: SpinKitWave(
        color: Colors.white,
        size: 50,
      ),
    );
  }
}


