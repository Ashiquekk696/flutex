class ContractPostModel {
  final String subject;
  final String client;
  final String startDate;

  final String dateadded;
  final String endDate;
  final String contractValue;
  final String description;
  final String content;

  ContractPostModel({
    required this.subject,
    required this.startDate,
    required this.dateadded,
    required this.client,
    required this.endDate,
    required this.contractValue,
    required this.description,
    required this.content,
  });

  // Convert ContractPostModel instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'client': client,
      'company':client,
      'startDate': startDate,
      'dateadded': dateadded,
      'endDate': endDate,
      'contract_value': contractValue,
      'description': description,
      'content': content,
    };
  }
}
