import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
//import 'package:json_serializable/builder.dart';

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
  List<ProfessionalAppointment>? appointments;
  List<ProfessionalAppointment>? pendingAppointments;

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

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

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

@JsonSerializable()
class ProfessionalAppointment {
  ProfessionalAppointment({
    this.name,
    this.time,
    this.userEmail,
  });

  String? name;
  DateTime? time;
  String? userEmail;

  factory ProfessionalAppointment.fromJson(Map<String, dynamic> json) {
    json["time"] = json["time"].toDate().toString();
    return _$ProfessionalAppointmentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfessionalAppointmentToJson(this);
}
