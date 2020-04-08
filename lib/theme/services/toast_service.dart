import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/theme/colors.dart';

@injectable
class ToastService {
  show(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundNoteMeColor,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
}
