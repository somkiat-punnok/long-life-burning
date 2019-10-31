library event;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;

part './event_view.dart';
part './event_card.dart';

typedef void EventCallback(Event event);

class Event {

  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String province;
  final String detail;
  final DateTime date;

  Event({
    this.id,
    this.title,
    this.subtitle,
    this.category,
    this.province,
    this.detail,
    this.date,
  });

  factory Event.fromMap(Map<String, dynamic> map) => Event(
    id: map["id"],
    title: map["subject"],
    subtitle: map["sub_title"],
    category: map["tags"],
    province: map["province"],
    detail: map["detail"],
    date: DateTime.parse(map["date"]),
  );

  factory Event.fromJson(String s) => Event.fromMap(json.decode(s));

  Map<String, dynamic> toMap() => <String, dynamic>{
    "id": this.id,
    "title": this.title,
    "subtitle": this.subtitle,
    "category": this.category,
    "province": this.province,
    "detail": this.detail,
    "date": this.date.toIso8601String(),
  };

  String toJson() => json.encode(this.toMap());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Event &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              subtitle == other.subtitle &&
              category == other.category &&
              province == other.province &&
              detail == other.detail &&
              date == other.date;

  @override
  int get hashCode => (
    id.hashCode ^
    title.hashCode ^
    subtitle.hashCode ^
    category.hashCode ^
    province.hashCode ^
    detail.hashCode ^
    date.hashCode
  );

  @override
  String toString() {
    return '$runtimeType{id: $id, title: $title, date: $date}';
  }

}
