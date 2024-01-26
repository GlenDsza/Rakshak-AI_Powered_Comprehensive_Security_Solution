import { FaBus, FaHome, FaUmbrellaBeach } from "react-icons/fa";
import { FaLocationDot, FaSailboat } from "react-icons/fa6";
import { LocationTypes } from "../../apis/cctvs";


const LocationWiseIcons: Record<LocationTypes, () => JSX.Element> = {
  [LocationTypes.DEFAULT]: () => (
    <FaLocationDot className="stroke-current absolute w-4 h-4 left-2 top-2" />
  ),
  [LocationTypes.HOME]: () => (
    <FaHome className="stroke-current absolute w-4 h-4 left-2 top-2" />
  ),
  [LocationTypes.BEACH]: () => (
    <FaUmbrellaBeach className="stroke-current absolute w-4 h-4 left-2 top-2" />
  ),
  [LocationTypes.BOAT]: () => (
    <FaSailboat className="stroke-current absolute w-4 h-4 left-2 top-2" />
  ),
  [LocationTypes.PUBLIC_TRANSPORT]: () => (
    <FaBus className="stroke-current absolute w-4 h-4 left-2 top-2" />
  ),
};

export const getLocationIcon = (type: LocationTypes) => {
  return LocationWiseIcons[type] || LocationWiseIcons[LocationTypes.DEFAULT];
};
