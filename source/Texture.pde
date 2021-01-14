class Texture
{
  private PImage[] m_frames;
  private float m_currentFrame = 0;
  private float m_posX, m_posY;
  private float m_height, m_width;
  private boolean m_playing;
  private float m_frameSpeedAdjust = 0;
  
  Texture(float posX, float posY, float imgWidth, float imgHeight, 
           String imgFileName, String imgExtension, int numImages, float frameSpeedAdjust)
  {
    m_playing = false;
    m_posX = posX;
    m_posY = posY;
    m_width = imgWidth;
    m_height = imgHeight;
    m_frameSpeedAdjust = frameSpeedAdjust;
    m_frames = loadImages(imgFileName, imgExtension, numImages);
  }
  
  void Draw()
  {
    if( m_frameSpeedAdjust != 0)
    {
      if (m_currentFrame >= m_frames.length)
      {
        m_currentFrame = 0;
      }
      image(m_frames[(int)m_currentFrame], m_posX, m_posY, m_width, m_height);
  
      if (m_playing)
      {
        m_currentFrame = m_currentFrame + (1 * m_frameSpeedAdjust);
      }
    }
    else
    {
      image(m_frames[0], m_posX, m_posY, m_width, m_height);
    }
  }
  
  void AdjustFrameSpeed(float frameSpeedAdjust)
  {
    m_frameSpeedAdjust = frameSpeedAdjust;
  }
  
  void TogglePlaying(int state)
  {
    if(state == 1)
    {
      m_playing = true;
    }
    else if(state == 0)
    {
      m_playing = false;
    }
    else
    {
      m_playing = !m_playing;
    }
  }
  
  boolean IsPlaying()
  {
    return m_playing;
  }
}  
