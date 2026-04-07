import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:selfcare_mobileapp/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:selfcare_mobileapp/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/otp_provider.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/session_provider.dart';
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

import '../../features/doctors/data/datasources/doctor_firebase_datasource.dart';
import '../../features/doctors/data/repositories/doctor_repository_impl.dart';
import '../../features/doctors/domain/repositories/doctor_repository.dart';
import '../../features/doctors/domain/usecases/get_doctors.dart';

class AppProviders {

  static List<SingleChildWidget> providers = [

    /// ---------- DOCTOR DEPENDENCIES ----------
    Provider<DoctorFirestoreDataSource>(
      create: (_) => DoctorFirestoreDataSource(FirebaseFirestore.instance),
    ),
    Provider<DoctorRepository>(
      create: (context) => DoctorRepositoryImpl(context.read<DoctorFirestoreDataSource>()),
    ),
    Provider<GetDoctors>(
      create: (context) => GetDoctors(context.read<DoctorRepository>()),
    ),

    ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider(),),

    ChangeNotifierProvider<HomeProvider>(
      create: (context) {
        final dataProvider = context.read<DataProvider>();
        final homeProvider = HomeProvider(context.read<GetDoctors>());
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

    Provider<LoginUserUseCase>(   // ✅ ADD THIS
      create: (context) => LoginUserUseCase(
        context.read<AuthRepository>(),
      ),
    ),

    Provider<GetCurrentUserUseCase>(
      create: (context) => GetCurrentUserUseCase(
        context.read<AuthRepository>(),
      ),
    ),


    ChangeNotifierProvider<SignupFormProvider>(create: (context) => SignupFormProvider(context.read<RegisterUserUseCase>(),)),

    ChangeNotifierProvider<SigninFormProvider>(create: (context) => SigninFormProvider(context.read<LoginUserUseCase>())),
  
    ChangeNotifierProvider<OtpProvider>(create: (_) => OtpProvider()),

    ChangeNotifierProvider<SessionProvider>(create: (context) => SessionProvider(context.read<GetCurrentUserUseCase>(),),),

    ChangeNotifierProvider<AppointmentProvider>(create: (_) =>AppointmentProvider()),

    ChangeNotifierProvider<PaymentProvider>(create: (_) =>PaymentProvider()),

    ChangeNotifierProvider<CallProvider>(create: (_) =>CallProvider()),

  ];
}