enum SortValueEnum { asc, desc }

typedef SortField = ({
  String key,
  String label,
  SortValueEnum? value,
});
