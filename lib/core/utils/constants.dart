
import 'package:flutter/material.dart';

const kContactTable = 'Contact';
const kDbName = 'ContactApp';

const kTextFieldDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.grey, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.black, width: 2.0),
  ),
);