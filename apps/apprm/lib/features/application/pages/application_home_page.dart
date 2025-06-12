import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:apprm/bootstrap/powersync.dart';
import 'package:apprm/constants/color.dart';
import 'package:apprm/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/get_object_item_usecase.dart';
import '../../../utils/crypt.dart';

class ApplicationHomePage extends StatefulWidget {
  const ApplicationHomePage({super.key, required this.appId});

  final String appId;

  @override
  State<ApplicationHomePage> createState() => _ApplicationHomePageState();
}

class _ApplicationHomePageState extends State<ApplicationHomePage> {
  late final List<({IconData icon, String title, String route})> objectListData;
  bool _secretVerified = false;
  bool _hasLocalSecret = false;

  Future<void> _promptAndSaveSecret(
      {required bool isNew, required String? encrypted}) async {
    while (true) {
      final controller = TextEditingController();
      final result = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(
              isNew ? 'Set Application Secret' : 'Enter Application Secret'),
          content: TextField(
            controller: controller,
            maxLength: 32,
            decoration: const InputDecoration(hintText: '32 character secret'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: const Text('Save'),
            ),
          ],
        ),
      );
      if (result == null) return;
      if (result.length != 32) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Secret must be 32 characters')));
        continue;
      }
      final prefs = await SharedPreferences.getInstance();
      final repo = ObjectRepository();
      final enc = executeEncrypt('application_secret', result);
      if (isNew) {
        await repo.updateObjectItem(
            tableName: 'applications',
            objectId: widget.appId,
            data: {'secret': enc});
      } else if (enc != encrypted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Invalid secret')));
        await prefs.remove('app_${widget.appId}_secret');
        continue;
      }
      await prefs.setString('app_${widget.appId}_secret', result);
      setState(() {
        _secretVerified = true;
        _hasLocalSecret = true;
      });
      break;
    }
  }

  Future<void> _checkSecret() async {
    final repo = ObjectRepository();
    final item = await repo.getObjectItem(
        tableName: 'applications', objectId: widget.appId);
    final encrypted = item['secret'] as String?;
    final prefs = await SharedPreferences.getInstance();
    final localSecret = prefs.getString('app_${widget.appId}_secret');
    setState(() {
      _hasLocalSecret = localSecret != null;
    });
    if (encrypted == null) {
      await _promptAndSaveSecret(isNew: true, encrypted: null);
      return;
    }
    if (localSecret == null ||
        executeEncrypt('application_secret', localSecret) != encrypted) {
      await prefs.remove('app_${widget.appId}_secret');
      setState(() {
        _secretVerified = false;
        _hasLocalSecret = false;
      });
      await _promptAndSaveSecret(isNew: false, encrypted: encrypted);
    } else {
      setState(() {
        _secretVerified = true;
      });
    }
  }

  @override
  void initState() {
    objectListData = [
      (
        icon: PhosphorIconsFill.asterisk,
        title: 'Requirements',
        route: '/app/${widget.appId}/internal/requirements'
      ),
      (
        icon: PhosphorIconsFill.treeStructure,
        title: 'Data Model',
        route: '/app/${widget.appId}/internal/data_objects'
      ),
      (
        icon: PhosphorIconsFill.chalkboard,
        title: 'Screens',
        route: '/app/${widget.appId}/internal/screens'
      ),
      (
        icon: PhosphorIconsFill.books,
        title: 'User Stories',
        route: '/app/${widget.appId}/internal/user_stories'
      ),
      (
        icon: PhosphorIconsFill.clock,
        title: 'Work Log',
        route: '/app/${widget.appId}/internal/work_logs'
      )
    ];

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSecret();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: QueryBuilder<Map<String, dynamic>>(
          query: Query(
            key: ['applications', 'item', widget.appId],
            queryFn: () async {
              return await GetObjectItemUseCase(
                objectRepository: ObjectRepository(),
              ).execute(
                GetObjectItemUseCaseParams(
                  objectType: 'applications',
                  objectId: widget.appId,
                ),
              );
            },
            config: QueryConfig(
              cacheDuration: Duration(seconds: 1),
              refetchDuration: Duration(seconds: 1),
              storeQuery: false,
            ),
          ),
          builder: (context, state) {
            return Text(state.data?['name'] ?? 'Home');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () async {
                await _checkSecret();
              },
              icon: Icon(
                _hasLocalSecret
                    ? PhosphorIconsFill.certificate
                    : PhosphorIconsBold.certificate,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () async {
                await logout();
                if (context.mounted) {
                  const AuthPageRoute().pushReplacement(context);
                }
              },
              icon: const Icon(PhosphorIconsBold.signOut),
            ),
          )
        ],
      ),
      body: _secretVerified
          ? ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, idx) {
                final objectData = objectListData[idx];
                return ListTile(
                  onTap: () {
                    context.push(objectData.route);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  selected: true,
                  selectedTileColor: Colors.white,
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(
                      objectData.icon,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                  ),
                  title: Text(objectData.title),
                  trailing: const Icon(
                    PhosphorIconsBold.caretRight,
                    size: 20,
                  ),
                );
              },
              separatorBuilder: (_, idx) => const SizedBox(height: 8),
              itemCount: objectListData.length,
            )
          : const Center(child: Text('Enter application secret to continue')),
    );
  }
}
