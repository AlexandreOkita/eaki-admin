import 'package:eaki_admin/models/dto/queue_number_dto.dart';

class QueueNumber {
  final String? hcNumber;
  final String? name;
  final String id;
  final int number;
  final DateTime date;
  final DateTime? dateCalled;
  final VisitPurpose visitPurpose;

  QueueNumber(
      {this.hcNumber,
      this.name,
      required this.id,
      required this.visitPurpose,
      required this.number,
      required this.date,
      required this.dateCalled});

  factory QueueNumber.fromDTO(QueueNumberDTO dto, int number, String id) {
    return QueueNumber(
      visitPurpose: dto.visitPurpose,
      number: number,
      date: dto.date,
      hcNumber: dto.hcNumber,
      name: dto.name,
      id: id,
      dateCalled: dto.dateCalled,
    );
  }
}

enum VisitPurpose {
  procedure,
  appointment,
}

extension VisitPurposeExtension on String {
  VisitPurpose toVisitPurpose() {
    switch (this) {
      case "appointment":
        return VisitPurpose.appointment;
      case "procedure":
        return VisitPurpose.procedure;
      default:
        return VisitPurpose.appointment;
    }
  }
}
