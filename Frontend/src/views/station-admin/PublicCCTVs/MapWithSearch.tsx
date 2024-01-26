import React, { useEffect } from "react";
import Map, { Marker, Popup } from "react-map-gl";
import { MAPBOX_TOKEN } from "@/constants/tokens";

import {
  getCctvs,
  getDefaultMapCenter,
  getLocationSuggestions,
} from "@/apis/cctvs";
import { CCTV_TYPES } from "@/apis/cctvs.types";
import SearchDialog from "@/components/SearchDialog";
import CctvMarkerPopupContent from "./CctvMarkerPopupContent";
import { CctvDetails } from "@/apis/cctvs.types";

import "./map.css";

interface MapWithSearchProps {
  drawerMode?: boolean;
  onFootageSelected: (cctv: CctvDetails) => void;
}
const MapWithSearch = (props: MapWithSearchProps) => {
  const { drawerMode, onFootageSelected } = props;
  const [cctvs, setCctvs] = React.useState<CctvDetails[]>([]);

  const [focusedLocation, setFocusedLocation] = React.useState<{
    lat: number;
    lon: number;
  } | null>(null);

  useEffect(() => {
    getCctvs(CCTV_TYPES.PUBLIC).then((cctvs) => setCctvs(cctvs));
  }, []);

  // useEffect(() => {
  //   if (mapInstance) {
  //     const markers = geoCoords.features.map((feature) =>
  //       new mapboxgl.Marker()
  //         .setLngLat([
  //           feature.geometry.coordinates[0],
  //           feature.geometry.coordinates[1],
  //         ])
  //     );
  //     markers.forEach(marker => marker.addTo(mapInstance))
  //   }
  // }, [mapInstance, geoCoords]);

  return (
    <div
      className={
        "public-cctvs-map " + (drawerMode ? "public-cctvs-map-drawer" : "")
      }
    >
      <SearchDialog getSuggestions={getLocationSuggestions} />
      <div className="public-cctvs-map-container">
        <Map
          mapboxAccessToken={MAPBOX_TOKEN}
          mapLib={import("mapbox-gl")}
          initialViewState={{
            latitude: getDefaultMapCenter().lat,
            longitude: getDefaultMapCenter().lon,
            zoom: 12,
          }}
          mapStyle="mapbox://styles/mapbox/streets-v9"
        >
          {cctvs.map((cctv) => {
            return (
              <Marker
                longitude={cctv.longitude}
                latitude={cctv.latitude}
                anchor="bottom"
                style={{ cursor: "pointer" }}
                key={cctv.id}
                onClick={() =>
                  setFocusedLocation({
                    lat: cctv.latitude,
                    lon: cctv.longitude,
                  })
                }
              >
                {focusedLocation?.lat === cctv.latitude &&
                  focusedLocation?.lon === cctv.longitude && (
                    <Popup
                      longitude={cctv.longitude}
                      latitude={cctv.latitude}
                      closeButton={true}
                      closeOnClick={false}
                      anchor="top"
                      onClose={() => setFocusedLocation(null)}
                      className="cctv-marker-popup"
                    >
                      <CctvMarkerPopupContent
                        cctv={cctv}
                        onViewFootage={(cctv) => {
                          onFootageSelected(cctv);
                          setFocusedLocation(null);
                        }}
                        onClose={() => {}}
                      />
                    </Popup>
                  )}
              </Marker>
            );
          })}
        </Map>
      </div>
    </div>
  );
};

export default MapWithSearch;
