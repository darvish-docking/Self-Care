import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/registration_entity.dart';
import 'package:selfcare_mobileapp/features/auth/domain/usecases/register_user_usercases.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/auth_provider.dart';




class OtpEnterPage extends StatefulWidget{
  const OtpEnterPage({super.key});

  @override
  State<OtpEnterPage> createState() => OtpEnterPageState();
}

class OtpEnterPageState extends State<OtpEnterPage>{

  @override
  Widget build(BuildContext context) {
    
    final role =
    context.read<UserRoleProviders>().selectedUserRole;

final gender =
    context.read<GenderProviders>().selectedGender;

// final dob =
//     context.read<DobProvider>().selectedDob;

// final name = nameController.text;
// final email = emailController.text;
// final password = passwordController.text;

final registration = RegistrationEntity(
  role: role,
  gender: gender!,
  dob: dob,
  name: name,
  email: email,
  password: password,
);

    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          ElevatedButton(onPressed: () async {

              final registerUserUseCase =
      context.read<RegisterUserUseCase>();

              await registerUserUseCase(registration);
              // to call function in domain/usecases/register_user_usercases.dart

          }, child: Text('Verify'))
        ],
      )
      ),
    );
  }
  


}