import 'package:flutter/material.dart';

class CompanyModel {
  static final companies = [
    Company(
      id: 1,
      name: "TATA",
      color: "#33505a",
    )
  ];
}

class Company {
  final int id;
  final String name;
  final String color;

  Company({required this.id, required this.name, required this.color});
}
