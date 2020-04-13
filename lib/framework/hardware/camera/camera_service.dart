import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

@injectable
@lazySingleton
class CameraService {
  CameraController controller;
  Future<void> initializeControllerFuture;

  CameraService() {}

  Future<void> initializeCamera(Function() whenMounted) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    controller = CameraController(
      firstCamera,
      ResolutionPreset.max,
    );

    // Next, initialize the controller. This returns a Future.
    initializeControllerFuture = controller.initialize();
  }

  Future<String> takePicture() async {
    try {
      await initializeControllerFuture;

      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      await controller.takePicture(path);

      return path;
    } catch (e) {
      print(e);
    }
  }
}
