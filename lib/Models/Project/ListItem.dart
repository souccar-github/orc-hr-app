import 'package:json_annotation/json_annotation.dart';

part 'ListItem.g.dart';

@JsonSerializable()
class ListItem {
  final int id;
  final String name;

  ListItem(
      this.id,
      this.name);

  factory ListItem.fromJson(Map<String, dynamic> json) =>
      _$ListItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ListItemsToJson(this);
}
