import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white24,
  filled: true,
  contentPadding: EdgeInsets.all(10.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(50.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 2.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(50.0),
    ),
  ),
);


const textInputDecoration2 = InputDecoration(
  fillColor: Colors.white24,
  filled: true,
  contentPadding: EdgeInsets.all(10.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(52, 73, 94, 1), width: 2.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(50.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 2.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(50.0),
    ),
  ),
);
