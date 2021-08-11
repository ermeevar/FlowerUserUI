import 'package:flower_user_ui/app/router.gr.dart';
import 'package:flower_user_ui/presentation/viewmodels/application_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ApplicationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicationViewModel>.nonReactive(
      viewModelBuilder: () => ApplicationViewModel(),
      builder: (context, viewModel, child) => FutureBuilder(
        future: viewModel.initialise(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            return MaterialRouter(
              router: viewModel.router,
              theme: viewModel.themeService.light,
            );
          } else {
            return const LoadingView();
          }
        },
      ),
    );
  }
}

class MaterialRouter extends StatelessWidget {
  const MaterialRouter({Key? key, required this.router, required this.theme})
      : super(key: key);

  final AppRouter router;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Нет сети",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator.adaptive(),
              Text(
                "Загрузка...",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
