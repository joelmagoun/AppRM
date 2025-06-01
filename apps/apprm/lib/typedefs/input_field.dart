typedef InputField = ({
  String key,
  String label,
  String? placeholder,
  String displayMode,
  List<String>? options,
  Future<List<String>> Function()? asyncOptions,
});
