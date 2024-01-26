import geoJson from "./cctvs.json";
import { CCTV_TYPES, CctvDetails } from "./cctvs.types";

// interface LocationProperty {
//   title: string;
//   description: string;
// }
// interface LocationGeometry {
//   coordinates: number[];
//   type: string;
// }
// interface LocationFeature {
//   type: string;
//   properties: LocationProperty;
//   geometry: LocationGeometry;
// }
// interface CCTV_COORDINATES {
//   features: LocationFeature[];
// }

export function getDefaultMapCenter(): {
  lat: number;
  lon: number;
} {
  return {
    lat: 26.8868664,
    lon: 75.8190989,
  };
}


export async function getCctvs(cctv_type: CCTV_TYPES): Promise<CctvDetails[]> {
  // const response = await axios.get('/api/cctvs');
  // return response.data;
  console.log(
    "Find type",
    cctv_type,
    "in",
    geoJson.features.map((f) => f.properties.cctv_type)
  );

  return geoJson.features
    .filter(
      (feature) =>
        feature.properties.cctv_type === cctv_type ||
        cctv_type === CCTV_TYPES.ALL
    )
    .map((feature) => {
      return {
        id: feature.properties.id,
        cctv_type: feature.properties.cctv_type as CCTV_TYPES,
        name: feature.properties.title,
        description: feature.properties.description,
        latitude: feature.geometry.coordinates[1],
        longitude: feature.geometry.coordinates[0],
        streamUrl: feature.properties.streamUrl,
      };
    });
}

export enum LocationTypes {
  DEFAULT = "default",
  HOME = "home",
  BEACH = "beach",
  BOAT = "boat",
  PUBLIC_TRANSPORT = "public-transport",
}
export interface LocationSuggestion {
  name: string;
  lat: number;
  lon: number;
  type: LocationTypes;
}
export async function getLocationSuggestions(
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  text: string
): Promise<LocationSuggestion[]> {
  // console.log("Search text: ", text);

  return [
    {
      name: geoJson.features[0].properties.title,
      lon: geoJson.features[0].geometry.coordinates[0],
      lat: geoJson.features[0].geometry.coordinates[1],
      type: geoJson.features[0].properties.kind as LocationTypes,
    },
    {
      name: geoJson.features[1].properties.title,
      lon: geoJson.features[1].geometry.coordinates[0],
      lat: geoJson.features[1].geometry.coordinates[1],
      type: geoJson.features[1].properties.kind as LocationTypes,
    },
    {
      name: geoJson.features[2].properties.title,
      lon: geoJson.features[2].geometry.coordinates[0],
      lat: geoJson.features[2].geometry.coordinates[1],
      type: geoJson.features[2].properties.kind as LocationTypes,
    },
  ];
}
