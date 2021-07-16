import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:street_view_platform_interface/src/type/street_view_panorama_link.dart';
import 'package:street_view_platform_interface/src/type/util/misc.dart';

import '../../street_view_platform_interface.dart';

class StreetViewCameraPosition {
  StreetViewCameraPosition(
      {this.position, this.panoId, this.radius, this.source})
      : assert(position != null || panoId != null);

  /// The position of target panorama.
  final LatLng? position;

  /// The panorama ID of target panorama.
  final String? panoId;

  /// The radius to filter panorama.
  final int? radius;

  /// Specific the panorama source, can be [StreetViewSource.def] or [StreetViewSource.outdoor].
  /// more info see,
  /// for [android] https://developers.google.com/android/reference/com/google/android/gms/maps/model/StreetViewSource
  /// for [iOS] https://developers.google.com/maps/documentation/ios-sdk/reference/group___panorama_source
  final StreetViewSource? source;

  /// Put all param to a map
  dynamic toMap() {
    Map<String, dynamic> param = Map();
    putToMapIfNonNull(param, "position", position?.toJson());
    putToMapIfNonNull(param, "panoId", panoId);
    putToMapIfNonNull(param, "radius", radius);
    putToMapIfNonNull(param, "source", source?.toJson());
    return param;
  }
}

class StreetViewPanoramaCamera {
  StreetViewPanoramaCamera({this.bearing, this.tilt, this.zoom});

  ///Direction of the orientation, in degrees clockwise from north.
  final double? bearing;

  /// The angle in degrees from horizon of the panorama, range -90 to 90
  final double? tilt;

  /// The zoom level of current panorama.
  /// more info see,
  /// for [android] https://developers.google.com/android/reference/com/google/android/gms/maps/model/StreetViewPanoramaCamera.Builder#zoom
  /// for [iOS] https://developers.google.com/maps/documentation/ios-sdk/reference/interface_g_m_s_panorama_camera#adb2250d57b30987cd2d13e52fa03833d
  final double? zoom;

  factory StreetViewPanoramaCamera.fromMap(dynamic map) {
    return new StreetViewPanoramaCamera(
      bearing: map['bearing'] as double?,
      tilt: map['tilt'] as double?,
      zoom: map['zoom'] as double?,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    putToMapIfNonNull(map, 'bearing', this.bearing);
    putToMapIfNonNull(map, 'tilt', this.tilt);
    putToMapIfNonNull(map, 'zoom', this.zoom);
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreetViewPanoramaCamera &&
          runtimeType == other.runtimeType &&
          bearing == other.bearing &&
          tilt == other.tilt &&
          zoom == other.zoom;

  @override
  int get hashCode => bearing.hashCode ^ tilt.hashCode ^ zoom.hashCode;

  @override
  String toString() {
    return 'StreetViewPanoramaCamera{bearing: $bearing, tilt: $tilt, zoom: $zoom}';
  }
}

class StreetViewPanoramaLocation {
  /// Array [StreetViewPanoramaLink] includes information about near panoramas of current panorama.
  final List<StreetViewPanoramaLink>? links;

  /// The location of current panorama.
  final LatLng? position;

  /// The panorama Id of current panorama.
  final String? panoId;

  StreetViewPanoramaLocation({this.links, this.position, this.panoId});

  factory StreetViewPanoramaLocation.fromMap(dynamic map) {
    if (map == null) return StreetViewPanoramaLocation();

    List<StreetViewPanoramaLink> linksTmp = [];
    (map['links'] as List?)?.forEach((e) {
      linksTmp.add(StreetViewPanoramaLink(panoId: e[0], bearing: e[1]));
    });
    final tmp = new StreetViewPanoramaLocation(
      links: linksTmp,
      position:
          LatLng(map['position'][0] as double, map['position'][1] as double),
      panoId: map['panoId'] as String?,
    );
    return tmp;
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'links': this.links,
      'position': this.position,
      'panoId': this.panoId,
    } as Map<String, dynamic>;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreetViewPanoramaLocation &&
          runtimeType == other.runtimeType &&
          links == other.links &&
          position == other.position &&
          panoId == other.panoId;

  @override
  int get hashCode => links.hashCode ^ position.hashCode ^ panoId.hashCode;

  @override
  String toString() {
    return 'StreetViewPanoramaLocation{links: $links, position: $position, panoId: $panoId}';
  }
}
