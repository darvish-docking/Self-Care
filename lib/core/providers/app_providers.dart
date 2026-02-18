import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/register_user_usercases.dart';


class AppProviders {

  static List<SingleChildWidget> providers = [

    // ChangeNotifierProvider<UserRoleProviders>(
    //   create: (_) => UserRoleProviders(),),

    // ChangeNotifierProvider<GenderProviders>(
    //   create: (_) => GenderProviders(),),

    // ChangeNotifierProvider<DobProvider>(create: (_) => DobProvider()),

    // ChangeNotifierProvider<LocationProvider>(create: (_) => LocationProvider()),

    ChangeNotifierProvider<SignupFormProvider>(create: (_) => SignupFormProvider()),

      Provider<AuthRemoteDatasource>(
        create: (_) => AuthRemoteDatasource(Dio()),
      ),

      Provider<AuthRepository>(
        create: (context) => AuthRepositoryImpl(
          context.read<AuthRemoteDatasource>(),
        ),
      ),

      Provider<RegisterUserUseCase>(
        create: (context) => RegisterUserUseCase(
          context.read<AuthRepository>(),
        ),
      ),

  ];
}