import 'package:json_annotation/json_annotation.dart';

import '../synchornization_provider.dart';

part 'synchronization_model.g.dart';

@JsonSerializable()
class Synchronization implements SynchonizationProvider {
  Synchronization(
      {this.id, this.lastSynchronization, this.statusSynchronization});

  @override
  String id;
  @override
  DateTime lastSynchronization;
  @override
  int statusSynchronization;

  factory Synchronization.fromJson(Map<String, dynamic> json) =>
      _$SynchronizationFromJson(json);

  Map<String, dynamic> toJson() => _$SynchronizationToJson(this);
}
