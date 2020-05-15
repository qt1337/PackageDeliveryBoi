import 'package:flutter/cupertino.dart';

class StatusModel {
  String id;
  String status;
  String name;
  IconData category;
  String serviceCompany;

  StatusModel(id, status, name, category, serviceCompany) {
    this.id = id;
    this.status = status;
    this.name = name;
    this.category = category;
    this.serviceCompany = serviceCompany;
  }
}
