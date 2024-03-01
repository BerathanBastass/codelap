import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  SizedBox get sbxh => SizedBox(
        height: toDouble(),
      );
  SizedBox get sbxw => SizedBox(
        width: toDouble(),
      );
}

Widget sbxh() => const SizedBox(
      height: 30,
    );

Widget sbxw() => const SizedBox(
      width: 30,
    );
