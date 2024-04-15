import 'package:hive/hive.dart';
import 'package:uts/model/ad_banner.dart';

class LocalAdBannerService {
  late Box<AdBanner> _adBannerBox;

  Future<void> init() async {
    _adBannerBox = await Hive.openBox<AdBanner>('AdBanners');
  }

  Future<void> assignAllAdBanners({required List<AdBanner> adbanners}) async {
    await _adBannerBox.clear();
    await _adBannerBox.addAll(adbanners);
  }

  List<AdBanner> getAllAdBanners() => _adBannerBox.values.toList();
}