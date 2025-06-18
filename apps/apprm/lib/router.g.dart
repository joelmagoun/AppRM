// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $authPageRoute,
      $homeRoute,
      $applicationHomeRoute,
      $applicationListingRoute,
      $applicationAddingRoute,
      $workLogListingRoute,
      $historyListingRoute,
      $adminRoute,
      $objectListingRoute,
      $screenElementAddingRoute,
      $userStoryStepAddingRoute,
      $stepActionDetailRoute,
      $externalObjectListingRoute,
      $notificationRoute,
    ];

RouteBase get $authPageRoute => GoRouteData.$route(
      path: '/auth',
      factory: $AuthPageRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'sign-up',
          factory: $SupabaseSignUpRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'login',
          factory: $SupabaseLoginRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'login-azure',
          factory: $AzureB2CLoginRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'login-auth0',
          factory: $Auth0LoginRouteExtension._fromState,
        ),
      ],
    );

extension $AuthPageRouteExtension on AuthPageRoute {
  static AuthPageRoute _fromState(GoRouterState state) => const AuthPageRoute();

  String get location => GoRouteData.$location(
        '/auth',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SupabaseSignUpRouteExtension on SupabaseSignUpRoute {
  static SupabaseSignUpRoute _fromState(GoRouterState state) =>
      const SupabaseSignUpRoute();

  String get location => GoRouteData.$location(
        '/auth/sign-up',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SupabaseLoginRouteExtension on SupabaseLoginRoute {
  static SupabaseLoginRoute _fromState(GoRouterState state) =>
      SupabaseLoginRoute(
        email: state.queryParameters['email'],
      );

  String get location => GoRouteData.$location(
        '/auth/login',
        queryParams: {
          if (email != null) 'email': email,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AzureB2CLoginRouteExtension on AzureB2CLoginRoute {
  static AzureB2CLoginRoute _fromState(GoRouterState state) =>
      AzureB2CLoginRoute(
        email: state.queryParameters['email'],
      );

  String get location => GoRouteData.$location(
        '/auth/login-azure',
        queryParams: {
          if (email != null) 'email': email,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $Auth0LoginRouteExtension on Auth0LoginRoute {
  static Auth0LoginRoute _fromState(GoRouterState state) => Auth0LoginRoute(
        email: state.queryParameters['email'],
      );

  String get location => GoRouteData.$location(
        '/auth/login-auth0',
        queryParams: {
          if (email != null) 'email': email,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $applicationHomeRoute => GoRouteData.$route(
      path: '/app/:appId',
      factory: $ApplicationHomeRouteExtension._fromState,
    );

extension $ApplicationHomeRouteExtension on ApplicationHomeRoute {
  static ApplicationHomeRoute _fromState(GoRouterState state) =>
      ApplicationHomeRoute(
        appId: state.pathParameters['appId']!,
      );

  String get location => GoRouteData.$location(
        '/app/${Uri.encodeComponent(appId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $applicationListingRoute => GoRouteData.$route(
      path: '/applications',
      factory: $ApplicationListingRouteExtension._fromState,
    );

extension $ApplicationListingRouteExtension on ApplicationListingRoute {
  static ApplicationListingRoute _fromState(GoRouterState state) =>
      const ApplicationListingRoute();

  String get location => GoRouteData.$location(
        '/applications',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $applicationAddingRoute => GoRouteData.$route(
      path: '/applications/add',
      factory: $ApplicationAddingRouteExtension._fromState,
    );

extension $ApplicationAddingRouteExtension on ApplicationAddingRoute {
  static ApplicationAddingRoute _fromState(GoRouterState state) =>
      ApplicationAddingRoute();

  String get location => GoRouteData.$location(
        '/applications/add',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $workLogListingRoute => GoRouteData.$route(
      path: '/work_logs',
      factory: $WorkLogListingRouteExtension._fromState,
    );

extension $WorkLogListingRouteExtension on WorkLogListingRoute {
  static WorkLogListingRoute _fromState(GoRouterState state) =>
      const WorkLogListingRoute();

  String get location => GoRouteData.$location(
        '/work_logs',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $historyListingRoute => GoRouteData.$route(
      path: '/history',
      factory: $HistoryListingRouteExtension._fromState,
    );

extension $HistoryListingRouteExtension on HistoryListingRoute {
  static HistoryListingRoute _fromState(GoRouterState state) =>
      const HistoryListingRoute();

  String get location => GoRouteData.$location(
        '/history',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminRoute => GoRouteData.$route(
      path: '/admin',
      factory: $AdminRouteExtension._fromState,
    );

extension $AdminRouteExtension on AdminRoute {
  static AdminRoute _fromState(GoRouterState state) => const AdminRoute();

  String get location => GoRouteData.$location(
        '/admin',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $objectListingRoute => GoRouteData.$route(
      path: '/app/:appId/internal/:objectType',
      factory: $ObjectListingRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'add',
          factory: $ObjectAddingRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: ':objectId',
          factory: $ObjectDetailRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'update',
              factory: $ObjectUpdatingRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $ObjectListingRouteExtension on ObjectListingRoute {
  static ObjectListingRoute _fromState(GoRouterState state) =>
      ObjectListingRoute(
        appId: state.pathParameters['appId']!,
        objectType: state.pathParameters['objectType']!,
      );

  String get location => GoRouteData.$location(
        '/app/${Uri.encodeComponent(appId)}/internal/${Uri.encodeComponent(objectType)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ObjectAddingRouteExtension on ObjectAddingRoute {
  static ObjectAddingRoute _fromState(GoRouterState state) => ObjectAddingRoute(
        appId: state.pathParameters['appId']!,
        objectType: state.pathParameters['objectType']!,
      );

  String get location => GoRouteData.$location(
        '/app/${Uri.encodeComponent(appId)}/internal/${Uri.encodeComponent(objectType)}/add',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ObjectDetailRouteExtension on ObjectDetailRoute {
  static ObjectDetailRoute _fromState(GoRouterState state) => ObjectDetailRoute(
        appId: state.pathParameters['appId']!,
        objectType: state.pathParameters['objectType']!,
        objectId: state.pathParameters['objectId']!,
      );

  String get location => GoRouteData.$location(
        '/app/${Uri.encodeComponent(appId)}/internal/${Uri.encodeComponent(objectType)}/${Uri.encodeComponent(objectId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ObjectUpdatingRouteExtension on ObjectUpdatingRoute {
  static ObjectUpdatingRoute _fromState(GoRouterState state) =>
      ObjectUpdatingRoute(
        appId: state.pathParameters['appId']!,
        objectType: state.pathParameters['objectType']!,
        objectId: state.pathParameters['objectId']!,
      );

  String get location => GoRouteData.$location(
        '/app/${Uri.encodeComponent(appId)}/internal/${Uri.encodeComponent(objectType)}/${Uri.encodeComponent(objectId)}/update',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $screenElementAddingRoute => GoRouteData.$route(
      path: '/app/:appId/screens/:screenId/elements/add',
      factory: $ScreenElementAddingRouteExtension._fromState,
    );

extension $ScreenElementAddingRouteExtension on ScreenElementAddingRoute {
  static ScreenElementAddingRoute _fromState(GoRouterState state) =>
      ScreenElementAddingRoute(
        appId: state.pathParameters['appId']!,
        screenId: state.pathParameters['screenId']!,
      );

  String get location => GoRouteData.$location(
        '/app/${Uri.encodeComponent(appId)}/screens/${Uri.encodeComponent(screenId)}/elements/add',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $userStoryStepAddingRoute => GoRouteData.$route(
      path: '/app/:appId/user_stories/:storyId/steps/add',
      factory: $UserStoryStepAddingRouteExtension._fromState,
    );

extension $UserStoryStepAddingRouteExtension on UserStoryStepAddingRoute {
  static UserStoryStepAddingRoute _fromState(GoRouterState state) =>
      UserStoryStepAddingRoute(
        appId: state.pathParameters['appId']!,
        storyId: state.pathParameters['storyId']!,
      );

  String get location => GoRouteData.$location(
        '/app/${Uri.encodeComponent(appId)}/user_stories/${Uri.encodeComponent(storyId)}/steps/add',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $stepActionDetailRoute => GoRouteData.$route(
      path: '/app/:appId/step_actions/:actionId',
      factory: $StepActionDetailRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'update',
          factory: $StepActionUpdatingRouteExtension._fromState,
        ),
      ],
    );

extension $StepActionDetailRouteExtension on StepActionDetailRoute {
  static StepActionDetailRoute _fromState(GoRouterState state) =>
      StepActionDetailRoute(
        appId: state.pathParameters['appId']!,
        actionId: state.pathParameters['actionId']!,
      );

  String get location => GoRouteData.$location(
        '/app/${Uri.encodeComponent(appId)}/step_actions/${Uri.encodeComponent(actionId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StepActionUpdatingRouteExtension on StepActionUpdatingRoute {
  static StepActionUpdatingRoute _fromState(GoRouterState state) =>
      StepActionUpdatingRoute(
        appId: state.pathParameters['appId']!,
        actionId: state.pathParameters['actionId']!,
      );

  String get location => GoRouteData.$location(
        '/app/${Uri.encodeComponent(appId)}/step_actions/${Uri.encodeComponent(actionId)}/update',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $externalObjectListingRoute => GoRouteData.$route(
      path: '/external/:externalObjectType',
      factory: $ExternalObjectListingRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: ':externalObjectId',
          factory: $ExternalObjectDetailRouteExtension._fromState,
        ),
      ],
    );

extension $ExternalObjectListingRouteExtension on ExternalObjectListingRoute {
  static ExternalObjectListingRoute _fromState(GoRouterState state) =>
      ExternalObjectListingRoute(
        externalObjectType: state.pathParameters['externalObjectType']!,
        objectType: state.queryParameters['object-type'],
        objectId: state.queryParameters['object-id'],
      );

  String get location => GoRouteData.$location(
        '/external/${Uri.encodeComponent(externalObjectType)}',
        queryParams: {
          if (objectType != null) 'object-type': objectType,
          if (objectId != null) 'object-id': objectId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ExternalObjectDetailRouteExtension on ExternalObjectDetailRoute {
  static ExternalObjectDetailRoute _fromState(GoRouterState state) =>
      ExternalObjectDetailRoute(
        externalObjectType: state.pathParameters['externalObjectType']!,
        externalObjectId: state.pathParameters['externalObjectId']!,
        objectType: state.queryParameters['object-type'],
        objectId: state.queryParameters['object-id'],
      );

  String get location => GoRouteData.$location(
        '/external/${Uri.encodeComponent(externalObjectType)}/${Uri.encodeComponent(externalObjectId)}',
        queryParams: {
          if (objectType != null) 'object-type': objectType,
          if (objectId != null) 'object-id': objectId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $notificationRoute => GoRouteData.$route(
      path: '/notification',
      factory: $NotificationRouteExtension._fromState,
    );

extension $NotificationRouteExtension on NotificationRoute {
  static NotificationRoute _fromState(GoRouterState state) =>
      NotificationRoute();

  String get location => GoRouteData.$location(
        '/notification',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
