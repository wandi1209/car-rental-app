import 'package:car_rental_app/data/datasources/firebase_car_data_source.dart';
import 'package:car_rental_app/data/repositories/car_repository_impl.dart';
import 'package:car_rental_app/domain/usecases/get_cars.dart';
import 'package:car_rental_app/presentation/bloc/car_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void init() {
  try {
    getIt.registerLazySingleton(()=> FirebaseFirestore.instance);
    getIt.registerLazySingleton(() => FirebaseCarDataSource(firestore: getIt<FirebaseFirestore>()));
    getIt.registerLazySingleton(() => CarRepositoryImpl(datasource: getIt<FirebaseCarDataSource>()));
    getIt.registerLazySingleton(() => GetCars(repository: getIt<CarRepositoryImpl>()));
    getIt.registerFactory(()=> CarBloc(getCars: getIt<GetCars>()));
  } catch (e) {
    rethrow;
  }
}
