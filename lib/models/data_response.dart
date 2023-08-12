class DataResponse<T> { }

class Success<T> extends DataResponse<T> {
  dynamic data;
  Success(this.data);
}

class Failed extends DataResponse<dynamic> {
  String message;
  Failed(this.message);
}

class Loading extends DataResponse<dynamic>{}