import 'package:equatable/equatable.dart';

class Complaint extends Equatable {
  final int? id;
  final String? ticketNum;
  final String? reason;
  final String? details;
  final String? status;
  final String? adminResponse;
  final String? createdAt;
  final List<String>? photos;

  const Complaint({
    this.id,
    this.ticketNum,
    this.reason,
    this.details,
    this.status,
    this.adminResponse,
    this.createdAt,
    this.photos,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'] as int?,
      ticketNum: json['ticket_num'] as String?,
      reason: json['reason'] as String?,
      details: json['details'] as String?,
      status: json['status'] as String?,
      adminResponse: json['admin_response'] as String?,
      createdAt: json['created_at'] as String?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticket_num': ticketNum,
      'reason': reason,
      'details': details,
      'status': status,
      'admin_response': adminResponse,
      'created_at': createdAt,
      'photos': photos,
    };
  }

  @override
  List<Object?> get props => [
        id,
        ticketNum,
        reason,
        details,
        status,
        adminResponse,
        createdAt,
        photos,
      ];
}
