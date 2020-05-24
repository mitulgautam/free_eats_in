import 'package:flutter/foundation.dart';
import 'package:freeeatsin/core/model/dashboard_help_response_model.dart';

class HelpProvider with ChangeNotifier {
  DashboardHelpResponseModel _dashboardHelpResponseModel;

  DashboardHelpResponseModel get dashboardHelpResponseModel =>
      _dashboardHelpResponseModel;

  set dashboardHelpResponseModel(DashboardHelpResponseModel value) {
    _dashboardHelpResponseModel = value;
    notifyListeners();
  }
}
