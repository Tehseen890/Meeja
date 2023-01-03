import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 40.0;
  @override
  Widget build(BuildContext context) {
    return SfSlider(
        min: 0.0,
        max: 100.0,
        value: _value,
        interval: 20,
        showTicks: true,
        showLabels: true,
        enableTooltip: true,
        minorTicksPerInterval: 1,
        onChanged: (dynamic value) {
          setState(() {
            _value = value;
          });
        });
  }
}
