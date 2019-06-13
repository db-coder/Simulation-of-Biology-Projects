class spring
{
  boid b1, b2;
  float rest = 0.0;
  float k = 0.2;
  float freq;
  float phase;
  float amp;
  int t;
  spring(boid a, boid b, float restLength, float K)
  {
    b1 = a;
    b2 = b;
    rest = restLength;
    k = K;
    freq = 0;
    phase = 0.0;
    amp = rest/2;
    t = -1;
  }
  
  void updateLength()
  {
    if(t != -1)
    {
      t++;
      rest = amp + amp*sin(2*PI*freq*t+phase);
    }
  }
  
  void setDetails(float frequency, float phas, float amplitude)
  {
    freq = frequency;
    phase = phas;
    amp = amplitude;
    t = 0;
  }
}
