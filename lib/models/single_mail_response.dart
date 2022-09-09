import 'maillist_response.dart';

class SingleMailResponse {
  String? context;
  String? id;
  String? type;
  String? accountId;
  String? msgid;
  MailAddress? from;
  List<MailAddress>? to;
  List<MailAddress>? cc;
  List<MailAddress>? bcc;
  String? subject;
  bool? seen;
  bool? flagged;
  bool? isDeleted;
  //List<Null>? verifications;
  bool? retention;
  String? retentionDate;
  String? text;
  List<String>? html;
  bool? hasAttachments;
  List<Attachments>? attachments;
  int? size;
  String? downloadUrl;
  String? createdAt;
  String? updatedAt;

  SingleMailResponse(
      {this.context,
        this.id,
        this.type,
        this.accountId,
        this.msgid,
        this.from,
        this.to,
        this.cc,
        this.bcc,
        this.subject,
        this.seen,
        this.flagged,
        this.isDeleted,
        //this.verifications,
        this.retention,
        this.retentionDate,
        this.text,
        this.html,
        this.hasAttachments,
        this.attachments,
        this.size,
        this.downloadUrl,
        this.createdAt,
        this.updatedAt});

  SingleMailResponse.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    id = json['id'];
    accountId = json['accountId'];
    msgid = json['msgid'];
    from = json['from'] != null ? MailAddress.fromJson(json['from']) : null;
    if (json['to'] != null) {
      to = <MailAddress>[];
      json['to'].forEach((v) {
        to!.add(MailAddress.fromJson(v));
      });
    }
    if (json['cc'] != null) {
      cc = <MailAddress>[];
      json['cc'].forEach((v) {
        cc!.add(MailAddress.fromJson(v));
      });
    }
    if (json['bcc'] != null) {
      bcc = <MailAddress>[];
      json['bcc'].forEach((v) {
        bcc!.add(MailAddress.fromJson(v));
      });
    }
    subject = json['subject'];
    seen = json['seen'];
    flagged = json['flagged'];
    isDeleted = json['isDeleted'];
   /* if (json['verifications'] != null) {
      verifications = <Null>[];
      json['verifications'].forEach((v) {
        verifications!.add(new Null.fromJson(v));
      });
    }*/
    retention = json['retention'];
    retentionDate = json['retentionDate'];
    text = json['text'];
    html = json['html'].cast<String>();
    hasAttachments = json['hasAttachments'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    size = json['size'];
    downloadUrl = json['downloadUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

}

class Attachments {
  String? id;
  String? filename;
  String? contentType;
  String? disposition;
  String? transferEncoding;
  bool? related;
  int? size;
  String? downloadUrl;

  Attachments(
      {this.id,
        this.filename,
        this.contentType,
        this.disposition,
        this.transferEncoding,
        this.related,
        this.size,
        this.downloadUrl});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    contentType = json['contentType'];
    disposition = json['disposition'];
    transferEncoding = json['transferEncoding'];
    related = json['related'];
    size = json['size'];
    downloadUrl = json['downloadUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filename'] = this.filename;
    data['contentType'] = this.contentType;
    data['disposition'] = this.disposition;
    data['transferEncoding'] = this.transferEncoding;
    data['related'] = this.related;
    data['size'] = this.size;
    data['downloadUrl'] = this.downloadUrl;
    return data;
  }
}