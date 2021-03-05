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
  String GetInput()
  {
    return input;
  }
  void DrawBox()
  {
    background(255); //flushes existing input box
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
       println(num_char);
      //can do better, characters like ă and â are not printed
      //combinations of characters including ALT are not printed
      if (pressed == false && keyPressed == true)
      {
        pressed = true;
        if (key == BACKSPACE && input.length() > 0)
        {
          input = input.substring(0, input.length() - 1);
        }
        else if (key != BACKSPACE && key != ENTER && num_char > input.length())
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

void setup()
{
  size(800, 800);
  background(255);
}
InputBox test = new InputBox(50, 50, 100, color(255,0,0), color(0,0,255), color(0, 250, 0), color(0,0,255), 20, 15, 'k', "eticheta test");
//InputBox(int pos_x, int pos_y, int W, color Outline, color outline_s, color Text, color text_s, 
//       int input_size, int label_size, char b, String Label)

void draw()
{
 // test.input = "test";
  test.DrawBox();
  test.IsSelected();
  test.IsTyping();
}
