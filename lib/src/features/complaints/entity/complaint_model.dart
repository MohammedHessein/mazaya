import 'package:equatable/equatable.dart';
import 'package:mazaya/src/core/helpers/mapping_helpers.dart';

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
      id: MappingHelpers.toInt(json['id']),
      ticketNum: MappingHelpers.toStringSafe(json['ticket_num']),
      reason: MappingHelpers.toStringSafe(json['reason']),
      details: MappingHelpers.toStringSafe(json['details']),
      status: MappingHelpers.toStringSafe(json['status']),
      adminResponse: MappingHelpers.toStringSafe(json['admin_response']),
      createdAt: MappingHelpers.toStringSafe(json['created_at']),
      photos: json['photos'] is List
          ? (json['photos'] as List).map((e) => MappingHelpers.toStringSafe(e)).toList()
          : null,
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
