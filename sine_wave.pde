float[] sinval;
float teta = 0;
float A = 10; //Amplitude
float F = 0.03; //Frequency
float S = 0.25; //Speed

class InputBox
{
  //top right corner coordinates
  int x;
  int y;
  int w; //width
  int h;
  color current_outline; //outline color to be used depending on "selected" variable
  color current_text; //input box text color to be used depending on "selected" variable
  color outline_selected; //outline color when input box is selected
  color outline; //outline color when input box is not selected
  color text; //text color when input box is not selected
  // Note: text label does not change color
  color text_selected; //text color when input box is selected
  boolean selected; //true if input box is selected, false otherwise
  boolean pressed; //control variable for keyboard 
  int input_text_size; //the size of the input box's text
  int label_text_size; //the size of the label's text
  String label; //stores the label
  String input; //stores the input box's input
  char blink; //blinking character
  int num_char; //number of characters user can input in the input box
  
  InputBox(int pos_x, int pos_y, int W, color Outline, color outline_s, color Text, color text_s, 
        int input_size, int label_size, char b, String Label)
  {
    x = pos_x;
    y = pos_y;
    w = W;
    h = input_size + 4;
    current_outline = Outline;
    selected = false;
    pressed = false;
    outline = Outline;
    outline_selected = outline_s;
    text = Text;
    text_selected = text_s;
    input_text_size = input_size;
    label_text_size = label_size;
    blink = b;
    label = Label;
    num_char = w / (input_text_size / 2);
    input = new String("");
  }
  String GetInputString()
  {
    if (input.length() > 0)
      return input;
    else
      return "";
  }
  float GetInputNumber()
  { 
    float x = float(GetInputString());
    if (Float.isNaN(x))
    {
      return 0;
    }
    return x;
  }
  void SetString(String new_input)
  {
    input = new_input;
  }
  void DrawBox()
  {
    //background(255); //flushes existing input box
    //label
    textSize(label_text_size);
    fill(text);
    text(label, x, y - label_text_size);
    //input box
    stroke(current_outline);
    noFill();
    rect(x, y, w, h);

    //displaying text inside the input box
    fill(current_text);
    textSize(input_text_size);
    text(input, x, y, w, h);
  }
  void IsTyping()
  {
    if (selected == true)
    {
      //can do better, characters like ă and â are not printed
      //combinations of characters including ALT are not printed
      if (pressed == false && keyPressed == true)
      {
        pressed = true;
        if (key == BACKSPACE && input.length() > 0)
        {
          input = input.substring(0, input.length() - 1);
        }
        else if (Character.isDigit(key) || key == '.') // only allow numeric input
        {   
          input = input.concat(str(key));
        }
        
      }
      if (keyPressed == false)
      {
        pressed = false;
      }
    }
  }
  void IsSelected()
  {
    if (mousePressed == true)
    {
      if (x < mouseX && mouseX < x + w && y < mouseY && mouseY < y + h)
      {
        selected = true;
        current_outline = outline_selected;
        current_text = text_selected;
      }
        
      else
      {
        selected = false; 
        current_outline = outline;
        current_text = text;
      }
             
    }
  }
}

//the program graphs the following function: f(x) = 350 + A*sin(2*PI*F*A + teta)
//where A is amplitude, F is frequency and teta is displacement
//teta is decremented by S

void calc_wave()
{
  for(int i = 0; i < 700; i++)
  {
    sinval[i] = 350+A*sin(2*PI*F*i + teta);
  }
 
}
void draw_wave()
{
  for(int i = 0; i < 700; i++)
  {
    point(i,  sinval[i]);
  }

}
InputBox amplitude = new InputBox(50, 50, 100, color(255,0,0), color(0,0,255), color(0, 250, 0), color(0,0,255), 20, 15, 'k', "Amplitude (max = 350)");
InputBox frequency = new InputBox(250, 50, 100, color(255,0,0), color(0,0,255), color(0, 250, 0), color(0,0,255), 20, 15, 'k', "Frequency");
InputBox speed = new InputBox(450, 50, 100, color(255,0,0), color(0,0,255), color(0, 250, 0), color(0,0,255), 20, 15, 'k', "Speed (max = 1000)");

void setup()
{
  size(700, 700);
  background(255);
  frameRate(50);
  sinval = new float[700];
  amplitude.SetString("10");
  frequency.SetString("0.03");
  speed.SetString("0.25");
  loop();
}

void draw()
{
  
  background(255);
  amplitude.DrawBox();
  amplitude.IsSelected();
  amplitude.IsTyping();
  A = amplitude.GetInputNumber();
  
  frequency.DrawBox();
  frequency.IsSelected();
  frequency.IsTyping();
  F = frequency.GetInputNumber();
  
  speed.DrawBox();
  speed.IsSelected();
  speed.IsTyping();
  S = speed.GetInputNumber();
  
  stroke(0, 0, 0);
  calc_wave();
  draw_wave();
  if (S > 1000)  
    S = 10000;
  teta = teta-S;
  println(S);

 }
  
