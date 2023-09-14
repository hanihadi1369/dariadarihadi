import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  final Function(bool) callback;

  const CheckboxWidget({Key? key, required this.callback}) : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool _checkbox = false;

  @override
  Widget build(BuildContext context) {
    return   Container(
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('افزودن به قبض های من',textAlign: TextAlign.right, style: TextStyle(fontSize: 16,color: Colors.blueGrey),),
        value: _checkbox,
        onChanged: (value) {
          widget.callback(value!);
          setState(() => _checkbox = !_checkbox);},
      ),
    );
  }
}