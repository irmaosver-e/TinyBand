//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies

//Desktop Template

Maxim maxim;

Sprite julie;
Sprite chibi;

Texture stage;
Texture spotlights;
Texture crowd;

void setup()
{
  size(768, 480);
  background(255);
  
  maxim = new Maxim(this);
  
  julie = new Sprite(maxim, 90, 210 , 198, 220, "julie_data/julie_guitar.wav", "julie_data/frame", ".gif", 4, 0.5, true, false);
  chibi = new Sprite(maxim, 460, 180 , 201, 258, "chibi_data/chibi_bass_guitar.wav", "chibi_data/frame", ".gif", 16, 0.5, false, false);
  
  stage = new Texture(0, 0, width, height, "stage_data/stageBackground",".jpg", 1, 0);
  spotlights = new Texture(0, 0, width, 150, "stage_data/spotlights",".png", 1, 0);
  crowd = new Texture(0, 370, width, 132, "stage_data/crowd", ".png", 2, 0.2); 
}

void draw()
{
  background(255);
  
  
  stage.Draw();

  julie.Draw();
  chibi.Draw();
  
  spotlights.Draw();
  crowd.Draw();
// code that happens every frame
}

void mouseDragged()
{  
  julie.DragSlider(mouseX, mouseY);
  chibi.DragSlider(mouseX, mouseY);
// code that happens when the mouse moves
// with the button down
}

void mousePressed()
{    
  julie.OnSlider(mouseX, mouseY);
  chibi.OnSlider(mouseX, mouseY);
// code that happens when the mouse button
// is pressed
}

void mouseReleased()
{  
  julie.OffSlider();
  chibi.OffSlider();
// code that happens when the mouse button
// is released
}

void mouseClicked()
{
  julie.TurnOn(mouseX, mouseY);
  chibi.TurnOn(mouseX, mouseY);
  
  if(julie.IsPlaying() || chibi.IsPlaying())
  {
    crowd.TogglePlaying(1);
  }
  
  if(!julie.IsPlaying() && !chibi.IsPlaying())
  {
    crowd.TogglePlaying(0);
  }
}
