class ApiResponse {
//  _data will hold any response converted into it's own object . our case 'user'

  late Object _data;
//  apiError will hold the error response
  late Object _apiError;

  Object get Data => _data;
  set Data(Object data) => _data = data;

  Object get ApiError => _apiError as Object;
  set ApiError(Object error) => _apiError = error;
}