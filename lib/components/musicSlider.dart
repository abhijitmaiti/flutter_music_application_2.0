import 'package:flutter/material.dart';

class musicSlider extends StatefulWidget {
  @override
  _musicSliderState createState() => _musicSliderState();
}

class _musicSliderState extends State<musicSlider> {
  double _value = 0.0;
  void _onSliderChanged(double value) {
    setState(() {
      _value = value;
    });
    // Perform any additional actions based on the slider value
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Color.fromARGB(255, 204, 200, 200),
      inactiveColor: Color.fromARGB(255, 48, 47, 47),
      
      value: _value,
      min: 0.0,
      max: 100.0,
      onChanged: _onSliderChanged,
    );
  }
}
