import 'dart:async';
import 'dart:collection';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoaderService {
  final Queue<bool> _operations = new Queue<bool>();
  final _operationsStreamController = new StreamController<bool>();

  Stream<bool> get operations => _operationsStreamController.stream;

  setOperation(bool operationState) {
    _operationsStreamController.sink.add(operationState);

    if (operationState) {
      EasyLoading.show(status: 'loading...');
    } else {
      EasyLoading.dismiss();
    }
  }
}
