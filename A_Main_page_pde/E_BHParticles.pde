class dust
{
  float[] size;
  PVector[] location;
  float[] clr;

  void particles()
  {
    for (int i=0; i<location.length; i++)
    {
      fill(clr[i],69,255);
      circle(location[i].x, location[i].y,size[i]);
    }
  }
}
