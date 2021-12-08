import 'package:example/services/bottom_nav_manager_mixin.dart';
import 'package:floater/floater.dart';
import 'full_screen_image_page.dart';

class FullScreenImagePageState extends WidgetStateBase<FullScreenImagePage> with BottomNavManagerMixin {
  FullScreenImagePageState() : super();

  void exitFullScreen() {
    this.currentNavigator.pop();
  }
}
