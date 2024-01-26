import 'package:rakshak/data/models/home/get_incident_resp.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '/core/app_export.dart';

class Cctv {
  String id;
  String lat;
  String long;
  String streamUrl;
  String title;
  String address;

  Cctv({
    required this.id,
    required this.lat,
    required this.long,
    required this.streamUrl,
    required this.title,
    required this.address,
  });
}

List<Incident> userReports = [
  Incident(
      id: "ABCD1234",
      image:
          "https://blog.ipleaders.in/wp-content/uploads/2018/06/BV-Acharya-19.jpg",
      title: "Beating single person",
      description: "Four Persons fighting with one person very badly in public",
      type: "Crime",
      station_name: "Jaipur",
      location:
          "Station Road, Metro Pillor No. 167 Hanumant Kunj, Barodia Scheme, Gopalbari, Jaipur, Rajasthan 302001, India",
      source: "9324326404",
      status: "Closed",
      created_at: "2024-01-11T00:21:12.102+00:00",
      lat: "26.920830",
      long: "75.793044"),
  Incident(
      id: "ABCB1234",
      image:
          "https://i0.wp.com/www.rvcj.com/wp-content/uploads/2015/03/maxresdefault1.jpg",
      title: "Fighting in Public",
      description:
          "People fighting with each other, trying to hurt random people",
      type: "Crime",
      station_name: "Jaipur",
      location: "Jhalana Gram, Malviya Nagar, Jaipur, Rajasthan 302017, India",
      source: "9324326404",
      status: "Closed",
      created_at: "2024-01-15T00:21:12.102+00:00",
      lat: "26.865715",
      long: "75.820325"),
  Incident(
    id: "BBCB1234",
    image:
        "https://static.toiimg.com/thumb/msid-65765549,width-400,resizemode-4/65765549.jpg",
    title: "Car & Truck Accident",
    description: "A Car collided with a truck, 2 people injured",
    type: "Accident",
    station_name: "Jaipur",
    location: "256, Nirman Nagar, Sushilpura, Jaipur, Rajasthan 302019, India",
    lat: "26.889263",
    long: "75.748453",
    source: "CCTV",
    status: "Closed",
    created_at: "2024-01-15T00:21:12.102+00:00",
  ),
  Incident(
      id: "DBCB1234",
      image:
          "https://c8.alamy.com/comp/HWGJWR/road-traffic-accident-between-two-cars-in-retail-park-in-spain-HWGJWR.jpg",
      title: "Two Cars Collided",
      description: "Accident Between Two cars, driver in both cars injured",
      type: "Accident",
      station_name: "Jaipur",
      location: "Chakala street",
      source: "CCTV",
      status: "Closed",
      created_at: "2024-01-15T00:21:12.102+00:00",
      lat: "26.918374",
      long: "75.800766"),
  Incident(
      id: "EFGH5678",
      image:
          "https://i0.wp.com/english.publictv.in/wp-content/uploads/2023/12/Nelamangala-car-catches-fire.jpg",
      title: "Car on Fire",
      description: "A car caught fire suddenly, everyone is safe",
      type: "Accident",
      station_name: "Jaipur",
      location:
          "6, Vivek Nagar, Kanti Nagar, Sindhi Camp, Jaipur, Rajasthan 302016, India",
      source: "CCTV",
      status: "Pending",
      created_at: "2024-01-12T08:45:30.512+00:00",
      lat: "26.923884",
      long: "75.801752"),
  Incident(
      id: "IJKL9012",
      image:
          "https://as2.ftcdn.net/v2/jpg/02/15/94/73/500_F_215947395_pqKBrx39ML0S1LUmKxQZYdCbb1SVRXj7.jpg",
      title: "Person stole bag",
      description: "A theif threatened a person and stole his bag",
      type: "Assault",
      station_name: "Jaipur",
      location:
          "Chinkara, Military Containment, Jhotwara, Jaipur, Rajasthan 302032, India",
      source: "9324326404",
      status: "Resolved",
      created_at: "2024-01-12T14:10:05.721+00:00",
      lat: "26.931843",
      long: "75.785003"),
  Incident(
      id: "MNOP3456",
      image:
          "https://blog.ipleaders.in/wp-content/uploads/2018/06/BV-Acharya-19.jpg",
      title: "Beating single person",
      description: "Four Persons fighting with one person very badly in public",
      type: "Crime",
      station_name: "Jaipur",
      location:
          "23A, Nahar Garh Rasta, Purani Basti, Jaipur, Rajasthan 302001, India",
      source: "CCTV",
      status: "Pending",
      created_at: "2024-01-13T18:30:40.901+00:00",
      lat: "26.932389",
      long: "75.811464"),
  Incident(
      id: "QRST7890",
      image:
          "https://i0.wp.com/www.rvcj.com/wp-content/uploads/2015/03/maxresdefault1.jpg",
      title: "Fighting in Public",
      description:
          "People fighting with each other, trying to hurt random people",
      type: "Crime",
      station_name: "Jaipur",
      location:
          "C-64 A, Sarojini Marg, Panch Batti, C Scheme, Ashok Nagar, Jaipur, Rajasthan 302001, India",
      source: "9324326404",
      status: "Pending",
      created_at: "2024-01-14T09:15:22.623+00:00",
      lat: "26.909933",
      long: "75.804533"),
  Incident(
      id: "UVWX1234",
      image:
          "https://static.toiimg.com/thumb/msid-65765549,width-400,resizemode-4/65765549.jpg",
      title: "Car & Truck Accident",
      description: "A Car collided with a truck, 2 people injured",
      type: "Accident",
      station_name: "Jaipur",
      location:
          "Hatwara Rd, Adarsh Nawal Colony, Lakshmi Nagar, Jaipur, Rajasthan 302007, India",
      source: "CCTV",
      status: "Closed",
      created_at: "2024-01-16T12:45:55.321+00:00",
      lat: "26.915980",
      long: "75.772926"),
  Incident(
      id: "YZAB5678",
      image:
          "https://c8.alamy.com/comp/HWGJWR/road-traffic-accident-between-two-cars-in-retail-park-in-spain-HWGJWR.jpg",
      title: "Two Cars Collided",
      description: "Accident Between Two cars, driver in both cars injured",
      type: "Accident",
      station_name: "Jaipur",
      location: "Hasanpura, Jaipur, Rajasthan 302006, India",
      source: "9324326404",
      status: "Resolved",
      created_at: "2024-01-04T16:20:30.430+00:00",
      lat: "26.921063",
      long: "75.784501"),
  Incident(
      id: "CDEF9012",
      image:
          "https://i0.wp.com/english.publictv.in/wp-content/uploads/2023/12/Nelamangala-car-catches-fire.jpg",
      title: "Car on Fire",
      description: "A car caught fire suddenly, everyone is safe",
      type: "Accident",
      station_name: "Jaipur",
      location:
          "S-5/B, Keshav Nagar, Civil Lines, Jaipur, Rajasthan 302006, India",
      source: "9324326404",
      status: "Pending",
      created_at: "2024-01-15T21:05:15.812+00:00",
      lat: "26.902848",
      long: "75.785016"),
  Incident(
      id: "CDEF9013",
      image:
          "https://as2.ftcdn.net/v2/jpg/02/15/94/73/500_F_215947395_pqKBrx39ML0S1LUmKxQZYdCbb1SVRXj7.jpg",
      title: "Person stole bag",
      description: "A theif threatened a person and stole his bag",
      type: "Assault",
      station_name: "Jaipur",
      location: "4-9, Sector 4, Jawahar Nagar, Jaipur, Rajasthan 302004, India",
      source: "9324326404",
      status: "Pending",
      created_at: "2024-01-17T21:05:15.812+00:00",
      lat: "26.885766",
      long: "75.831701"),
  Incident(
      id: "CDEF9000",
      image:
          "https://blog.ipleaders.in/wp-content/uploads/2018/06/BV-Acharya-19.jpg",
      title: "Beating single person",
      description: "Four Persons fighting with one person very badly in public",
      type: "Crime",
      station_name: "Jaipur",
      location: "Jamdoli, Jaipur, Rajasthan 302031, India",
      source: "9324326404",
      status: "Pending",
      created_at: "2024-01-17T21:05:15.812+00:00",
      lat: "26.906409",
      long: "75.890008"),
  Incident(
      id: "CDEF7000",
      image:
          "https://i0.wp.com/www.rvcj.com/wp-content/uploads/2015/03/maxresdefault1.jpg",
      title: "Fighting in Public",
      description:
          "People fighting with each other, trying to hurt random people",
      type: "Crime",
      station_name: "Jaipur",
      location:
          "256, Nirman Nagar, Sushilpura, Jaipur, Rajasthan 302019, India",
      source: "User Report",
      status: "Pending",
      created_at: "2024-01-16T21:05:15.812+00:00",
      lat: "26.889263",
      long: "75.748453"),
  Incident(
      id: "CDEF6000",
      image:
          "https://static.toiimg.com/thumb/msid-65765549,width-400,resizemode-4/65765549.jpg",
      title: "Car & Truck Accident",
      description: "A Car collided with a truck, 2 people injured",
      type: "Accident",
      station_name: "Jaipur",
      location:
          "Galta Rd, near Ramganj choupad, Hida Ki Mori, Laxmi Narayan Puri, Jaipur, Rajasthan 302002, India",
      source: "9324326404",
      status: "Pending",
      created_at: "2024-01-17T21:05:15.812+00:00",
      lat: "26.921369",
      long: "75.835651"),
  Incident(
      id: "CDEF5000",
      image:
          "https://c8.alamy.com/comp/HWGJWR/road-traffic-accident-between-two-cars-in-retail-park-in-spain-HWGJWR.jpg",
      title: "Two Cars Collided",
      description: "Accident Between Two cars, driver in both cars injured",
      type: "Accident",
      station_name: "Jaipur",
      location:
          "68, Talkatora Colony, J.D.A. Market, Kanwar Nagar, Jaipur, Rajasthan 302002, India",
      source: "9324326404",
      status: "Pending",
      created_at: "2024-01-16T21:05:15.812+00:00",
      lat: "26.932083",
      long: "75.826032"),
  Incident(
      id: "CAEF5000",
      image:
          "https://i0.wp.com/english.publictv.in/wp-content/uploads/2023/12/Nelamangala-car-catches-fire.jpg",
      title: "Car on Fire",
      description: "A car caught fire suddenly, everyone is safe",
      type: "Accident",
      station_name: "Jaipur",
      location:
          "137, Galta Rd, Goverdhan Puri, Lal Dungri, Jaipur, Rajasthan 302003, India",
      source: "CCTV",
      status: "Pending",
      created_at: "2024-01-17T21:05:15.812+00:00",
      lat: "26.917390",
      long: "75.849222"),
];

List<BarData> dataListConstants = [
  BarData(ColorConstant.blue500, 18, 18),
  BarData(ColorConstant.blue500, 17, 8),
  BarData(ColorConstant.blue500, 10, 15),
  BarData(ColorConstant.blue500, 2.5, 5),
  BarData(ColorConstant.blue500, 2, 2.5),
  BarData(ColorConstant.blue500, 2, 2),
  BarData(ColorConstant.blue500, 10, 15),
];

List<Cctv> cctvConstants = [
  Cctv(
      id: "cctv_111",
      lat: "26.923884",
      long: "75.801752",
      title: "CCTV 1",
      address:
          "6, Vivek Nagar, Kanti Nagar, Sindhi Camp, Jaipur, Rajasthan 302016, India",
      streamUrl:
          "https://res.cloudinary.com/dp0ayty6p/video/upload/v1705471181/samples/public_accident_fire.mp4"),
  Cctv(
      id: "cctv_222",
      lat: "26.920830",
      long: "75.793044",
      title: "CCTV 2",
      address:
          "Station Road, Metro Pillor No. 167 Hanumant Kunj, Barodia Scheme, Gopalbari, Jaipur, Rajasthan 302001, India",
      streamUrl:
          "https://res.cloudinary.com/dp0ayty6p/video/upload/v1705485743/samples/fire_sample.mp4"),
  Cctv(
      id: "cctv_333",
      lat: "26.917390",
      long: "75.849222",
      title: "CCTV 3",
      address:
          "137, Galta Rd, Goverdhan Puri, Lal Dungri, Jaipur, Rajasthan 302003, India",
      streamUrl:
          "https://res.cloudinary.com/dp0ayty6p/video/upload/v1704614357/samples/gun_video.mp4"),
  Cctv(
      id: "cctv_444",
      lat: "26.885766",
      long: "75.831701",
      title: "CCTV 4",
      address: "4-9, Sector 4, Jawahar Nagar, Jaipur, Rajasthan 302004, India",
      streamUrl:
          "https://res.cloudinary.com/dp0ayty6p/video/upload/v1705471181/samples/public_accident_fire.mp4"),
];

List<String> weekDaysConstants = [
  'M',
  'T',
  'W',
  'T',
  'F',
  'S',
  'S',
];

List<ValueItem> incidentCategoryConst = [
  ValueItem(
      label: "lbl_gambling_activity".tr, value: "lbl_gambling_activity".tr),
  ValueItem(
      label: "lbl_illegal_sale_of_liquor".tr,
      value: "lbl_illegal_sale_of_liquor".tr),
  ValueItem(
      label: "lbl_drinking_in_public_place".tr,
      value: "lbl_drinking_in_public_place".tr),
  ValueItem(label: "lbl_eve_teasing".tr, value: "lbl_eve_teasing".tr),
  ValueItem(label: "lbl_organized_crime".tr, value: "lbl_organized_crime".tr),
  ValueItem(
      label: "lbl_nuisance_at_public_place".tr,
      value: "lbl_nuisance_at_public_place".tr),
  ValueItem(label: "lbl_terrorism".tr, value: "lbl_terrorism".tr),
  ValueItem(
      label: "lbl_information_about_wanted_criminals".tr,
      value: "lbl_information_about_wanted_criminals".tr),
  ValueItem(label: "lbl_accident".tr, value: "lbl_accident".tr),
  ValueItem(label: "lbl_theft".tr, value: "lbl_theft".tr),
  ValueItem(label: "lbl_others".tr, value: "lbl_others".tr),
];

List<ValueItem> incidentDistrictConst = [
  ValueItem(label: "Ajmer", value: "Ajmer"),
  ValueItem(label: "Alwar", value: "Alwar"),
  ValueItem(label: "Anupgarh", value: "Anupgarh"),
  ValueItem(label: "ATS & SOG", value: "ATS & SOG"),
  ValueItem(label: "Balotra", value: "Balotra"),
  ValueItem(label: "Banswara", value: "Banswara"),
  ValueItem(label: "Baran", value: "Baran"),
  ValueItem(label: "Barmer", value: "Barmer"),
  ValueItem(label: "Beawar", value: "Beawar"),
  ValueItem(label: "Bharatpur", value: "Bharatpur"),
  ValueItem(label: "Bhilwara", value: "Bhilwara"),
  ValueItem(label: "Bhiwadi", value: "Bhiwadi"),
  ValueItem(label: "Bikaner", value: "Bikaner"),
  ValueItem(label: "Bundi", value: "Bundi"),
  ValueItem(label: "Chittorgarh", value: "Chittorgarh"),
  ValueItem(label: "Churu", value: "Churu"),
  ValueItem(label: "Dausa", value: "Dausa"),
  ValueItem(label: "DCP Crime", value: "DCP Crime"),
  ValueItem(label: "Deeg", value: "Deeg"),
  ValueItem(label: "Dholpur", value: "Dholpur"),
  ValueItem(label: "Didwana-Kuchaman", value: "Didwana-Kuchaman"),
  ValueItem(label: "Dudu", value: "Dudu"),
  ValueItem(label: "Dungarpur", value: "Dungarpur"),
  ValueItem(label: "Gangapur City", value: "Gangapur City"),
  ValueItem(label: "Grp Ajmer", value: "Grp Ajmer"),
  ValueItem(label: "Grp Jodhpur", value: "Grp Jodhpur"),
  ValueItem(label: "Hanumangarh", value: "Hanumangarh"),
  ValueItem(label: "Jaipur", value: "Jaipur"),
  ValueItem(label: "Jalore", value: "Jalore"),
  ValueItem(label: "Jhalawar", value: "Jhalawar"),
  ValueItem(label: "Jhunjhunu", value: "Jhunjhunu"),
  ValueItem(label: "Jodhpur East", value: "Jodhpur East"),
  ValueItem(label: "Jodhpur Rural", value: "Jodhpur Rural"),
  ValueItem(label: "Jodhpur West", value: "Jodhpur West"),
  ValueItem(label: "Karauli", value: "Karauli"),
  ValueItem(label: "Kekri", value: "Kekri"),
  ValueItem(label: "Khairthal-Tijara", value: "Khairthal-Tijara"),
  ValueItem(label: "Kota City", value: "Kota City"),
  ValueItem(label: "Kota Rural", value: "Kota Rural"),
  ValueItem(label: "Kotputali-Bahror", value: "Kotputali-Bahror"),
  ValueItem(label: "Nagaur", value: "Nagaur"),
  ValueItem(label: "Neem Ka Thana", value: "Neem Ka Thana"),
  ValueItem(label: "Pali", value: "Pali"),
  ValueItem(label: "Phalodi", value: "Phalodi"),
  ValueItem(label: "Pratapgarh", value: "Pratapgarh"),
  ValueItem(label: "Rajsamand", value: "Rajsamand"),
  ValueItem(label: "Salumber", value: "Salumber"),
  ValueItem(label: "Sanchore", value: "Sanchore"),
  ValueItem(label: "Sawai Madhopur", value: "Sawai Madhopur"),
  ValueItem(label: "Shahapura", value: "Shahapura"),
  ValueItem(label: "Sikar", value: "Sikar"),
  ValueItem(label: "Sirohi", value: "Sirohi"),
  ValueItem(label: "Sri Ganganagar", value: "Sri Ganganagar"),
  ValueItem(label: "Tonk", value: "Tonk"),
  ValueItem(label: "Udaipur", value: "Udaipur"),
];

List<ValueItem> getIncidentStationList(String district) {
  switch (district) {
    case "Ajmer":
      return ajmerStationList;
    case "Alwar":
      return alwarStationList;
    case "Anupgarh":
      return anupgarhStationList;
    case "ATS & SOG":
      return atsAndSogStationList;
    case "Balotra":
      return balotraStationList;
    case "Banswara":
      return banswaraStationList;
    case "Baran":
      return baranStationList;
    case "Barmer":
      return barmerStationList;
    case "Beawar":
      return beawarStationList;
    case "Bharatpur":
      return bharatpurStationList;
    case "Bhilwara":
      return bhilwaraStationList;
    case "Bhiwadi":
      return bhiwadiStationList;
    case "Bikaner":
      return bikanerStationList;
    case "Bundi":
      return bundiStationList;
    case "Chittorgarh":
      return chittorgarhStationList;
    case "Churu":
      return churuStationList;
    case "Dausa":
      return dausaStationList;
    case "DCP Crime":
      return dcpCrimeStationList;
    case "Deeg":
      return deegStationList;
    case "Dholpur":
      return dholpurStationList;
    case "Didwana-Kuchaman":
      return didwanaKuchamanStationList;
    case "Dudu":
      return duduStationList;
    case "Dungarpur":
      return dungarpurStationList;
    case "Gangapur City":
      return gangapurCityStationList;
    case "Grp Ajmer":
      return grpAjmerStationList;
    case "Grp Jodhpur":
      return grpJodhpurStationList;
    case "Hanumangarh":
      return hanumangarhStationList;
    case "Jaipur":
      return jaipurStationList;
    case "Jaisalmer":
      return jaisalmerStationList;
    case "Jalore":
      return jaloreStationList;
    case "Jhalawar":
      return jhalawarStationList;
    case "Jhunjhunu":
      return jhunjhunuStationList;
    case "Jodhpur East":
      return jodhpurEastStationList;
    case "Jodhpur Rural":
      return jodhpurRuralStationList;
    case "Jodhpur West":
      return jodhpurWestStationList;
    case "Karauli":
      return karauliStationList;
    case "Kekri":
      return kekriStationList;
    case "Khairthal-Tijara":
      return khairthalTijaraStationList;
    case "Kota City":
      return kotaCityStationList;
    case "Kota Rural":
      return kotaRuralStationList;
    case "Kotputali-Bahror":
      return kotputaliBahrorStationList;
    case "Nagaur":
      return nagaurStationList;
    case "Neem Ka Thana":
      return neemKaThanaStationList;
    case "Pali":
      return paliStationList;
    case "Phalodi":
      return phalodiStationList;
    case "Pratapgarh":
      return pratapgarhStationList;
    case "Rajsamand":
      return rajsamandStationList;
    case "Salumber":
      return salumberStationList;
    case "Sanchore":
      return sanchoreStationList;
    case "Sawai Madhopur":
      return sawaiMadhopurStationList;
    case "Shahapura":
      return shahapuraStationList;
    case "Sikar":
      return sikarStationList;
    case "Sirohi":
      return sirohiStationList;
    case "Sri Ganganagar":
      return sriGanganagarStationList;
    case "Tonk":
      return tonkStationList;
    case "Udaipur":
      return udaipurStationList;
    default:
      return [];
  }
}

List<ValueItem> ajmerStationList = [
  ValueItem(label: "Adarsh Nagar", value: "Adarsh Nagar"),
  ValueItem(label: "Alwar Gate", value: "Alwar Gate"),
  ValueItem(label: "Arian", value: "Arian"),
  ValueItem(label: "Bander Sindri", value: "Bander Sindri"),
  ValueItem(label: "Christianganj", value: "Christianganj"),
  ValueItem(label: "Civil Lines", value: "Civil Lines"),
  ValueItem(label: "Clock Tower", value: "Clock Tower"),
  ValueItem(label: "Cyber Thana Ajmer", value: "Cyber Thana Ajmer"),
  ValueItem(label: "Dargah", value: "Dargah"),
  ValueItem(label: "Gandhi Nagar", value: "Gandhi Nagar"),
  ValueItem(label: "Ganj", value: "Ganj"),
  ValueItem(label: "Gegal", value: "Gegal"),
  ValueItem(label: "Kishangarh", value: "Kishangarh"),
  ValueItem(label: "Kotwali Ajmer", value: "Kotwali Ajmer"),
  ValueItem(label: "Madanganj", value: "Madanganj"),
  ValueItem(label: "Mahila Ps", value: "Mahila Ps"),
  ValueItem(label: "Mangliyawas", value: "Mangliyawas"),
  ValueItem(label: "Nasirabad City", value: "Nasirabad City"),
  ValueItem(label: "Nasirabad Sadar", value: "Nasirabad Sadar"),
  ValueItem(label: "Pisangan", value: "Pisangan"),
  ValueItem(label: "Pushkar", value: "Pushkar"),
  ValueItem(label: "Ramganj", value: "Ramganj"),
  ValueItem(label: "Rupangarh", value: "Rupangarh"),
  ValueItem(label: "Shri Nagar", value: "Shri Nagar")
];
List<ValueItem> alwarStationList = [
  ValueItem(label: "Akbarpur", value: "Akbarpur"),
  ValueItem(label: "Aravali Vihar", value: "Aravali Vihar"),
  ValueItem(label: "Badoda Meo", value: "Badoda Meo"),
  ValueItem(label: "Bagad Tiraya", value: "Bagad Tiraya"),
  ValueItem(label: "Bahtu Kala", value: "Bahtu Kala"),
  ValueItem(label: "Cyber Thana Alwar", value: "Cyber Thana Alwar"),
  ValueItem(label: "Govind Garh", value: "Govind Garh"),
  ValueItem(label: "Kathumar", value: "Kathumar"),
  ValueItem(label: "Kherli", value: "Kherli"),
  ValueItem(label: "Kotwali Alwar", value: "Kotwali Alwar"),
  ValueItem(label: "Laxman Garh", value: "Laxman Garh"),
  ValueItem(label: "Mahila Thana", value: "Mahila Thana"),
  ValueItem(label: "Malakheda", value: "Malakheda"),
  ValueItem(label: "N.E.B", value: "N.E.B"),
  ValueItem(label: "Nauganwa", value: "Nauganwa"),
  ValueItem(label: "Pratap Garh", value: "Pratap Garh"),
  ValueItem(label: "Raini", value: "Raini"),
  ValueItem(label: "Rajgarh", value: "Rajgarh"),
  ValueItem(label: "Ramgarh", value: "Ramgarh"),
  ValueItem(label: "Sadar  Alwar", value: "Sadar  Alwar"),
  ValueItem(label: "Shivaji Park", value: "Shivaji Park"),
  ValueItem(label: "Tehala", value: "Tehala"),
  ValueItem(label: "Thana Gazi", value: "Thana Gazi"),
  ValueItem(label: "Udhyog Nagar", value: "Udhyog Nagar"),
  ValueItem(label: "Vaishali Nagar", value: "Vaishali Nagar"),
  ValueItem(label: "Vijay Mandir", value: "Vijay Mandir"),
];
List<ValueItem> anupgarhStationList = [
  ValueItem(label: "Anupgarh", value: "Anupgarh"),
  ValueItem(label: "Jetsar", value: "Jetsar"),
  ValueItem(label: "Muklawa", value: "Muklawa"),
  ValueItem(label: "Nai Mandigharsana", value: "Nai Mandigharsana"),
  ValueItem(label: "Raisinghnagar", value: "Raisinghnagar"),
  ValueItem(label: "Ramsinghpur", value: "Ramsinghpur"),
  ValueItem(label: "Rawla", value: "Rawla"),
  ValueItem(label: "Sameja Kothi", value: "Sameja Kothi"),
  ValueItem(label: "Shri Vijaynagar", value: "Shri Vijaynagar"),
];
List<ValueItem> atsAndSogStationList = [
  ValueItem(label: "Cyber Crime", value: "Cyber Crime"),
  ValueItem(label: "SOG", value: "SOG"),
];
List<ValueItem> balotraStationList = [
  ValueItem(label: "Baitu", value: "Baitu"),
  ValueItem(label: "Balotra", value: "Balotra"),
  ValueItem(label: "Gidan", value: "Gidan"),
  ValueItem(label: "Jasol", value: "Jasol"),
  ValueItem(label: "Kalyanpur", value: "Kalyanpur"),
  ValueItem(label: "Mandli", value: "Mandli"),
  ValueItem(label: "Pachapdra", value: "Pachapdra"),
  ValueItem(label: "Samadari", value: "Samadari"),
  ValueItem(label: "Sindhari", value: "Sindhari"),
  ValueItem(label: "Siwana", value: "Siwana"),
];
List<ValueItem> banswaraStationList = [
  ValueItem(label: "Ambapura", value: "Ambapura"),
  ValueItem(label: "Anandpuri", value: "Anandpuri"),
  ValueItem(label: "Arthuna", value: "Arthuna"),
  ValueItem(label: "Banswara", value: "Banswara"),
  ValueItem(label: "Bhungra", value: "Bhungra"),
  ValueItem(label: "Cyber Thana Banswara", value: "Cyber Thana Banswara"),
  ValueItem(label: "Danpur", value: "Danpur"),
  ValueItem(label: "Garhi", value: "Garhi"),
  ValueItem(label: "Ghatol", value: "Ghatol"),
  ValueItem(label: "Kalinjra", value: "Kalinjra"),
  ValueItem(label: "Kasarvadi", value: "Kasarvadi"),
  ValueItem(label: "Khamera", value: "Khamera"),
  ValueItem(label: "Kushalgarh", value: "Kushalgarh"),
  ValueItem(label: "Lohariya", value: "Lohariya"),
  ValueItem(label: "Mahila Thana", value: "Mahila Thana"),
  ValueItem(label: "Motagaoun", value: "Motagaoun"),
  ValueItem(label: "Patan", value: "Patan"),
  ValueItem(label: "Rajtalab", value: "Rajtalab"),
  ValueItem(label: "Sadar Banswara", value: "Sadar Banswara"),
  ValueItem(label: "Sajjangarh", value: "Sajjangarh"),
  ValueItem(label: "Sallopat", value: "Sallopat"),
];
List<ValueItem> baranStationList = [
  ValueItem(label: "Anta", value: "Anta"),
  ValueItem(label: "Atru", value: "Atru"),
  ValueItem(label: "Bavecha(Jaipla)", value: "Bavecha(Jaipla)"),
  ValueItem(label: "Bhawargarh", value: "Bhawargarh"),
  ValueItem(label: "Chabra", value: "Chabra"),
  ValueItem(label: "Chipa Barod", value: "Chipa Barod"),
  ValueItem(label: "Cyber Thana Baran", value: "Cyber Thana Baran"),
  ValueItem(label: "Harnawada", value: "Harnawada"),
  ValueItem(label: "Kasba Thana", value: "Kasba Thana"),
  ValueItem(label: "Kawai", value: "Kawai"),
  ValueItem(label: "Kelwara", value: "Kelwara"),
  ValueItem(label: "Kishanganj", value: "Kishanganj"),
  ValueItem(label: "Kotwali", value: "Kotwali"),
  ValueItem(label: "Mahila Thana Baran", value: "Mahila Thana Baran"),
  ValueItem(label: "Mali", value: "Mali"),
  ValueItem(label: "Mangrol", value: "Mangrol"),
  ValueItem(label: "Mothpur", value: "Mothpur"),
  ValueItem(label: "Nahargarh", value: "Nahargarh"),
  ValueItem(label: "Pali", value: "Pali"),
  ValueItem(label: "Sadar", value: "Sadar"),
  ValueItem(label: "Sarthal", value: "Sarthal"),
  ValueItem(label: "Seeswali", value: "Seeswali"),
  ValueItem(label: "Shahbad", value: "Shahbad"),
];
List<ValueItem> barmerStationList = [
  ValueItem(label: "Bakhasar", value: "Bakhasar"),
  ValueItem(label: "Barmer Rural", value: "Barmer Rural"),
  ValueItem(label: "Binjrad", value: "Binjrad"),
  ValueItem(label: "Chohtan", value: "Chohtan"),
  ValueItem(label: "Cyber Thana Barmer", value: "Cyber Thana Barmer"),
  ValueItem(label: "Dhanau", value: "Dhanau"),
  ValueItem(label: "Dhorimana", value: "Dhorimana"),
  ValueItem(label: "Gadra Road", value: "Gadra Road"),
  ValueItem(label: "Girab", value: "Girab"),
  ValueItem(label: "Gudamalani", value: "Gudamalani"),
  ValueItem(label: "Kotwali Barmer", value: "Kotwali Barmer"),
  ValueItem(label: "Mahila Thana", value: "Mahila Thana"),
  ValueItem(label: "Nagana", value: "Nagana"),
  ValueItem(
      label: "Rageshwari Gass Terminal", value: "Rageshwari Gass Terminal"),
  ValueItem(label: "Ramsar", value: "Ramsar"),
  ValueItem(label: "Rico Region Barmer", value: "Rico Region Barmer"),
  ValueItem(label: "Sadar Barmer", value: "Sadar Barmer"),
  ValueItem(label: "Sedwa", value: "Sedwa"),
  ValueItem(label: "Sheo", value: "Sheo"),
];
List<ValueItem> beawarStationList = [
  ValueItem(label: "Beawar Sadar", value: "Beawar Sadar"),
  ValueItem(label: "Anandpur Kalu", value: "Anandpur Kalu"),
  ValueItem(label: "Baar", value: "Baar"),
  ValueItem(label: "Badnor", value: "Badnor"),
  ValueItem(label: "Bar", value: "Bar"),
  ValueItem(label: "Beawar City", value: "Beawar City"),
  ValueItem(label: "Jaitaran", value: "Jaitaran"),
  ValueItem(label: "Jawaja", value: "Jawaja"),
  ValueItem(label: "Masuda", value: "Masuda"),
  ValueItem(label: "Raipur", value: "Raipur"),
  ValueItem(label: "Ras", value: "Ras"),
  ValueItem(label: "Saket Nagar", value: "Saket Nagar"),
  ValueItem(label: "Sendra", value: "Sendra"),
  ValueItem(label: "Todgarh", value: "Todgarh"),
  ValueItem(label: "Vijay Nagar", value: "Vijay Nagar"),
];
List<ValueItem> bharatpurStationList = [];
List<ValueItem> bhilwaraStationList = [];
List<ValueItem> bhiwadiStationList = [];
List<ValueItem> bikanerStationList = [];
List<ValueItem> bundiStationList = [];
List<ValueItem> chittorgarhStationList = [];
List<ValueItem> churuStationList = [];
List<ValueItem> dausaStationList = [];
List<ValueItem> dcpCrimeStationList = [];
List<ValueItem> deegStationList = [];
List<ValueItem> dholpurStationList = [];
List<ValueItem> didwanaKuchamanStationList = [];
List<ValueItem> duduStationList = [];
List<ValueItem> dungarpurStationList = [];
List<ValueItem> gangapurCityStationList = [];
List<ValueItem> grpAjmerStationList = [];
List<ValueItem> grpJodhpurStationList = [];
List<ValueItem> hanumangarhStationList = [];
List<ValueItem> jaipurStationList = [
  ValueItem(label: "Metro", value: "Metro"),
  ValueItem(label: "Adarsh Nagar", value: "Adarsh Nagar"),
  ValueItem(label: "Bajaj Nagar", value: "Bajaj Nagar"),
  ValueItem(label: "Bassi", value: "Bassi"),
  ValueItem(label: "Gandhi Nagar", value: "Gandhi Nagar"),
  ValueItem(label: "Jaipur Airport", value: "Jaipur Airport"),
  ValueItem(label: "Jawahar Circle", value: "Jawahar Circle"),
  ValueItem(label: "Jawahar Nagar", value: "Jawahar Nagar"),
  ValueItem(label: "Kanota", value: "Kanota"),
  ValueItem(label: "Khoh-Nagoriyan", value: "Khoh-Nagoriyan"),
  ValueItem(label: "Lal Kothi", value: "Lal Kothi"),
  ValueItem(label: "Mahila Thana East", value: "Mahila Thana East"),
  ValueItem(label: "Malpura Gate", value: "Malpura Gate"),
  ValueItem(label: "Malviya Nagar", value: "Malviya Nagar"),
  ValueItem(label: "Moti Doongari", value: "Moti Doongari"),
  ValueItem(label: "Pratapnagar", value: "Pratapnagar"),
  ValueItem(label: "Ramnagariya", value: "Ramnagariya"),
  ValueItem(label: "Sanganer", value: "Sanganer"),
  ValueItem(label: "Sms Hospital", value: "Sms Hospital"),
  ValueItem(label: "Toonga", value: "Toonga"),
  ValueItem(label: "Transport Nagar", value: "Transport Nagar"),
  ValueItem(label: "Amer", value: "Amer"),
  ValueItem(label: "Bhatta Basti", value: "Bhatta Basti"),
  ValueItem(label: "Brahmpuri", value: "Brahmpuri"),
  ValueItem(label: "Galtagate", value: "Galtagate"),
  ValueItem(label: "Jaisinghpura Khor", value: "Jaisinghpura Khor"),
  ValueItem(label: "Jalupura", value: "Jalupura"),
  ValueItem(label: "Kotwali Jaipur", value: "Kotwali Jaipur"),
  ValueItem(label: "Mahila Thana North", value: "Mahila Thana North"),
  ValueItem(label: "Manak Chowk", value: "Manak Chowk"),
  ValueItem(label: "Nahargarh", value: "Nahargarh"),
  ValueItem(label: "Ramganj", value: "Ramganj"),
  ValueItem(label: "Sanjay Circle", value: "Sanjay Circle"),
  ValueItem(label: "Shastri Nagar", value: "Shastri Nagar"),
  ValueItem(label: "Subhash Chowk", value: "Subhash Chowk"),
  ValueItem(label: "Tourist Thana, North", value: "Tourist Thana, North"),
  ValueItem(label: "Vidyadhar Nagar", value: "Vidyadhar Nagar"),
  ValueItem(label: "Amer", value: "Amer"),
  ValueItem(label: "Bhatta Basti", value: "Bhatta Basti"),
  ValueItem(label: "Brahmpuri", value: "Brahmpuri"),
  ValueItem(label: "Galtagate", value: "Galtagate"),
  ValueItem(label: "Jaisinghpura Khor", value: "Jaisinghpura Khor"),
  ValueItem(label: "Jalupura", value: "Jalupura"),
  ValueItem(label: "Kotwali Jaipur", value: "Kotwali Jaipur"),
  ValueItem(label: "Mahila Thana North", value: "Mahila Thana North"),
  ValueItem(label: "Manak Chowk", value: "Manak Chowk"),
  ValueItem(label: "Nahargarh", value: "Nahargarh"),
  ValueItem(label: "Ramganj", value: "Ramganj"),
  ValueItem(label: "Sanjay Circle", value: "Sanjay Circle"),
  ValueItem(label: "Shastri Nagar", value: "Shastri Nagar"),
  ValueItem(label: "Subhash Chowk", value: "Subhash Chowk"),
  ValueItem(label: "Tourist Thana, North", value: "Tourist Thana, North"),
  ValueItem(label: "Vidyadhar Nagar", value: "Vidyadhar Nagar"),
  ValueItem(label: "Amarsar", value: "Amarsar"),
  ValueItem(label: "Andhi", value: "Andhi"),
  ValueItem(label: "Chandwaji", value: "Chandwaji"),
  ValueItem(label: "Govindgarh", value: "Govindgarh"),
  ValueItem(label: "Jamwaramgarh", value: "Jamwaramgarh"),
  ValueItem(label: "Jobner", value: "Jobner"),
  ValueItem(label: "Kaladera", value: "Kaladera"),
  ValueItem(label: "Madhorajpura", value: "Madhorajpura"),
  ValueItem(label: "Mahila Thana", value: "Mahila Thana"),
  ValueItem(label: "Manoharpur", value: "Manoharpur"),
  ValueItem(label: "Narena", value: "Narena"),
  ValueItem(label: "Phulera", value: "Phulera"),
  ValueItem(label: "Raisar", value: "Raisar"),
  ValueItem(label: "Renwal", value: "Renwal"),
  ValueItem(label: "Renwal Manji", value: "Renwal Manji"),
  ValueItem(label: "Sambhar", value: "Sambhar"),
  ValueItem(label: "Samod", value: "Samod"),
  ValueItem(label: "Shahpura", value: "Shahpura"),
  ValueItem(label: "Ashok Nagar", value: "Ashok Nagar"),
  ValueItem(label: "Chaksu", value: "Chaksu"),
  ValueItem(label: "Jyoti Nagar", value: "Jyoti Nagar"),
  ValueItem(label: "Kotkhawda", value: "Kotkhawda"),
  ValueItem(label: "Mahesh Nagar", value: "Mahesh Nagar"),
  ValueItem(label: "Mahila Thana  South", value: "Mahila Thana  South"),
  ValueItem(label: "Mansarovar", value: "Mansarovar"),
  ValueItem(label: "Muhana", value: "Muhana"),
  ValueItem(label: "Sanganer Sadar", value: "Sanganer Sadar"),
  ValueItem(label: "Shipra Path", value: "Shipra Path"),
  ValueItem(label: "Shivdaspura", value: "Shivdaspura"),
  ValueItem(label: "Shyam Nagar", value: "Shyam Nagar"),
  ValueItem(label: "Sodala", value: "Sodala"),
  ValueItem(label: "Vidhayak Puri", value: "Vidhayak Puri"),
  ValueItem(label: "Bagru", value: "Bagru"),
  ValueItem(label: "Banipark", value: "Banipark"),
  ValueItem(label: "Bhankrota", value: "Bhankrota"),
  ValueItem(label: "Bindayka", value: "Bindayka"),
  ValueItem(label: "Chitrakoot", value: "Chitrakoot"),
  ValueItem(label: "Chomu", value: "Chomu"),
  ValueItem(label: "Daulatpura", value: "Daulatpura"),
  ValueItem(label: "Harmara", value: "Harmara"),
  ValueItem(label: "Jhotwara", value: "Jhotwara"),
  ValueItem(label: "Kalwar", value: "Kalwar"),
  ValueItem(label: "Kardhani", value: "Kardhani"),
  ValueItem(label: "Karnivihar", value: "Karnivihar"),
  ValueItem(label: "Mahila Thana", value: "Mahila Thana"),
  ValueItem(label: "Muralipura", value: "Muralipura"),
  ValueItem(label: "Sadar Jaipur", value: "Sadar Jaipur"),
  ValueItem(label: "Sez", value: "Sez"),
  ValueItem(label: "Sindhicamp", value: "Sindhicamp"),
  ValueItem(label: "Vaishali Nagar", value: "Vaishali Nagar"),
  ValueItem(label: "Vishwakarma  ", value: "Vishwakarma  "),
];
List<ValueItem> jaisalmerStationList = [];
List<ValueItem> jaloreStationList = [];
List<ValueItem> jhalawarStationList = [];
List<ValueItem> jhunjhunuStationList = [];
List<ValueItem> jodhpurEastStationList = [];
List<ValueItem> jodhpurRuralStationList = [];
List<ValueItem> jodhpurWestStationList = [];
List<ValueItem> karauliStationList = [];
List<ValueItem> kekriStationList = [];
List<ValueItem> khairthalTijaraStationList = [];
List<ValueItem> kotaCityStationList = [];
List<ValueItem> kotaRuralStationList = [];
List<ValueItem> kotputaliBahrorStationList = [];
List<ValueItem> nagaurStationList = [];
List<ValueItem> neemKaThanaStationList = [];
List<ValueItem> paliStationList = [];
List<ValueItem> phalodiStationList = [];
List<ValueItem> pratapgarhStationList = [];
List<ValueItem> rajsamandStationList = [];
List<ValueItem> salumberStationList = [];
List<ValueItem> sanchoreStationList = [];
List<ValueItem> sawaiMadhopurStationList = [];
List<ValueItem> shahapuraStationList = [];
List<ValueItem> sikarStationList = [];
List<ValueItem> sirohiStationList = [];
List<ValueItem> sriGanganagarStationList = [];
List<ValueItem> tonkStationList = [];
List<ValueItem> udaipurStationList = [];
