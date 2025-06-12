class AgreementDto {
  final int termsId;
  final String agreed;

  AgreementDto({
    required this.termsId,
    required this.agreed,
  });

  Map<String, dynamic> toJson() => {
        'termsId': termsId,
        'agreed': agreed,
      };
}
