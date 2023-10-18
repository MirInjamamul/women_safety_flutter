import 'dart:convert';

import 'package:flutter/material.dart';

class ContactModel {
  final int? id;
  final String name;
  final String phone;
  final String colors;

  ContactModel({
    this.id,
    required this.name,
    required this.phone,
    required this.colors,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'colors': colors,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      colors: map['colors'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source));
  @override
  String toString() => 'Contact(id: $id, name: $name, phone: $phone)';
}