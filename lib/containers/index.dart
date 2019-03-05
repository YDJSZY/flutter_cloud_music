import 'package:flutter/material.dart';
import 'discover/index.dart';
import 'video/index.dart';
import 'my/index.dart';

final discover = new Discover();
final video = new Video();
final my = new My();
List<Widget> mainPages = [
  discover,
  video,
  my
];