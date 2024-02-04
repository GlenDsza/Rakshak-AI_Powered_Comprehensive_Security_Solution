import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakshak/data/models/home/get_incident_resp.dart';
import 'bloc/map_police_bloc.dart';
import 'models/map_police_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/custom_button.dart';

class MapPolicePage extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<MapPoliceBloc>(
        create: (context) => MapPoliceBloc(MapPoliceState(
              cctvList: cctvConstants,
              mapPoliceModelObj: MapPoliceModel(),
            ))
              ..add(MapPoliceInitialEvent()),
        child: MapPolicePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapPoliceBloc, MapPoliceState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: ColorConstant.gray50,
        body: BlocBuilder<MapPoliceBloc, MapPoliceState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(19.072692341100385, 72.89981901377328),
                    zoom: 13,
                  ),
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  markers: {
                    Marker(
                        markerId: MarkerId("police"),
                        position: LatLng(19.072692341100385, 72.89981901377328),
                        icon: state.policeMarkerIcon ??
                            BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueBlue),
                        infoWindow: InfoWindow(
                            title: PrefUtils().getName(), snippet: "Police")),
                    ...(state.plotType == "Surveillance"
                        ? state.cctvList.map((cctv) => Marker(
                              markerId: MarkerId(cctv.id.toString()),
                              position: LatLng(double.parse(cctv.lat),
                                  double.parse(cctv.long)),
                              icon: state.objIcon ??
                                  BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueRed),
                              infoWindow: InfoWindow(
                                  title: cctv.title,
                                  snippet: cctv.address,
                                  onTap: () => onTapCctvWindow(context, cctv)),
                            ))
                        : state.incidentsList
                            .sublist(0, 6)
                            .map((incident) => Marker(
                                  markerId: MarkerId(incident.id.toString()),
                                  position: LatLng(double.parse(incident.lat!),
                                      double.parse(incident.long!)),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueRed),
                                  infoWindow: InfoWindow(
                                      title: incident.title,
                                      snippet: incident.location,
                                      onTap: () => onTapIncidentWindow(
                                          context, incident)),
                                ))),
                  },
                ),
                Container(
                  margin: getMargin(top: 16, bottom: 16, left: 16, right: 16),
                  padding: EdgeInsets.all(4),
                  decoration: AppDecoration.fillWhiteA700.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.read<MapPoliceBloc>().add(
                              PlotTypeChangeEvent(plotType: "Surveillance")),
                          child: state.plotType == "Surveillance"
                              ? CustomButton(
                                  margin: getMargin(left: 4),
                                  text: "lbl_surveillance".tr,
                                  prefixWidget: Container(
                                      margin: getMargin(right: 8),
                                      child: CustomImageView(
                                          color: ColorConstant.whiteA700,
                                          svgPath: ImageConstant.imgCctv)),
                                  variant: ButtonVariant.FillBlue500,
                                  shape: ButtonShape.RoundedBorder16,
                                  padding: ButtonPadding.PaddingAll12,
                                  fontStyle:
                                      ButtonFontStyle.ManropeBold12WhiteA700_1)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: getMargin(right: 8),
                                        child: CustomImageView(
                                            width: getSize(20),
                                            color: ColorConstant.black900,
                                            svgPath: ImageConstant.imgCctv)),
                                    Text("lbl_surveillance".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: AppStyle.txtManropeBold12
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.2))),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(width: getHorizontalSize(8)),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context
                              .read<MapPoliceBloc>()
                              .add(PlotTypeChangeEvent(plotType: "Incidents")),
                          child: state.plotType == "Incidents"
                              ? CustomButton(
                                  margin: getMargin(right: 4),
                                  text: "lbl_incidents".tr,
                                  prefixWidget: Container(
                                      margin: getMargin(right: 8),
                                      child: CustomImageView(
                                          color: ColorConstant.whiteA700,
                                          svgPath: ImageConstant.imgMenu1)),
                                  variant: ButtonVariant.FillBlue500,
                                  shape: ButtonShape.RoundedBorder16,
                                  padding: ButtonPadding.PaddingAll12,
                                  fontStyle:
                                      ButtonFontStyle.ManropeBold12WhiteA700_1)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: getMargin(right: 8),
                                        child: CustomImageView(
                                            color: ColorConstant.black900,
                                            width: getSize(20),
                                            svgPath: ImageConstant.imgMenu1)),
                                    Text("lbl_incidents".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: AppStyle.txtManropeBold12
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.2))),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ));
    });
  }

  onTapIncidentWindow(BuildContext context, Incident incident) {
    NavigatorService.pushNamed(AppRoutes.incidentDetailsScreen, arguments: {
      "incident": incident,
    });
  }

  onTapCctvWindow(BuildContext context, Cctv cctv) {
    NavigatorService.pushNamed(AppRoutes.cctvDetailsScreen, arguments: {
      "cctv": cctv,
    });
  }
}
