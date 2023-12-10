import 'package:flutter/material.dart';
import 'package:thebasiclook/widgets/customTextForm.dart';

class AddressTextFormField extends StatelessWidget {
  const AddressTextFormField({super.key, required this.addressLineController,
   required this.stateController,
    required this.countryController,
     required this.cityController,
      required this.postalCodeController, 
      required this.phoneController});
  final TextEditingController addressLineController;
    final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController postalCodeController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextFormField(
          controller: addressLineController,
          hint: 'Address Line',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid address';
            }
            return null;
          },
        ),
        CustomTextFormField(
          controller: stateController,
          hint: 'State',
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 5) {
              return 'Please enter a valid state';
            }
            return null;
          },
        ),
        CustomTextFormField(
          controller: countryController,
          hint: 'Country',
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 3) {
              return 'Please enter a valid country';
            }
            return null;
          },
        ),
        CustomTextFormField(
          controller: cityController,
          hint: 'City',
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 3) {
              return 'Please enter a valid city';
            }
            return null;
          },
        ),
        CustomTextFormField(
          controller: postalCodeController,
          hint: 'Postal Code',
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 3) {
              return 'Please enter a valid zip code';
            }
            return null;
          },
        ),
        CustomTextFormField(
          controller: phoneController,
          hint: 'Phone',
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 10) {
              return 'Please enter a valid number';
            }
            return null;
          },
        ),
      ],
    );
  }
}
