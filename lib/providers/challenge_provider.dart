import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_challenge_data_source.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _challengeDataSourceProvider = Provider(
  (ref) => RemoteChallengeDataSource(dio: ref.read(dioProvider)),
);
