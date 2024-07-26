import 'package:dio/dio.dart';

import '../../config/app.dart';
import '../../config/routes.dart';
import '../../main.dart';

class HttpManager {
 static String token = '';

 final _dio = Dio();

 HttpManager() {
   _dio.options.baseUrl = eDokanAppConfig.apiBase;

   _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
     //log(options.path.contains("UploadPhoto").toString());
     if (options.path.contains("FileUpload") == true ||
         options.path.contains("UploadPhoto") == true) {
       //log('got it');
       //log(options.path);
       //options.headers['Content-Type'] = "multipart/form-data";
       options.contentType = Headers.multipartFormDataContentType;
     } else {
       options.headers['Content-Type'] = "application/json";
     }
     options.headers["Authorization"] = "Bearer $token";
     //log(options.headers.toString());
     //DioLogger.onSend(tag, options);
     handler.next(options);
   }, onResponse: (Response response, handler) {
     //DioLogger.onSuccess(tag, response);
     return handler.next(response);
   }, onError: (DioError error, handler) {
     //log(error.response?.data.toString() ?? "NA");
     if (error.response?.statusCode == 401) {
       navigatorKey.currentState
           ?.pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false);
       //AuthenticationBloc().logout();
       return;
     }
     return handler.next(error);
   }));
 }

 Dio get client => _dio;
}
