import '../../../../config/res/config_imports.dart';
import '../../../../core/shared/models/image_entity.dart';

class ComplainEntity {
  final int id;
  final String complaintNumber;
  final String date;
  final String status;
  final String statusText;
  final String reason;
  final String complaint;
  final List<ImageEntity> files;
  final List<ReplyEntity> replies;

  const ComplainEntity({
    required this.id,
    required this.complaintNumber,
    required this.date,
    required this.status,
    required this.statusText,
    required this.reason,
    required this.complaint,
    required this.files,
    required this.replies,
  });

  factory ComplainEntity.initial() => const ComplainEntity(
    id: 0,
    complaintNumber: SkeltonizerManager.short,
    date: SkeltonizerManager.medium,
    status: SkeltonizerManager.short,
    statusText: SkeltonizerManager.short,
    reason: SkeltonizerManager.short,
    complaint: SkeltonizerManager.long,
    files: [],
    replies: [],
  );

  factory ComplainEntity.fromJson(Map<String, dynamic> json) => ComplainEntity(
    id: json["id"],
    complaintNumber: json["complaint_number"],
    date: json["date"],
    status: json["status"],
    statusText: json["status_text"],
    reason: json["reason"],
    complaint: json["complaint"],
    files: List<ImageEntity>.from(
      json["files"].map((x) => ImageEntity.fromJson(x)),
    ),
    replies: List<ReplyEntity>.from(
      json["replies"].map((x) => ReplyEntity.fromJson(x)),
    ),
  );
}

class ReplyEntity {
  final String reply;

  ReplyEntity({required this.reply});

  factory ReplyEntity.fromJson(Map<String, dynamic> json) =>
      ReplyEntity(reply: json["reply"]);
}
