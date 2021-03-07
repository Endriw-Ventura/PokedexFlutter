import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class OpacityControl extends StatefulWidget {
  @override
  createState() => OpacityControlState();
}

class OpacityControlState extends State<OpacityControl> {
  double opacityLevel = 1.0;

  get snappings => SnapSpec.footerSnap;

  _changeOpacity() {
    if (SnapSpec.footerSnap == 0.60)
      setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacityLevel,
      duration: Duration(seconds: 1),
      child: SlidingSheet(
        elevation: 0,
        cornerRadius: 30,
        snapSpec: SnapSpec(
          onSnap: _changeOpacity(),
          snap: true,
          snappings: [0.55, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
          );
        },
      ),
    );
  }
}
