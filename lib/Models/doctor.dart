 
import 'package:flutter/material.dart';

class Doctor {
  final int id ;
  final String name ;
  final String about;
  final String specialty;
  final double rating;
  final String city;
  final String image;

  Doctor({
    required this.id,
    required this.name,
    required this.about,
    required this.specialty,
    required this.rating,
    required this.city,
    required this.image,
  });
}