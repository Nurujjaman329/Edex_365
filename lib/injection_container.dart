import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/HttpManager.dart';
import 'features/authentication/data/datasources/authentication_local_data_sources.dart';
import 'features/authentication/data/datasources/authentication_remote_data_sources.dart';
import 'features/authentication/data/repositories/authentication_repositories_impl.dart';
import 'features/authentication/domain/repositories/authentication_repository.dart';
import 'features/authentication/domain/usecases/clear_auth_local.dart';
import 'features/authentication/domain/usecases/get_auth_local.dart';
import 'features/authentication/domain/usecases/post_login.dart';
import 'features/authentication/domain/usecases/set_auth_local.dart';
import 'features/authentication/presentation/cubits/authentication_cubit.dart';
import 'features/authentication/presentation/pages/signIn/cubit/sign_in_cubit.dart';

// Feature: Authentication


/*
import 'features/stock_type/presentation/cubits/stock_type_cubit.dart';
import 'features/stock_type/data/datasources/stock_type_remote_data_source.dart';
import 'features/stock_type/data/repositories/stock_type_respository_impl.dart';
import 'features/stock_type/domain/repositories/stock_type_respository.dart';
import 'features/stock_type/domain/usecases/get_stock_type_list.dart';

import 'features/forest_beat/presentation/cubits/forest_beat_cubit.dart';
import 'features/forest_beat/data/datasources/forest_beat_remote_data_source.dart';
import 'features/forest_beat/data/repositories/forest_beat_respository_impl.dart';
import 'features/forest_beat/domain/repositories/forest_beat_respository.dart';
import 'features/forest_beat/domain/usecases/get_forest_beat_list.dart';*/

/*
import 'features/raising/domain/repositories/media_respository.dart';
import 'features/raising/domain/usecases/upload_media.dart';
import 'features/raising/presentation/pages/purchase_form/cubit/purchase_form/purchase_form_cubit.dart';
*/

final sl = GetIt.instance;
/*

  initStockType();
  initBudget();
  initForestBeat();

  initProductCategory();
  initProduct();
  initPriceType();

  initPurchase();
  initSale();
  initOrder();
*/

Future<void> init() async {
  //! Features - Authentication
  initAuthentication();
  initDashboard();
  //initMyAccount();
  //initMyTeam();
  //initMyPerformance();
  //initMyCustomer();
  //initInsurancePlan();
  //initOccupation();

  //! Core
  sl.registerLazySingleton(() => HttpManager());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}

void initAuthentication() {
  // Cubit
  sl.registerFactory(() => AuthenticationCubit(sl(), sl(), sl()));
  sl.registerFactory(() => SignInCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetAuthLocal(sl()));
  sl.registerLazySingleton(() => SetAuthLocal(sl()));
  sl.registerLazySingleton(() => ClearAuthLocal(sl()));
  sl.registerLazySingleton(() => PostLogin(sl()));

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
        () => AuthenticationLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImpl(),
  );
}

//void initMyAccount() {
//  // Cubit
//  sl.registerFactory(() => MyAccountCubit(sl()));
//  sl.registerFactoryParam(
//      (param1, param2) => ChangePasswordCubit(sl(), param1 as PasswordInfo));
//  sl.registerFactory(() => ProfileImageUploadCubit(sl()));

//  // Use cases
//  sl.registerLazySingleton(() => GetMyAccount(sl()));
//  sl.registerLazySingleton(() => ChangePassword(sl()));
//  sl.registerLazySingleton(() => UploadProfileImage(sl()));

//  // Repository
//  sl.registerLazySingleton<PersonalInfoRepository>(
//      () => PersonalInfoRepositoryImpl(remoteDataSource: sl()));
//  sl.registerLazySingleton<ChangePasswordRepository>(
//      () => ChangePasswordRepositoryImpl(remoteDataSource: sl()));
//  sl.registerLazySingleton<ProfileImageRepository>(
//      () => ProfileImageRepositoryImpl(remoteDataSource: sl()));

//  // Data Sources
//  sl.registerLazySingleton<PersonalInfoRemoteDataSource>(
//    () => PersonalInfoRemoteDataSourceImpl(),
//  );
//  sl.registerLazySingleton<ChangePasswordRemoteDataSource>(
//    () => ChangePasswordRemoteDataSourceImpl(),
//  );
//  sl.registerLazySingleton<ProfileImageRemoteDataSource>(
//    () => ProfileImageRemoteDataSourceImpl(),
//  );
//}

//void initMyTeam() {
//  // Cubit
//  sl.registerFactory(() => MyTeamCubit(sl()));

//  // Use cases
//  sl.registerLazySingleton(() => GetMyTeam(sl()));
//  // Repository
//  sl.registerLazySingleton<MyTeamRepository>(
//      () => MyTeamRepositoryImpl(remoteDataSource: sl()));

//  // Data Sources
//  sl.registerLazySingleton<MyTeamRemoteDataSource>(
//    () => MyTeamRemoteDataSourceImpl(),
//  );
//}

//void initMyPerformance() {
//  // Cubit
//  sl.registerFactory(() => BusinessMonthCubit(sl()));
//  sl.registerFactory(() => BusinessYearCubit(sl()));
//  sl.registerFactory(() => SecondYearRatioCubit(sl()));
//  sl.registerFactory(() => MonthlyRankCubit(sl()));
//  sl.registerFactory(() => YearlyRankCubit(sl()));
//  sl.registerFactory(() => AllowanceMonthCubit(sl()));
//  sl.registerFactory(() => AllowanceQuarterCubit(sl()));
//  sl.registerFactory(() => RecruitmentMonthCubit(sl()));
//  sl.registerFactory(() => RecruitmentYearCubit(sl()));
//  sl.registerFactory(() => AllowanceQuarterDeffCubit(sl()));
//  sl.registerFactory(() => AllowanceQuarter2ndYearCubit(sl()));

//  // Use cases
//  sl.registerLazySingleton(() => GetBusinessMonth(sl()));
//  sl.registerLazySingleton(() => GetBusinessYear(sl()));
//  sl.registerLazySingleton(() => GetSecondYearRatio(sl()));
//  sl.registerLazySingleton(() => GetMonthlyRank(sl()));
//  sl.registerLazySingleton(() => GetYearlyRank(sl()));
//  sl.registerLazySingleton(() => GetAllowanceMonth(sl()));
//  sl.registerLazySingleton(() => GetAllowanceQuarter(sl()));
//  sl.registerLazySingleton(() => GetRecruitmentMonth(sl()));
//  sl.registerLazySingleton(() => GetRecruitmentYear(sl()));
//  sl.registerLazySingleton(() => GetAllowanceQuarterDeff(sl()));
//  sl.registerLazySingleton(() => GetAllowanceQuarter2ndYear(sl()));

//  // Repository
//  sl.registerLazySingleton<MyPerformanceRepository>(
//      () => MyPerformanceRepositoryImpl(remoteDataSource: sl()));

//  // Data Sources
//  sl.registerLazySingleton<MyPerformanceRemoteDataSource>(
//    () => MyPerformanceRemoteDataSourceImpl(),
//  );
//}

//void initMyCustomer() {
//  // Cubit
//  sl.registerFactoryParam(
//      (param1, param2) => QuotationFormCubit(sl(), sl(), param1));
//  sl.registerFactory(() => QuotationListCubit(sl()));
//  sl.registerFactory(() => QuotationDetailCubit(sl()));
//  //sl.registerFactoryParam((param1,param2) => QuotationDetailCubit(sl(),param1));
//  sl.registerFactory(() => ProposalSingleCubit(sl()));
//  sl.registerFactory(() => ImageUploadCubit(sl()));
//  sl.registerFactoryParam(
//      (param1, param2) => ImageQuotationCubit(sl(), param1));
//  sl.registerFactory(() => PolicyListCubit(sl()));
//  sl.registerFactory(() => PolicyLedgerCubit(sl()));

//  // Use cases
//  sl.registerLazySingleton(() => CalculatePremium(sl()));
//  sl.registerLazySingleton(() => CreateQuotation(sl()));
//  sl.registerLazySingleton(() => ListQuotations(sl()));
//  sl.registerLazySingleton(() => GetQuotation(sl()));
//  sl.registerLazySingleton(() => GetProposal(sl()));
//  sl.registerLazySingleton(() => UploadImage(sl()));
//  sl.registerLazySingleton(() => SubmitProposal(sl()));
//  sl.registerLazySingleton(() => ListPolicies(sl()));
//  sl.registerLazySingleton(() => GetPolicyLedger(sl()));

//  // Repository
//  sl.registerLazySingleton<QuotationRepository>(
//      () => QuotationRepositoryImpl(remoteDataSource: sl()));
//  sl.registerLazySingleton<ProposalRepository>(
//      () => ProposalRepositoryImpl(remoteDataSource: sl()));
//  sl.registerLazySingleton<ImageRepository>(
//      () => ImageRepositoryImpl(remoteDataSource: sl()));
//  sl.registerLazySingleton<PolicyRepository>(
//      () => PolicyRepositoryImpl(remoteDataSource: sl()));

//  // Data Sources
//  sl.registerLazySingleton<QuotationRemoteDataSource>(
//    () => QuotationRemoteDataSourceImpl(),
//  );
//  sl.registerLazySingleton<ProposalRemoteDataSource>(
//    () => ProposalRemoteDataSourceImpl(),
//  );
//  sl.registerLazySingleton<ImageRemoteDataSource>(
//    () => ImageRemoteDataSourceImpl(),
//  );
//  sl.registerLazySingleton<PolicyRemoteDataSource>(
//    () => PolicyRemoteDataSourceImpl(),
//  );
//}

//void initInsurancePlan() {
//  // Cubit
//  sl.registerFactory(() => InsurancePlanCubit(sl()));
//  sl.registerFactory(() => InsuranceTermCubit(sl()));
//  sl.registerFactory(() => ClassTypeCubit(sl()));

//  // Use cases
//  sl.registerLazySingleton(() => GetInsurancePlans(sl()));
//  sl.registerFactoryParam((param1, param2) => GetInsuranceTerms(sl(), param1));
//  sl.registerLazySingleton(() => GetClassTypes(sl()));

//  // Repository
//  sl.registerLazySingleton<InsurancePlanRepository>(
//      () => InsurancePlanRepositoryImpl(remoteDataSource: sl()));

//  // Data Sources
//  sl.registerLazySingleton<InsurancePlanRemoteDataSource>(
//    () => InsurancePlanRemoteDataSourceImpl(),
//  );
//}

//void initOccupation() {
//  // Cubit
//  sl.registerFactory(() => OccupationCubit(sl()));
//  sl.registerFactory(() => OccupationLevel2Cubit(sl()));

//  // Use cases
//  sl.registerLazySingleton(() => GetOccupationList(sl()));
//  sl.registerFactoryParam(
//      (param1, param2) => GetOccupationlevel2(sl(), param1));

//  // Repository
//  sl.registerLazySingleton<OccupationRepository>(
//      () => OccupationRepositoryImpl(remoteDataSource: sl()));

//  // Data Sources
//  sl.registerLazySingleton<OccupationRemoteDataSource>(
//    () => OccupationRemoteDataSourceImpl(),
//  );
//}

void initDashboard() {
  // Cubit
  /*sl.registerFactory(() => DashboardCubit(sl(),sl()));
  sl.registerFactoryParam((param1, param2) => CategoryStockCubit(sl(),sl(),sl(), param1));
  sl.registerFactoryParam((param1, param2) => ProductStockCubit(sl(),sl(),sl(), param1));
  sl.registerFactory(() => AllProductStockCubit(sl()));*/

  // Use cases
  /*sl.registerLazySingleton(() => GetDashboardStats(sl()));
  sl.registerLazySingleton(() => GetYearlyTotalStock(sl()));
  sl.registerLazySingleton(() => GetCategoryStockDivisionWise(sl()));
  sl.registerLazySingleton(() => GetCategoryStockRangeWise(sl()));
  sl.registerLazySingleton(() => GetCategoryStockBitWise(sl()));
  sl.registerLazySingleton(() => GetProductStockDivisionWise(sl()));
  sl.registerLazySingleton(() => GetProductStockRangeWise(sl()));
  sl.registerLazySingleton(() => GetProductStockBitWise(sl()));
  sl.registerLazySingleton(() => GetAllProductStock(sl()));*/

  // Repository
  /*sl.registerLazySingleton<DashboardRepository>(
          () => DashboardRepositoryImpl(remoteDataSource: sl())
  );*/

  // Data Sources
  /*sl.registerLazySingleton<DashboardRemoteDataSource>(
        () => DashboardRemoteDataSourceImpl(),
  );*/
}

/*void initStockType(){
  // Cubit
  sl.registerFactory(() => StockTypeCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetStockTypeList(sl()));

  // Repository
  sl.registerLazySingleton<StockTypeRepository>(
          () => StockTypeRepositoryImpl(remoteDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<StockTypeRemoteDataSource>(
        () => StockTypeRemoteDataSourceImpl(),
  );
}

void initBudget(){
  // Cubit
  sl.registerFactory(() => BudgetCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetBudgetList(sl()));

  // Repository
  sl.registerLazySingleton<BudgetRepository>(
          () => BudgetRepositoryImpl(remoteDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<BudgetRemoteDataSource>(
        () => BudgetRemoteDataSourceImpl(),
  );
}

void initForestBeat(){
  // Cubit
  sl.registerFactory(() => ForestBeatCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetForestBeatList(sl()));

  // Repository
  sl.registerLazySingleton<ForestBeatRepository>(
          () => ForestBeatRepositoryImpl(remoteDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<ForestBeatRemoteDataSource>(
        () => ForestBeatRemoteDataSourceImpl(),
  );
}

void initProductCategory(){
  // Cubit
  sl.registerFactory(() => ProductCategoryCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProductCategoryList(sl()));

  // Repository
  sl.registerLazySingleton<ProductCategoryRepository>(
          () => ProductCategoryRepositoryImpl(remoteDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<ProductCategoryRemoteDataSource>(
        () => ProductCategoryRemoteDataSourceImpl(),
  );
}

void initProduct(){
  // Cubit
  sl.registerFactory(() => ProductCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProductList(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
          () => ProductRepositoryImpl(remoteDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(),
  );
}

void initPriceType(){
  // Cubit
  sl.registerFactory(() => PriceTypeCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPriceTypeList(sl()));

  // Repository
  sl.registerLazySingleton<PriceTypeRepository>(
          () => PriceTypeRepositoryImpl(remoteDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<PriceTypeRemoteDataSource>(
        () => PriceTypeRemoteDataSourceImpl(),
  );
}

void initPurchase(){
  // Cubit
  sl.registerFactory(() => PurchaseListCubit(sl()));
  sl.registerFactoryParam((param1, param2) => PurchaseSingleCubit(sl(), param1));
  sl.registerFactoryParam((param1, param2) => PurchaseFormCubit(sl(),sl(),sl(),sl(), param1));
  sl.registerFactory(() => PurchaseApprovalCubit(sl(),sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPurchaseList(sl()));
  sl.registerLazySingleton(() => GetPurchaseSingle(sl()));
  sl.registerLazySingleton(() => CreatePurchase(sl()));
  sl.registerLazySingleton(() => UpdatePurchase(sl()));
  sl.registerLazySingleton(() => DeletePurchaseDetail(sl()));
  sl.registerLazySingleton(() => ApprovePurchase(sl()));
  sl.registerLazySingleton(() => DisapprovePurchase(sl()));
  // Repository
  sl.registerLazySingleton<PurchaseRepository>(
          () => PurchaseRepositoryImpl(remoteDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<PurchaseRemoteDataSource>(
        () => PurchaseRemoteDataSourceImpl(),
  );

}

void initSale(){
  // Cubit
  sl.registerFactory(() => SaleListCubit(sl()));
  sl.registerFactoryParam((param1, param2) => SaleSingleCubit(sl(), param1));
  sl.registerFactoryParam((param1, param2) => SaleFormCubit(sl(),sl(),sl(),sl(), param1));
  sl.registerFactory(() => SaleApprovalCubit(sl(),sl()));

  // Use cases
  sl.registerLazySingleton(() => GetSaleList(sl()));
  sl.registerLazySingleton(() => GetSaleSingle(sl()));
  sl.registerLazySingleton(() => CreateSale(sl()));
  sl.registerLazySingleton(() => UpdateSale(sl()));
  sl.registerLazySingleton(() => DeleteSaleDetail(sl()));
  sl.registerLazySingleton(() => ApproveSale(sl()));
  sl.registerLazySingleton(() => DisapproveSale(sl()));
  // Repository
  sl.registerLazySingleton<SaleRepository>(
          () => SaleRepositoryImpl(remoteDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<SaleRemoteDataSource>(
        () => SaleRemoteDataSourceImpl(),
  );

}

void initOrder(){
  *//*//*/ Cubit
  sl.registerFactory(() => OrderListCubit(sl()));
  sl.registerFactoryParam((param1, param2) => OrderSingleCubit(sl(), param1));
  //sl.registerFactoryParam((param1, param2) => PurchaseFormCubit(sl(),sl(),sl(),sl(), param1));
  //sl.registerFactory(() => PurchaseSingleCubit(_getSingle, purchase))
  //sl.registerFactory(() => CategoryListCubit(sl()));

  sl.registerFactory(() => EventCubit(sl()));

  sl.registerFactory(() => OrderStatusListCubit(sl()));
  sl.registerFactoryParam((param1, param2) => OrderStatusUpdateCubit(sl(), param1));


  // Use cases
  sl.registerLazySingleton(() => GetOrderList(sl()));
  sl.registerLazySingleton(() => GetOrderSingle(sl()));
  //sl.registerLazySingleton(() => CreateOrder(sl()));
  sl.registerLazySingleton(() => UpdateOrder(sl()));
  sl.registerLazySingleton(() => GetOrderEventList(sl()));
  sl.registerLazySingleton(() => GetOrderStatusList(sl()));
  sl.registerLazySingleton(() => UpdateOrderStatus(sl()));



  // Repository
  sl.registerLazySingleton<OrderRepository>(
          () => OrderRepositoryImpl(remoteDataSource: sl())
  );
  sl.registerLazySingleton<EventRepository>(
          () => EventRepositoryImpl(remoteDataSource: sl())
  );
  sl.registerLazySingleton<OrderStatusRepository>(
          () => OrderStatusRepositoryImpl(remoteDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<OrderRemoteDataSource>(
        () => OrderRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<EventRemoteDataSource>(
        () => EventRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<OrderStatusRemoteDataSource>(
        () => OrderStatusRemoteDataSourceImpl(),
  );*//*
}*/

*/
