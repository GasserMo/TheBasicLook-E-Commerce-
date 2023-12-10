import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String? addressLine;
  final String? country;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? phone;
  final bool? isDefault;
  final String? id;

  const AddressModel({
    this.addressLine,
    this.country,
    this.city,
    this.state,
    this.postalCode,
    this.phone,
    this.isDefault,
    this.id,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        addressLine: json['addressLine'] as String?,
        country: json['country'] as String?,
        city: json['city'] as String?,
        state: json['state'] as String?,
        postalCode: json['postalCode'] as String?,
        phone: json['phone'] as String?,
        isDefault: json['isDefault'] as bool?,
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'addressLine': addressLine,
        'country': country,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'phone': phone,
        'isDefault': isDefault,
        '_id': id,
      };

  @override
  List<Object?> get props {
    return [
      addressLine,
      country,
      city,
      state,
      postalCode,
      phone,
      isDefault,
      id,
    ];
  }
}
