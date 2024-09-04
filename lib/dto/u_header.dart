class UHeader {
  final String name;
  final int width;
  final bool pk;
  final bool fk;
  final bool nullable;
  final bool autoIncrement;
  final String dtype;
  final List<dynamic>? uEnum;

  const UHeader(this.name, this.width,
      {this.pk = false,
      this.fk = false,
      this.nullable = false,
      this.autoIncrement = false,
      this.dtype = "",
      this.uEnum});
}
