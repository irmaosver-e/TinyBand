class Rect
{
  private float m_minPos;
  private float m_maxPos;
  private boolean m_horizontal;
  private float m_x;
  private float m_y;
  private float m_w;
  private float m_h;
  private float m_r = 7;

  Rect(float rectWidth, float rectHeight, float lineX, float lineY, float lineSize, int initialPos, boolean horizontal)
  {
    m_horizontal = horizontal;

    if (horizontal)
    {
      m_w = rectWidth;
      m_h = rectHeight;
      m_minPos = lineX;
      m_maxPos = (lineX + lineSize) - rectWidth;
      m_y = lineY - (rectHeight / 2);
      if (initialPos < 0)
      {
        m_x = m_minPos;
      } else if (initialPos > 0)
      {
        m_x = m_maxPos;
      } else
      {
        m_x = (m_minPos/2) + (m_maxPos/2);
      }
    } else
    {
      m_y = lineY;
      m_w = rectWidth;
      m_h = rectHeight;
      m_minPos = lineY;
      m_maxPos = (lineY + lineSize) - rectHeight;
      m_x = lineX - (rectWidth / 2);
      if (initialPos < 0)
      {
        m_y = m_minPos;
      } else if (initialPos > 0)
      {
        m_y = m_maxPos;
      } else
      {
        m_y = (m_minPos/2) + (m_maxPos/2);
      }
    }
  }

  float GetPosX()
  {
    return m_x;
  }

  float GetPosY()
  {
    return m_y;
  }
  
    float GetMinPos()
  {
    return m_minPos;
  }

  float GetMaxPos()
  {
    return m_maxPos;
  }

  boolean GetHorizontal()
  {
    return m_horizontal;
  }


  public boolean InsideRect(float mousePosX, float mousePosY) 
  {
    if ((mousePosX > m_x && mousePosX < (m_x + m_w)) && (mousePosY > m_y && mousePosY < (m_y + m_h)))
    {
      return true;
    }
    return false;
  }  

  public void SetPos(float x, float y)
  {
    if (m_horizontal)
    {
      m_x = x;
      if (m_x < m_minPos)
      {
        m_x = m_minPos;
      }
      if (m_x > m_maxPos)
      {
        m_x = m_maxPos;
      }
    } else
    {
      m_y = y;
      if (m_y < m_minPos)
      {
        m_y = m_minPos;
      }
      if (m_y > m_maxPos)
      {
        m_y = m_maxPos;
      }
    }
  }

  public void Draw()
  {
    rect(m_x, m_y, m_w, m_h, m_r);
  }
}

class Line
{
  private float m_startX, m_startY, m_endX, m_endY;

  Line(float posX, float posY, float size, boolean horizontal)
  {
    m_startX = posX;
    m_startY = posY;

    if (horizontal)
    {
      m_endX = posX + size;
      m_endY = posY;
    } else
    {
      m_endX = posX;
      m_endY = posY + size;
    }
  }

  public void Draw()
  {
    line(m_startX, m_startY, m_endX, m_endY);
  }
}

class Slider
{
  private Rect m_rect;
  private Line m_line;
  private boolean m_mouseOver = false;
  private float m_initialRangeValue, m_endRangeValue;

  Slider(float posX, float posY, float size, float slideWidth, float slideHeight, 
  float initialRangeValue, float endRangeValue, int slideInitialPos, boolean horizontal)
  {
    m_initialRangeValue = initialRangeValue;
    m_endRangeValue = endRangeValue;

    strokeWeight(3);
    fill(127);
    m_line = new Line(posX, posY, size, horizontal); 
    m_rect = new Rect(slideWidth, slideHeight, posX, posY, size, slideInitialPos, horizontal);
  }

  float GetPosX()
  {
    return m_rect.GetPosX();
  }

  float GetPosY()
  {
    return m_rect.GetPosY();
  }

  float GetRange()
  {
    float valueToConvert = 0;
    
    if(m_rect.GetHorizontal())
    {
      valueToConvert = m_rect.GetPosX();
    }
    else
    {
      valueToConvert = m_rect.GetPosY();
    }
    return map(valueToConvert, m_rect.GetMinPos(), m_rect.GetMaxPos(), m_initialRangeValue, m_endRangeValue);
  }

  void Draw()
  {    
    m_line.Draw();
    m_rect.Draw();
  }

  void DragSlider(float mousePosX, float mousePosY)
  {
    if (m_mouseOver)
    {
      m_rect.SetPos(mousePosX, mousePosY);
    }
  }

  void OnSlider(float mousePosX, float mousePosY)
  {
    if (m_rect.InsideRect(mousePosX, mousePosY))
    {
      m_mouseOver = true;
    }
  }

  void OffSlider()
  {
    m_mouseOver = false;
  }
}

