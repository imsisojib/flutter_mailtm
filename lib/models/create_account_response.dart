class CreateAccountResponse {
  int statusCode = 0; //for local usages
  String? context;
  String? type;
  String? id;
  String? address;
  int? quota;
  int? used;
  String? hydraDescription;
  bool? isDisabled;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  CreateAccountResponse(
      {this.context,
        this.id,
        this.type,
        this.address,
        this.quota,
        this.used,
        this.hydraDescription,
        this.isDisabled,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  CreateAccountResponse.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    id = json['id'];
    address = json['address'];
    quota = json['quota'];
    used = json['used'];
    hydraDescription = json['hydra:description'];
    isDisabled = json['isDisabled'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['@context'] = this.context;
    data['@id'] = this.id;
    data['@type'] = this.type;
    data['id'] = this.id;
    data['address'] = this.address;
    data['quota'] = this.quota;
    data['used'] = this.used;
    data['hydra:description'] = this.hydraDescription;
    data['isDisabled'] = this.isDisabled;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}