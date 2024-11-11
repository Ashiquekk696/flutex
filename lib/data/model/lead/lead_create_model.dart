class LeadCreateModel {
  final String source;
  final String status;
  final String name;
  final String? assigned;
  final String? clientId;
  final String? tags;
  final String? contact;
  final String? title;
  final String? email;
  final String? website;
  final String? phoneNumber;
  
  final String? leadValue;
  final String? company;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? defaultLanguage;
  final String? description;
  final String? customContactDate;
  final String? contactedToday;
  final String? isPublic;

  LeadCreateModel({
    required this.source,
    required this.status,
    required this.name,
    this.assigned,
    this.clientId,
    this.tags,
    this.contact,
    this.title,
    this.email,
    this.website,
    this.phoneNumber,
    this.company,
    this.address,
    this.city,
    this.state,
    this.leadValue,
    this.country,
    this.defaultLanguage,
    this.description,
    this.customContactDate,
    this.contactedToday,
    this.isPublic,
  });

  /// Converts LeadCreateModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'source_name': source,
      'status_name': status,
      'name': name,
      'assigned': assigned,
      'clientId': clientId,
      'tags': tags,
      'color':"FF5733",
      'lead_value':leadValue,
      'contact': contact,
      'title': title,
      'email': email,
      'website': website,
      'phoneNumber': phoneNumber,
      'company': company,
      'address': address,
      'city': city,
      'state': state,
      "dateadded":"${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} 00:00:00",
      'country': country,
      'defaultLanguage': defaultLanguage,
      'description': description,
      'customContactDate': customContactDate,
      'contactedToday': contactedToday,
      'isPublic': isPublic,
    };
  }
}
