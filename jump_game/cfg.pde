public float deltaTime;
public float time;
public float currentTime;

public void timeStart () {
  time = millis();
}

public void timeUpdate () {
  currentTime = millis();
  deltaTime = (currentTime - time) * 0.001f;
  time = currentTime;
}
