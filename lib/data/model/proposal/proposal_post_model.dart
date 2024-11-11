import 'package:flutex_admin/data/model/proposal/proposal_item_model.dart';

class ProposalPostModel {
  final String subject;
  final String related;
  final String relId;
  final String proposalTo;
  final String date;
  final String openTill;
  final String currency;
  final String? discountType;
  final String status;
  final String? assigned;
  final String email;
  final String firstItemName;
  final String? firstItemDescription;
  final String firstItemQty;
  final String firstItemRate;
  final String? firstItemUnit;
  final List<ProposalItemModel> newItems;
  final String subtotal;
  final String total;

  ProposalPostModel({
    required this.subject,
    required this.related,
    required this.relId,
    required this.proposalTo,
    required this.date,
    required this.openTill,
    required this.currency,
    this.discountType,
    required this.status,
    this.assigned,
    required this.email,
    required this.firstItemName,
    this.firstItemDescription,
    required this.firstItemQty,
    required this.firstItemRate,
    this.firstItemUnit,
    required this.newItems,
    required this.subtotal,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subject'] = subject;
    map['related'] = related;
    map['rel_id'] = relId;
    map['proposal_to'] = proposalTo;
    map['date'] = date;
    map['open_till'] = openTill;
    map['currency'] = currency;
    map['currency_name'] = "INR";
    map['discount_type'] = discountType;
    map['status'] = status;
    map['assigned'] = assigned;
    map['email'] = email;
    map['first_item_name'] = firstItemName;
    map['first_item_description'] = firstItemDescription;
    map['first_item_qty'] = firstItemQty;
    map['first_item_rate'] = firstItemRate;
    map['first_item_unit'] = firstItemUnit;
    map['new_items'] = newItems.map((item) => item.toJson()).toList();
    map['subtotal'] = subtotal;
    map['total'] = total;
    return map;
  }
}
