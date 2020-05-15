import 'package:flutter/cupertino.dart';

class StatusModel {
  String id;
  String status;
  String name;
  IconData category;

  StatusModel(id, status, name, category) {
    this.id = id;
    this.status = status;
    this.name = name;
    this.category = category;
  }
}
