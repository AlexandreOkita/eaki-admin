import 'package:eaki_admin/models/entities/queue_number.dart';

class QueueNumberDTO {
  final String? hcNumber;
  final String? name;
  final DateTime date;
  final DateTime? dateCalled;
  final VisitPurpose visitPurpose;

  QueueNumberDTO({
    this.hcNumber,
    this.name,
    this.dateCalled,
    required this.visitPurpose,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "hc_number": hcNumber ?? "",
      "name": name ?? "",
      "visit_purpose": visitPurpose.name,
      "date": date
    };
  }

  factory QueueNumberDTO.fromMap(Map<String, dynamic> map) {
    return QueueNumberDTO(
        visitPurpose: map["visit_purpose"].toString().toVisitPurpose(),
        date: map["date"].toDate(),
        name: map["name"] == "" ? null : map["name"],
        hcNumber: map["hc_number"] == "" ? null : map["hc_number"],
        dateCalled: map["date_called"]);
  }

  copy({String? hcNumber, String? name, VisitPurpose? visitPurpose, DateTime? date}) {
    return QueueNumberDTO(
        visitPurpose: visitPurpose ?? this.visitPurpose,
        date: date ?? this.date,
        name: name ?? this.name,
        hcNumber: hcNumber ?? this.hcNumber);
  }
}
