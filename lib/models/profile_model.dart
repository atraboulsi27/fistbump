import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class Profile {
  String? id;
  String? name;
  String? email;
  String? description;
  Role? role;
  String? location;
  String? expertise;
  String? phone;
  String? imageLink;
  List<DateTime>? appointments;

  Profile(
      {this.id,
      this.name,
      this.email,
      this.role,
      this.description,
      this.location,
      this.expertise,
      this.phone,
      this.appointments,
      this.imageLink});

  factory Profile.fromJson(Map<String, dynamic> json) {
    json["appointments"] = (json["appointments"])
        .map<String>((e) => e.toDate().toString())
        .toList();
    return _$ProfileFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

enum Role {
  @JsonValue("trainer")
  Trainer,
  @JsonValue("dietitian")
  Dietitian,
  @JsonValue("meal-planner")
  Meal_Planner,
  @JsonValue("physiotherapist")
  Physiotherapist
}

class TimeStampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimeStampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) {
    return Timestamp.fromDate(date);
  }
}
