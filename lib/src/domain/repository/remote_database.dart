abstract class RemoteDataSourceInit {
  Future<dynamic> getRequest({required String url, Map<String, dynamic>? body,Map<String, dynamic>? customHeader});
  Future<dynamic> postRequest({
    required Map<String, dynamic> body,
    required String url,
  });
  Future<dynamic> patchRequest({
    required Map<String, dynamic> body,
    required String url,
  });
  Future<dynamic> deleteRequest({required String url});
}
