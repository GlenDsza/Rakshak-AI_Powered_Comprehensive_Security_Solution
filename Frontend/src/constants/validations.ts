export enum SOURCES {
  CCTV = "CCTV",
  USER = "USER",
}

export function isPhoneNumber(phoneNumber: string) {
  const regex = /^\d{10}$/;
  return regex.test(phoneNumber);
}

export function getSource(source: string | null) {
  if (!source) return SOURCES.CCTV;
  if (source === SOURCES.CCTV || source.startsWith("cctv_")) {
    return SOURCES.CCTV;
  }
  if (isPhoneNumber(source)) {
    return SOURCES.USER;
  }
  return SOURCES.CCTV;
}
