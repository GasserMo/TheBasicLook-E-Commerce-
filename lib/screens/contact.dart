import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebasiclook/bloc/contact/contact_bloc.dart';
import 'package:thebasiclook/services/contact.dart';
import 'package:thebasiclook/widgets/customAppBar.dart';
import 'package:thebasiclook/widgets/customTextForm.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    messageController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  final ContactBloc contactBloc = ContactBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Service'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  CustomTextFormField(
                    hint: 'Name',
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid Name';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    hint: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    hint: 'Phone',
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                    controller: messageController,
                    maxLength: 400,
                    maxLines: 5,
                    textAlign: TextAlign.start, // Center-align the text
                    decoration: InputDecoration(
                      hintText: 'Please write your message',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              BlocConsumer<ContactBloc, ContactState>(
                bloc: contactBloc,
                listener: (context, state) {
                  if (state is ContactSuccess) {
                    showSnackbar(context, 'Message is sent');
                  }
                    else if (state is ContactFailure) {
                    showSnackbar(context, state.err);
                  }
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if(state is ContactLoading){
                    return Center(child: CircularProgressIndicator());
                  }
                  return GestureDetector(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        contactBloc.add(ContactSubmitEvent(
                            email: emailController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            message: messageController.text));
                        formkey.currentState!.reset();
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error ?? 'Message Failed')));
  }
  /*  void showSnackBar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Your Message Has Been Sent')));
  } */
}
/* 
65048df4e395d6de2c8d1dfe
65048e32e395d6de2c8d1e0a
65199b102289d387777c39e4
65048e32e395d6de2c8d1e0a


653de3579cdf8da1a56f7975
653de48d9cdf8da1a56f7baf
65497ccb0df1712f7e6b638f
6549830e0df1712f7e6b63fd
6549a199b297e76919f4c5f3
*/