import 'package:flutter/material.dart';

class PercentIndicator extends StatelessWidget {
  final double? percent;
  final Color? color;
  final String? _message;
  const PercentIndicator.connected({super.key, required this.percent})
      : color = null,
        _message = null;
  PercentIndicator.connecting({super.key})
      : percent = null,
        _message = 'Connecting...',
        color = Colors.yellowAccent;
  const PercentIndicator.disconnected({super.key})
      : percent = 1.0,
        _message = 'Disconnected',
        color = Colors.grey;
  const PercentIndicator.error({super.key})
      : percent = 1.0,
        _message = 'Error',
        color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.scale(
          scale: 6,
          child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: percent,
                  color: color,
                ),
              ),
        ),
        SizedBox(
          height: 220,
          width: 220,
          child: Center(
            child: Text(
              _message != null
                  ? _message!
                  : 'Connected',
              // '${((percent ?? 0) * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontFamily: 'RobotoSlab',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
        ),
      ],
    );  
  }
}