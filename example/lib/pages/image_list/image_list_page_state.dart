import 'package:example/pages/routes.dart';
import 'package:example/services/bottom_nav_manager_mixin.dart';
import 'package:floater/floater.dart';
import 'image_list_page.dart';

class ImageListPageState extends WidgetStateBase<ImageListPage> with BottomNavManagerMixin {
  ImageListPageState() : super();

  void goToFullScreen() {
    this.currentNavigator.pushNamed(Routes.fullScreenImage);
  }
}
