abstract class BaseMapper<T> {
  T fromMap(Map<String, dynamic> json);

  Map<String, dynamic> toMap(T data, {bool update = false});
}
