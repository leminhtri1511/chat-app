import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../intl/generated/l10n.dart';
import 'base_viewmodel.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  /*
    child, childDesktop, childMobile, childTablet:
    Its widget not listen on consumer
    Use to paint to widget not change(Appbar, background....)
   */
  final Widget? child;

  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;
  final T viewModel;
  final Function(T? viewModel)? onViewModelReady;

  const BaseWidget({
    required this.viewModel,
    required this.builder,
    Key? key,
    this.child,
    this.onViewModelReady,
  }) : super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {
  T? viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel;
    if (widget.onViewModelReady != null) widget.onViewModelReady!(viewModel);
    super.initState();
    // S.load(
    //   const Locale('vi'),
    // );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: true,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    //Setting SystmeUIMode
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );

    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Theme.of(context).colorScheme.background,
    //   ),
    // );
    return WillPopScope(
      onWillPop: () => viewModel!.exitApp(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: ChangeNotifierProvider<T>(
            create: (context) => viewModel!..setContext(context),
            child: Consumer<T>(builder: widget.builder, child: widget.child),
          ),
        ),
      ),
    );
  }
}
