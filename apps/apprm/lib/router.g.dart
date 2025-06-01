// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $authPageRoute,
      $homeRoute,
      $objectListingRoute,
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

RouteBase get $objectListingRoute => GoRouteData.$route(
      path: '/internal/:objectType',
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
        objectType: state.pathParameters['objectType']!,
      );

  String get location => GoRouteData.$location(
        '/internal/${Uri.encodeComponent(objectType)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ObjectAddingRouteExtension on ObjectAddingRoute {
  static ObjectAddingRoute _fromState(GoRouterState state) => ObjectAddingRoute(
        objectType: state.pathParameters['objectType']!,
      );

  String get location => GoRouteData.$location(
        '/internal/${Uri.encodeComponent(objectType)}/add',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ObjectDetailRouteExtension on ObjectDetailRoute {
  static ObjectDetailRoute _fromState(GoRouterState state) => ObjectDetailRoute(
        objectType: state.pathParameters['objectType']!,
        objectId: state.pathParameters['objectId']!,
      );

  String get location => GoRouteData.$location(
        '/internal/${Uri.encodeComponent(objectType)}/${Uri.encodeComponent(objectId)}',
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
        objectType: state.pathParameters['objectType']!,
        objectId: state.pathParameters['objectId']!,
      );

  String get location => GoRouteData.$location(
        '/internal/${Uri.encodeComponent(objectType)}/${Uri.encodeComponent(objectId)}/update',
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
