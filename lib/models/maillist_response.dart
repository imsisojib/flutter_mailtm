class MailListResponse {
  String? context;
  String? id;
  String? type;
  List<Mail>? hydraMember;
  int? hydraTotalItems;

  MailListResponse(
      {this.context,
        this.id,
        this.type,
        this.hydraMember,
        this.hydraTotalItems});

  MailListResponse.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    id = json['@id'];
    type = json['@type'];
    if (json['hydra:member'] != null) {
      hydraMember = <Mail>[];
      json['hydra:member'].forEach((v) {
        hydraMember!.add(Mail.fromJson(v));
      });
    }
    hydraTotalItems = json['hydra:totalItems'];
  }
}

class Mail {
  String? id;
  String? type;
  String? accountId;
  String? msgid;
  MailAddress? from;
  List<MailAddress>? to;
  String? subject;
  String? intro;
  bool? seen;
  bool? isDeleted;
  bool? hasAttachments;
  int? size;
  String? downloadUrl;
  String? createdAt;
  String? updatedAt;

  Mail(
      {this.id,
        this.type,
        this.accountId,
        this.msgid,
        this.from,
        this.to,
        this.subject,
        this.intro,
        this.seen,
        this.isDeleted,
        this.hasAttachments,
        this.size,
        this.downloadUrl,
        this.createdAt,
        this.updatedAt});

  Mail.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    id = json['id'];
    accountId = json['accountId'];
    msgid = json['msgid'];
    from = json['from'] != null ?MailAddress.fromJson(json['from']) : null;
    if (json['to'] != null) {
      to = <MailAddress>[];
      json['to'].forEach((v) {
        to!.add(MailAddress.fromJson(v));
      });
    }
    subject = json['subject'];
    intro = json['intro'];
    seen = json['seen'];
    isDeleted = json['isDeleted'];
    hasAttachments = json['hasAttachments'];
    size = json['size'];
    downloadUrl = json['downloadUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

}

class MailAddress {
  String? address;
  String? name;

  MailAddress({this.address, this.name});

  MailAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
  }

}