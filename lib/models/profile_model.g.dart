// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    id: json['id'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    role: _$enumDecodeNullable(_$RoleEnumMap, json['role']),
    description: json['description'] as String?,
    location: json['location'] as String?,
    expertise: json['expertise'] as String?,
    phone: json['phone'] as String?,
    appointments: (json['appointments'] as List<dynamic>?)
        ?.map(
            (e) => ProfessionalAppointment.fromJson(e as Map<String, dynamic>))
        .toList(),
    imageLink: json['imageLink'] as String?,
  )..pendingAppointments = (json['pendingAppointments'] as List<dynamic>?)
      ?.map((e) => ProfessionalAppointment.fromJson(e as Map<String, dynamic>))
      .toList();
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'role': _$RoleEnumMap[instance.role],
      'location': instance.location,
      'expertise': instance.expertise,
      'phone': instance.phone,
      'imageLink': instance.imageLink,
      'appointments': instance.appointments,
      'pendingAppointments': instance.pendingAppointments,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$RoleEnumMap = {
  Role.Trainer: 'trainer',
  Role.Dietitian: 'dietitian',
  Role.Meal_Planner: 'meal-planner',
  Role.Physiotherapist: 'physiotherapist',
};

ProfessionalAppointment _$ProfessionalAppointmentFromJson(
    Map<String, dynamic> json) {
  return ProfessionalAppointment(
    name: json['name'] as String?,
    time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
    userEmail: json['userEmail'] as String?,
  );
}

Map<String, dynamic> _$ProfessionalAppointmentToJson(
        ProfessionalAppointment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'time': instance.time?.toIso8601String(),
      'userEmail': instance.userEmail,
    };
