import 'package:example/services/bottom_nav_manager_mixin.dart';
import 'package:floater/floater.dart';
import 'full_screen_video_page.dart';

class FullScreenVideoPageState extends WidgetStateBase<FullScreenVideoPage> with BottomNavManagerMixin {
  FullScreenVideoPageState() : super();

  void exitFullScreen() {
    this.currentNavigator.pop();
  }
}
