import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/otp_provider.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/signin_provider.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/providers/call_provider.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/providers/bookAppointment-provider.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/providers/payment_provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/providers/data_provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/providers/home-provider.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/register_user_usercases.dart';


class AppProviders {

  static List<SingleChildWidget> providers = [

    ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider(),),

    ChangeNotifierProvider<HomeProvider>(
    create: (context) {
      final dataProvider = context.read<DataProvider>();
      final homeProvider = HomeProvider();
      homeProvider.updateData(dataProvider);
      return homeProvider;
    },
  ),


  /// ---------- AUTH DEPENDENCIES ----------
    Provider<AuthRemoteDatasource>(               // data layer
      create: (_) => AuthRemoteDatasource(
        FirebaseAuth.instance,
        FirebaseFirestore.instance,
      ),
    ),

    Provider<AuthRepository>(                     // domain layer
      create: (context) => AuthRepositoryImpl(    // data layer
        context.read<AuthRemoteDatasource>(),     // data layer
      ),
    ),

    Provider<RegisterUserUseCase>(                 // domain layer
      create: (context) => RegisterUserUseCase(    // domain layer
        context.read<AuthRepository>(),
      ),
    ),

    ChangeNotifierProvider<SignupFormProvider>(create: (context) => SignupFormProvider(context.read<RegisterUserUseCase>(),)),

    ChangeNotifierProvider<SigninFormProvider>(create: (_) => SigninFormProvider()),
  
    ChangeNotifierProvider<OtpProvider>(create: (_) => OtpProvider()),

    ChangeNotifierProvider<AppointmentProvider>(create: (_) =>AppointmentProvider()),

    ChangeNotifierProvider<PaymentProvider>(create: (_) =>PaymentProvider()),

    ChangeNotifierProvider<CallProvider>(create: (_) =>CallProvider()),

  ];
}