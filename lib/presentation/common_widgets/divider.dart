import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: Стоит выделять в класс общих виджетов во всех страницах

Widget getDivider() {
  return const Divider(
    color: Color.fromRGBO(110, 53, 76, 1),
    thickness: 1.5,
    height: 0,
  );
}
