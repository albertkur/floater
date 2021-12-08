import 'package:example/pages/routes.dart';
import 'package:example/services/bottom_nav_manager_mixin.dart';
import 'package:floater/floater.dart';
import 'package:video_player/video_player.dart';
import 'image_list_page.dart';

class ImageListPageState extends WidgetStateBase<ImageListPage> with BottomNavManagerMixin {
  late final VideoPlayerController controller;

  ImageListPageState() : super() {
    onInitState(() {
      this.controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      );
      this.controller.initialize().then((_) {
        this.triggerStateChange();
        this.controller.play();
        this.controller.setLooping(true);
      });
    });

    this.onDispose(() {
      this.controller.dispose();
    });
  }

  void goToFullScreenImage() {
    this.currentNavigator.pushNamed(Routes.fullScreenImage);
  }

  void goToFullScreenVideo() {
    this.currentNavigator.pushNamed(
      NavigationService.instance.generateRoute(Routes.fullScreenVideo),
      arguments: {
        "controller": this.controller,
      },
    );
  }
}
