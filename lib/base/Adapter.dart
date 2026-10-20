import 'package:flutter_application_api/base/Response.dart';

abstract interface class Adapter<I, O> {
  Response<O> execute(I input);
}