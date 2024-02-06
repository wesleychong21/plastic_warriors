import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class PlasticItem extends GameDecoration {
  String id;
  String name;
  late PlasticType type; // Enum for plastic type (weapon, shield, etc.)
  int quantity = 0;

  PlasticItem({
    required this.id,
    required this.name,
    required super.position,
    required super.size,
    required this.type,
    this.quantity = 0,
  }) : super.withSprite(
          sprite: Sprite.load('plastic_item.png'),
        );
}

// Enum for plastic type (plastic bag, bottle, cup, etc.)
enum PlasticType {
  bag,
  bottle,
  cup,
  other,
}
