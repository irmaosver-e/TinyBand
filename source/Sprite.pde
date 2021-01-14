class CollisionBox
{
  private float m_posX, m_posY, m_width, m_height;
  
  CollisionBox(float posX, float posY, float boxWidth, float boxHeight)
  {
    m_posX = posX;
    m_posY = posY;
    m_width = boxWidth;
    m_height = boxHeight;
  }
  
  boolean Inside(float posX, float posY)
  {
    println("inside");
    if ((posX > m_posX && posX < (m_posX + m_width)) 
        && (posY > m_posY && posY < (m_posY + m_height)))
    {
      println("Collision");
       return true; 
    }
    return false;
  }
}

class Sprite
{
  private Texture m_texture;
  private AudioPlayer m_player;
  private Slider m_slider;
  private CollisionBox m_collisionBox;
  private float m_posX, m_posY;
  private float m_maxframeSpeed;

  Sprite(Maxim maxim, float posX, float posY, float imgWidth, float imgHeight, String soundFileName, String imgFileName, 
  String imgExtension, int numImages, float frameSpeedAdjust, boolean sliderLeft, boolean playing)
  {
    m_posX = posX;
    m_posY = posY;
    m_maxframeSpeed = frameSpeedAdjust;
    m_collisionBox = new CollisionBox(posX, posY, imgWidth, imgHeight);
    m_texture = new Texture(posX, posY, imgWidth, imgHeight, imgFileName, imgExtension, numImages, frameSpeedAdjust );
    m_player = maxim.loadFile(soundFileName);
    m_player.setLooping(true);    
    float margin = imgHeight/16;
    float sliderXPos = posX + margin;
    if (!sliderLeft)
    {
      sliderXPos = (posX + imgWidth) - margin;
    }
    m_slider = new Slider(sliderXPos, (posY + margin), (imgHeight - (margin * 2)), 
    margin, margin/2, 0.1, m_maxframeSpeed, 0, false);
    m_player.speed(map(frameSpeedAdjust/2, 0.1, m_maxframeSpeed, 1, 2));
  }

  void Draw()
  {
    m_texture.Draw();
    m_slider.Draw();
  }

  void DragSlider(float mousePosX, float mousePosY)
  {
    m_slider.DragSlider(mousePosX, mousePosY);
    m_texture.AdjustFrameSpeed(m_slider.GetRange());
    m_player.speed(map(m_slider.GetRange(),0.1, m_maxframeSpeed, 1, 2));
  }

  void OnSlider(float mousePosX, float mousePosY)
  {
    m_slider.OnSlider(mousePosX, mousePosY);
  }

  void OffSlider()
  {
    m_slider.OffSlider();
  }

  void TurnOn(float mousePosX, float mousePosY)
  {
    if(m_collisionBox.Inside(mousePosX, mousePosY))
    {
      println("collided");
      m_texture.TogglePlaying(-1);
    } 

    if (m_texture.IsPlaying())
    {
      m_player.play();
    } else
    {
      m_player.stop();
    }
  }
  
  boolean IsPlaying()
  {
    return m_texture.IsPlaying();
  }
}

