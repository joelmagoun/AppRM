import 'package:powersync/powersync.dart';
import 'package:powersync_attachments_helper/powersync_attachments_helper.dart';

Schema schema = Schema(
  [
    const Table(
      'locations',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('type'),
        Column.text('country'),
        Column.text('state'),
        Column.text('streetAddress'),
        Column.text('city'),
      ],
      indexes: [
        Index('locations_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'profile',
      [
        Column.text('id'),
        Column.text('email'),
        Column.text('name'),
        Column.text('role'),
      ],
      indexes: [
        Index('profile_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'people',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('first'),
        Column.text('last'),
        Column.text('jobTitle'),
        Column.text('location'),
        Column.text('email'),
      ],
      indexes: [
        Index('people_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'cars',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('vinNumber'),
        Column.text('make'),
        Column.text('year'),
        Column.text('model'),
      ],
      indexes: [
        Index('cars_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'linked_objects',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('parent_object_type'),
        Column.text('child_object_type'),
        Column.text('parent_object_id'),
        Column.text('child_object_id'),
      ],
      indexes: [
        Index('linked_objects_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'sap_system_users',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('username_sap'),
        Column.text('first_name'),
        Column.text('last_name'),
        Column.text('job_title'),
        Column.text('email'),
        Column.text('start_date_sap'),
        Column.text('end_date_sap'),
      ],
      indexes: [
        Index('sap_system_users_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'adp_system_users',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('username_adp'),
        Column.text('first_name'),
        Column.text('last_name'),
        Column.text('job_title'),
        Column.text('email'),
        Column.text('start_date_adp'),
        Column.text('end_date_adp'),
      ],
      indexes: [
        Index('adp_system_users_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'notifications',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('message'),
        Column.text('user_id'),
        Column.text('job_id'),
        Column.text('read_at'),
      ],
      indexes: [
        Index('notifications_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'requirements',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('app_id'),
        Column.text('requirement'),
        Column.text('description'),
        Column.text('completed'),
        Column.text('completed_at'),
      ],
      indexes: [
        Index('requirements_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'stories',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('app_id'),
        Column.text('name'),
        Column.text('description'),
      ],
      indexes: [
        Index('stories_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'data_objects',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('app_id'),
        Column.text('name'),
        Column.text('description'),
      ],
      indexes: [
        Index('data_objects_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'data_fields',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('app_id'),
        Column.text('data_object'),
        Column.text('name'),
        Column.text('description'),
        Column.text('type'),
        Column.text('default_value'),
      ],
      indexes: [
        Index('data_fields_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'screens',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('app_id'),
        Column.text('name'),
        Column.text('description'),
      ],
      indexes: [
        Index('screens_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'screen_photos',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('app_id'),
        Column.text('screen_id'),
        Column.text('name'),
        Column.text('description'),
        Column.text('path'),
        Column.text('photo_id'),
      ],
      indexes: [
        Index('screen_photos_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'screen_functions',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('app_id'),
        Column.text('screen_id'),
        Column.text('name'),
        Column.text('description'),
      ],
      indexes: [
        Index('screen_functions_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'elements',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('name'),
        Column.text('description'),
      ],
      indexes: [
        Index('elements_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'screen_elements',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('screen_id'),
        Column.text('element_id'),
      ],
      indexes: [
        Index('screen_elements_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'element_photos',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('element_id'),
        Column.text('name'),
        Column.text('description'),
        Column.text('photo_id'),
      ],
      indexes: [
        Index('element_photos_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'data_links',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('function_id'),
        Column.text('object_id'),
        Column.text('read_write'),
      ],
      indexes: [
        Index('data_links_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'navigations',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('navigation_from'),
        Column.text('navigation_from_type'),
        Column.text('navigation_to'),
        Column.text('navigation_to_type'),
      ],
      indexes: [
        Index('navigations_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'user_stories',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('app_id'),
        Column.text('name'),
        Column.text('description'),
      ],
      indexes: [
        Index('user_stories_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'work_logs',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('app_id'),
        Column.text('user_id'),
        Column.text('amount'),
        Column.text('description'),
      ],
      indexes: [
        Index('work_logs_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'applications',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('name'),
        Column.text('description'),
        Column.text('secret'),
      ],
      indexes: [
        Index('applications_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'application_users',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('app_id'),
        Column.text('user_id'),
      ],
      indexes: [
        Index('application_users_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'actions',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('user_id'),
        Column.text('action'),
        Column.text('params'),
        Column.text('status'),
        Column.text('external_object_type'),
        Column.text('external_object_id'),
      ],
      indexes: [
        Index('notifications_list', [IndexedColumn('id')])
      ],
    ),
    const Table(
      'history',
      [
        Column.text('id'),
        Column.text('created_at'),
        Column.text('app_id'),
        Column.text('user_id'),
        Column.text('message'),
      ],
      indexes: [
        Index('history_list', [IndexedColumn('id')])
      ],
    ),
    AttachmentsQueueTable(
      attachmentsQueueTableName: defaultAttachmentsQueueTableName,
    )
  ],
);
