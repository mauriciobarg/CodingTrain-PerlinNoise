import g4p_controls.*;
 
GPanel pnlMain; 
GSlider incr_slider;
GSlider flying_incr_slider;
GSlider max_h_slider;
GSlider min_h_slider;

GLabel lablel1;
GLabel lablel2; 
GLabel lablel3; 
GLabel lablel4; 

int cols, rows;
int scale = 20;
int w = 4000;
int h = 2000;
float[][] terrain;
float incr = 0.1;
float flying = 0;
float flying_incr = 0.03;

void setup() {
  size(1920, 1080, P3D);
  cols = w / scale;
  rows = h / scale;
  terrain = new float[cols][rows];
  createGUI();
}

void draw() {
  incr = incr_slider.getValueF();
  float y_off = flying;
  for (int y = 0; y < rows; y++) {
    float x_off = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(x_off, y_off), 0, 1, min_h_slider.getValueF(), max_h_slider.getValueF());
      x_off += incr;
    }
    y_off += incr;
  }
  flying -= flying_incr_slider.getValueF();
  background(0);
  stroke(0, 0, 100);
  //noFill();
  fill(10, 55, 255);
  translate(width / 2, height / 2);
  rotateX(PI / 3);
  translate(- w / 2, - h / 2);
  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x * scale, y * scale, terrain[x][y]);
      vertex(x * scale, (y + 1) * scale, terrain[x][y + 1]);
    }
    endShape();
  }
}

void createGUI() {
  G4P.messagesEnabled(true);
  G4P.setGlobalColorScheme(GCScheme.GREEN_SCHEME);
  G4P.setCursor(ARROW);
  //surface.setTitle("Sketch Window");
  pnlMain = new GPanel(this, 10, 5, 270, 115, "Controls");
  pnlMain.setText("Controls");
  pnlMain.setOpaque(false);
  
  incr_slider = new GSlider(this, 120, 30, 140, 15, 10);
  incr_slider.setNumberFormat(G4P.DECIMAL, 2);
  incr_slider.setOpaque(false);
  incr_slider.setLimits(0.01, 0.5);
  incr_slider.setValue(0.1);
  
  flying_incr_slider = new GSlider(this, 120, 50, 140, 15, 10);
  flying_incr_slider.setNumberFormat(G4P.DECIMAL, 2);
  flying_incr_slider.setOpaque(false);
  flying_incr_slider.setLimits(0.01, 0.5);
  flying_incr_slider.setValue(0.03);
  
  max_h_slider = new GSlider(this, 120, 70, 140, 15, 10);
  max_h_slider.setNumberFormat(G4P.DECIMAL, 2);
  max_h_slider.setOpaque(false);
  max_h_slider.setLimits(50, 300);
  max_h_slider.setValue(150);
  
  min_h_slider = new GSlider(this, 120, 90, 140, 15, 10);
  min_h_slider.setNumberFormat(G4P.DECIMAL, 2);
  min_h_slider.setOpaque(false);
  min_h_slider.setLimits(-300, -50);
  min_h_slider.setValue(-150);
  
  lablel1 = new GLabel(this, 10, 30, 150, 15);
  lablel1.setText("PERLIN INCR.");
  lablel1.setOpaque(false);
  
  lablel2 = new GLabel(this, 10, 50, 150, 15);
  lablel2.setText("SPEED");
  lablel2.setOpaque(false);
  
  lablel3 = new GLabel(this, 10, 70, 150, 15);
  lablel3.setText("MAX AMPLITUDE");
  lablel3.setOpaque(false);
  
  lablel4 = new GLabel(this, 10, 90, 150, 15);
  lablel4.setText("MIN AMPLITUDE");
  lablel4.setOpaque(false);
  
  pnlMain.addControl(incr_slider);
  pnlMain.addControl(flying_incr_slider);
  pnlMain.addControl(max_h_slider);
  pnlMain.addControl(min_h_slider);
  pnlMain.addControl(lablel1);
  pnlMain.addControl(lablel2);
  pnlMain.addControl(lablel3);
  pnlMain.addControl(lablel4);
}
