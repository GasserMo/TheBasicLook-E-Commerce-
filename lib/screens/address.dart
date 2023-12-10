import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thebasiclook/models/address_model.dart';
import 'package:thebasiclook/services/address.dart';
import 'package:thebasiclook/widgets/add_to_cart.dart';
import 'package:thebasiclook/widgets/address_text_form.dart';
import 'package:thebasiclook/widgets/customAppBar.dart';
import 'package:thebasiclook/widgets/customTextForm.dart';
import 'package:thebasiclook/widgets/drawer.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _addressLineController.dispose();
    _postalCodeController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token = GetStorage().read('token');
    final userId = GetStorage().read('userId');
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: customAppBar(title: 'Address'),
        body: FutureBuilder<List<AddressModel>>(
          future: AddressServices().getAddress(token: token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('no data');
            }
            final addresses = snapshot.data!;
            if (addresses == null || addresses.isEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: AddressTextFormField(
                              addressLineController: _addressLineController,
                              stateController: _stateController,
                              countryController: _countryController,
                              cityController: _cityController,
                              postalCodeController: _postalCodeController,
                              phoneController: _phoneController)),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await AddressServices().addAddress(
                            addressLine: _addressLineController.text,
                            country: _countryController.text,
                            city: _cityController.text,
                            state: _stateController.text,
                            postalCode: _postalCodeController.text,
                            phone: _phoneController.text,
                            token: token,
                          );
                          setState(() {});
                        }
                      },
                      child: Submitting(text: 'Submit')),
                ],
              );
            } else {
              return StatefulBuilder(builder: (context, index) {
                int noOfAddress = 0; // Initialize the counter

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          noOfAddress++;
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Title(
                                      title: 'Address no. ${noOfAddress}',
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () async {
                                              await AddressServices()
                                                  .deleteAddress(
                                                      token: token,
                                                      id: address.id as String);
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            children: [
                                                              AddressTextFormField(
                                                                  addressLineController:
                                                                      _addressLineController,
                                                                  stateController:
                                                                      _stateController,
                                                                  countryController:
                                                                      _countryController,
                                                                  cityController:
                                                                      _cityController,
                                                                  postalCodeController:
                                                                      _postalCodeController,
                                                                  phoneController:
                                                                      _phoneController),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    if (_formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      await AddressServices().updateAddress(
                                                                          addressLine: _addressLineController
                                                                              .text,
                                                                          country: _countryController
                                                                              .text,
                                                                          city: _cityController
                                                                              .text,
                                                                          state: _stateController
                                                                              .text,
                                                                          postalCode: _postalCodeController
                                                                              .text,
                                                                          phone: _phoneController
                                                                              .text,
                                                                          token:
                                                                              token,
                                                                          id: address
                                                                              .id!);
                                                                      Navigator.pop(
                                                                          context);
                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  },
                                                                  child: Submitting(
                                                                      text:
                                                                          'Submit')),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    ),
                                  ],
                                ),
                                Details(address: address.addressLine as String),
                                Title(
                                  title: 'State',
                                ),
                                Details(address: address.state as String),
                                Title(
                                  title: 'City',
                                ),
                                Details(address: address.city as String),
                                Title(
                                  title: 'Country',
                                ),
                                Details(address: address.country as String),
                                Title(
                                  title: 'Postal Code',
                                ),
                                Details(address: address.postalCode as String),
                                Title(
                                  title: 'Phone',
                                ),
                                Details(address: address.phone as String),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        AddressTextFormField(
                                            addressLineController:
                                                _addressLineController,
                                            stateController: _stateController,
                                            countryController:
                                                _countryController,
                                            cityController: _cityController,
                                            postalCodeController:
                                                _postalCodeController,
                                            phoneController: _phoneController),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                            onTap: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                await AddressServices()
                                                    .addAddress(
                                                  addressLine:
                                                      _addressLineController
                                                          .text,
                                                  country:
                                                      _countryController.text,
                                                  city: _cityController.text,
                                                  state: _stateController.text,
                                                  postalCode:
                                                      _postalCodeController
                                                          .text,
                                                  phone: _phoneController.text,
                                                  token: token,
                                                );

                                                setState(() {});
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Submitting(text: 'Submit')),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Submitting(
                        text: 'Add Another Address',
                      ),
                    ),
                  ],
                );
              });
            }
          },
        ));
  }
}

class Submitting extends StatelessWidget {
  const Submitting({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ));
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) {
    return Text(
      address,
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
