import 'package:flutter/material.dart';
import 'package:powersync/powersync.dart' as powersync;
import '../../../bootstrap/powersync.dart' show db;
import '../../../attachments/queue.dart';
import 'package:powersync_attachments_helper/powersync_attachments_helper.dart';

class PowerSyncDebugPage extends StatefulWidget {
  const PowerSyncDebugPage({Key? key}) : super(key: key);

  @override
  State<PowerSyncDebugPage> createState() => _PowerSyncDebugPageState();
}

class _PowerSyncDebugPageState extends State<PowerSyncDebugPage> {
  List<String> _tables = [];
  String? _selectedTable;
  Stream<List<Map<String, dynamic>>>? _tableDataStream;

  @override
  void initState() {
    super.initState();
    _loadTables();
  }

  Future<void> _loadTables() async {
    final schema = db.schema;
    setState(() {
      _tables = schema.tables.map((table) => table.name).toList();
    });
  }

  void _loadTableData(String tableName) {
    setState(() {
      _selectedTable = tableName;
      _tableDataStream = db.watch('SELECT * FROM $tableName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DB Sniffer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (_selectedTable != null) {
                _loadTableData(_selectedTable!);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Sync Status
          StreamBuilder<powersync.SyncStatus>(
            stream: db.statusStream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sync Status: ${snapshot.data?.toString() ?? 'Unknown'}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            },
          ),
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: db.watch(
                'SELECT * FROM ${attachmentQueue.attachmentsService.table} ORDER BY timestamp DESC'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                );
              }
              final attachments = snapshot.data!;
              if (attachments.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Attachment queue empty'),
                );
              }
              return Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('id')),
                        DataColumn(label: Text('state')),
                        DataColumn(label: Text('filename')),
                      ],
                      rows: attachments.map((row) {
                        final stateIndex = row['state'] as int? ?? 0;
                        final stateName = AttachmentState.values[stateIndex]
                            .toString()
                            .split('.')
                            .last;
                        return DataRow(cells: [
                          DataCell(Text(row['id'].toString())),
                          DataCell(Text(stateName)),
                          DataCell(Text(row['filename'].toString())),
                        ]);
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      await attachmentQueue.attachmentsService.clearQueue();
                    },
                    child: const Text('Clear Attachment Queue'),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Select a table'),
              value: _selectedTable,
              items: _tables.map((String table) {
                return DropdownMenuItem<String>(
                  value: table,
                  child: Text(table),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _loadTableData(newValue);
                }
              },
            ),
          ),
          Expanded(
            child: _tableDataStream == null
                ? const Center(
                    child: Text('Select a table to view its data'),
                  )
                : StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _tableDataStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: [${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final tableData = snapshot.data!;

                      if (tableData.isEmpty) {
                        return const Center(
                          child: Text('No data in table'),
                        );
                      }

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: tableData.first.keys
                                .map((key) => DataColumn(label: Text(key)))
                                .toList(),
                            rows: tableData.map((row) {
                              return DataRow(
                                cells: row.values
                                    .map((value) => DataCell(
                                          Text(value?.toString() ?? 'null'),
                                        ))
                                    .toList(),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
