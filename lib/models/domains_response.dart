import 'package:get/get.dart';

class DomainsResponse {
  String? context;
  String? id;
  String? type;
  List<HydraMember>? hydraMember;
  int? hydraTotalItems;

  DomainsResponse(
      {this.context,
        this.id,
        this.type,
        this.hydraMember,
        this.hydraTotalItems});

  DomainsResponse.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    id = json['@id'];
    type = json['@type'];
    if (json['hydra:member'] != null) {
      hydraMember = <HydraMember>[];
      json['hydra:member'].forEach((v) {
        hydraMember!.add(HydraMember.fromJson(v));
      });
    }
    hydraTotalItems = json['hydra:totalItems'];
  }

}

class HydraMember {
  String? type;
  String? id;
  String? domain;
  bool? isActive;
  bool? isPrivate;
  String? createdAt;
  String? updatedAt;

  HydraMember(
      {this.id,
        this.type,
        this.domain,
        this.isActive,
        this.isPrivate,
        this.createdAt,
        this.updatedAt});

  HydraMember.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    id = json['id'];
    domain = json['domain'];
    isActive = json['isActive'];
    isPrivate = json['isPrivate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}