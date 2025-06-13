class AgreementDto {

  AgreementDto({
    required this.termsId,
    required this.agreed,
  });
  final int termsId;
  final String agreed;

  Map<String, dynamic> toJson() => {
        'termsId': termsId,
        'agreed': agreed,
      };
}
