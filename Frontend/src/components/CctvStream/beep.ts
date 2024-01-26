export function playBeepSound() {
  const audio = new Audio(
    "./beep.mp3"
    // "./beeplong.mp3"
  );
  audio.play()
}
