import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/pages/auth0_login_page.dart';
import 'features/auth/pages/auth_page.dart';
import 'features/auth/pages/azure_b2c_login_page.dart';
import 'features/auth/pages/supabase_login_page.dart';
import 'features/auth/pages/supabase_signup_page.dart';
import 'features/application/pages/application_listing_page.dart';
import 'features/application/pages/application_home_page.dart';
import 'features/application/pages/application_adding_page.dart';
import 'features/home/pages/home_page.dart';
import 'features/work_log/pages/work_log_listing_page.dart';
import 'features/history/pages/history_listing_page.dart';
import 'features/notification/pages/powersync_debug_page.dart';
import 'features/admin/pages/admin_page.dart';
import 'features/object/pages/external_object_detail_page.dart';
import 'features/object/pages/external_object_listing_page.dart';
import 'features/object/pages/object_adding_page.dart';
import 'features/object/pages/object_detail_page.dart';
import 'features/object/pages/object_listing_page.dart';
import 'features/object/pages/object_updating_page.dart';
import 'features/screens/pages/screen_element_adding_page.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final rootRouter = GoRouter(
  initialLocation: const AuthPageRoute().location,
  routes: $appRoutes,
  navigatorKey: rootNavigatorKey,
  redirect: (context, state) {
    final bool onAuthPage = state.location.startsWith('/auth');
    final isAuthenticated =
        Supabase.instance.client.auth.currentSession != null;

    if (isAuthenticated && onAuthPage) {
      return HomeRoute().location;
    }

    return null;
  },
);

@TypedGoRoute<AuthPageRoute>(
  path: '/auth',
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<SupabaseSignUpRoute>(
      path: 'sign-up',
    ),
    TypedGoRoute<SupabaseLoginRoute>(
      path: 'login',
    ),
    TypedGoRoute<AzureB2CLoginRoute>(
      path: 'login-azure',
    ),
    TypedGoRoute<Auth0LoginRoute>(
      path: 'login-auth0',
    ),
  ],
)
class AuthPageRoute extends GoRouteData {
  const AuthPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AuthPage();
  }
}

class SupabaseSignUpRoute extends GoRouteData {
  const SupabaseSignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SupabaseSignUpPage();
  }
}

class SupabaseLoginRoute extends GoRouteData {
  const SupabaseLoginRoute({this.email});

  final String? email;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SupabaseLoginPage(email: email);
  }
}

class AzureB2CLoginRoute extends GoRouteData {
  const AzureB2CLoginRoute({this.email});

  final String? email;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AzureB2CLoginPage(email: email);
  }
}

class Auth0LoginRoute extends GoRouteData {
  const Auth0LoginRoute({this.email});

  final String? email;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Auth0LoginPage(email: email);
  }
}

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@TypedGoRoute<ApplicationHomeRoute>(
  path: '/app/:appId',
)
class ApplicationHomeRoute extends GoRouteData {
  const ApplicationHomeRoute({required this.appId});

  final String appId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ApplicationHomePage(appId: appId);
  }
}

@TypedGoRoute<ApplicationListingRoute>(
  path: '/applications',
)
class ApplicationListingRoute extends GoRouteData {
  const ApplicationListingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ApplicationListingPage();
  }
}

@TypedGoRoute<ApplicationAddingRoute>(
  path: '/applications/add',
)
class ApplicationAddingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ApplicationAddingPage();
  }
}

@TypedGoRoute<WorkLogListingRoute>(
  path: '/work_logs',
)
class WorkLogListingRoute extends GoRouteData {
  const WorkLogListingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WorkLogListingPage();
  }
}

@TypedGoRoute<HistoryListingRoute>(
  path: '/history',
)
class HistoryListingRoute extends GoRouteData {
  const HistoryListingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HistoryListingPage();
  }
}

@TypedGoRoute<AdminRoute>(
  path: '/admin',
)
class AdminRoute extends GoRouteData {
  const AdminRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminPage();
  }
}

@TypedGoRoute<ObjectListingRoute>(
  path: '/app/:appId/internal/:objectType',
  routes: [
    TypedGoRoute<ObjectAddingRoute>(
      path: 'add',
    ),
    TypedGoRoute<ObjectDetailRoute>(
      path: ':objectId',
      routes: [
        TypedGoRoute<ObjectUpdatingRoute>(
          path: 'update',
        )
      ],
    )
  ],
)
class ObjectListingRoute extends GoRouteData {
  ObjectListingRoute({required this.appId, required this.objectType});

  final String appId;
  final String objectType;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ObjectListingPage();
  }
}

class ObjectAddingRoute extends GoRouteData {
  ObjectAddingRoute({required this.appId, required this.objectType});

  final String appId;
  final String objectType;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ObjectAddingPage();
  }
}

class ObjectDetailRoute extends GoRouteData {
  ObjectDetailRoute(
      {required this.appId, required this.objectType, required this.objectId});

  final String appId;
  final String objectType;
  final String objectId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ObjectDetailPage();
  }
}

class ObjectUpdatingRoute extends GoRouteData {
  ObjectUpdatingRoute(
      {required this.appId, required this.objectType, required this.objectId});

  final String appId;
  final String objectType;
  final String objectId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ObjectUpdatingPage(objectId: objectId);
  }
}

@TypedGoRoute<ScreenElementAddingRoute>(
  path: '/app/:appId/screens/:screenId/elements/add',
)
class ScreenElementAddingRoute extends GoRouteData {
  const ScreenElementAddingRoute({required this.appId, required this.screenId});

  final String appId;
  final String screenId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ScreenElementAddingPage(appId: appId, screenId: screenId);
  }
}

@TypedGoRoute<ExternalObjectListingRoute>(
  path: '/external/:externalObjectType',
  routes: [
    TypedGoRoute<ExternalObjectDetailRoute>(
      path: ':externalObjectId',
    ),
  ],
)
class ExternalObjectListingRoute extends GoRouteData {
  ExternalObjectListingRoute({
    required this.externalObjectType,
    this.objectType,
    this.objectId,
  });

  final String externalObjectType;
  final String? objectType;
  final String? objectId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ExternalObjectListingPage(externalObjectType: externalObjectType);
  }
}

class ExternalObjectDetailRoute extends GoRouteData {
  ExternalObjectDetailRoute({
    required this.externalObjectType,
    required this.externalObjectId,
    this.objectType,
    this.objectId,
  });

  final String externalObjectType;
  final String externalObjectId;
  final String? objectType;
  final String? objectId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ExternalObjectDetailPage(
      externalObjectType: externalObjectType,
      externalObjectId: externalObjectId,
    );
  }
}

@TypedGoRoute<NotificationRoute>(
  path: '/notification',
)
class NotificationRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PowerSyncDebugPage();
  }
}
