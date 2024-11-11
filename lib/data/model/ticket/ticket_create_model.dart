class TicketCreateModel {
  final String subject;

  final String message;
  final String priority_name;
  
  final String status_name;
  
  final String department;
  final String userId;
  final String contactId;
  final String? priority;
  final String? service;
  final String? description;

  final String? company;
  TicketCreateModel({
    required this.subject,
    
    required this.status_name,
    required this.department,
    required this.priority_name,
    required this.userId,
    required this.contactId,
    
    required this.company,
    this.priority,
    this.service,
    required this.message,
    this.description,
  });
  Map<String, dynamic> toJson() {
    final map = {
      'subject': subject,
      'company':company,
      'status_name': status_name,
      'department': department,
      'userId': userId,
      "priority_name": priority_name,
      'message': message,
      'contactId': contactId,
    };
    if (priority != null) map['priority'] = priority ?? "";
    if (service != null) map['service'] = service ?? "";
    if (description != null) map['description'] = description ?? "";
    return map;
  }
}
