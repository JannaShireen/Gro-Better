import 'package:flutter/material.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/shared/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class ZegoServices {
  BuildContext ctx;
  ZegoServices({required this.ctx});

  void onUserLogin() {
    final user = Provider.of<UserProvider>(ctx).getUser;
    String uid = user?.uid ?? '';
    String userName = user?.name ?? '';

    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: Utils().appId,
      appSign: Utils().appSign,
      userID: uid,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  void onUserLogout() {
    /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged out
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}
