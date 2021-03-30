/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_drawBoard(PApplet appc, GWinData data) { //_CODE_:ControlBoard:993631:
  appc.background(230);
} //_CODE_:ControlBoard:993631:

public void win_closeBoard(GWindow window) { //_CODE_:ControlBoard:715567:
} //_CODE_:ControlBoard:715567:

public void polynomialAUpdate(GTextField source, GEvent event) { //_CODE_:polynomialA:602300:
  polyA = new Polynomial(polynomialA.getText());
  polyA.findLocalExtrema(); //finds extrema
  polyA.createDisplayVariables(); //Prepares variables to be properly displayed
  
} //_CODE_:polynomialA:602300:

public void infoButtonAClicked(GButton source, GEvent event) { //_CODE_:infoButtonA:615614:
  polyADetails.setVisible(true); //Opens the Detail board for the user to see
} //_CODE_:infoButtonA:615614:

public void polynomialBUpdate(GTextField source, GEvent event) { //_CODE_:polynomialB:648687:
  polyB = new Polynomial(polynomialB.getText());
  polyB.findLocalExtrema();
  polyB.createDisplayVariables();
  
} //_CODE_:polynomialB:648687:

public void infoButtonBClicked(GButton source, GEvent event) { //_CODE_:infoButtonB:831032:
  polyBDetails.setVisible(true);
} //_CODE_:infoButtonB:831032:

public void drawGraphButtonClicked(GButton source, GEvent event) { //_CODE_:drawGraphButton:621108:
  if (yNextMax - yNextMin < yIncrement || xNextMax - xNextMin < xIncrement) {
    graphErrorText.setText("Error: an increment is smaller than the range of x or y-values"); //testing for impossible entered values
  }
  else if (yNextMax < yNextMin || xNextMax < xNextMin) {
    graphErrorText.setText("Error: a minimum is greater than a maximum");
  }
  else if (xIncrement == 0 || yIncrement == 0) {
    graphErrorText.setText("Error: an increment is equal to 0 and cannot be 0");
  }
  else {
    polyAStroke = color(polyARed, polyAGreen, polyABlue); //Color slider affects the color of the graph
    polyBStroke = color(polyBRed, polyBGreen, polyBBlue);
    xMax = xNextMax;
    xMin = xNextMin;
    yMax = yNextMax;
    yMin = yNextMin;
    graphErrorText.setText("");
    resetGraphValues();
    loop();
  }
} //_CODE_:drawGraphButton:621108:

public void xMaxInputUpdate(GTextField source, GEvent event) { //_CODE_:xMaxInput:381869:
  xNextMax = int(xMaxInput.getText());
} //_CODE_:xMaxInput:381869:

public void xMinInputUpdate(GTextField source, GEvent event) { //_CODE_:xMinInput:751939:
  xNextMin = int(xMinInput.getText());
} //_CODE_:xMinInput:751939:

public void yMaxInputUpdate(GTextField source, GEvent event) { //_CODE_:yMaxInput:854069:
  yNextMax = int(yMaxInput.getText());
} //_CODE_:yMaxInput:854069:

public void yMinInputUpdate(GTextField source, GEvent event) { //_CODE_:yMinInput:835319:
  yNextMin = int(yMinInput.getText());
} //_CODE_:yMinInput:835319:

public void xIncrementInputUpdate(GTextField source, GEvent event) { //_CODE_:xIncrementInput:825751:
  xIncrement = int(xIncrementInput.getText());
} //_CODE_:xIncrementInput:825751:

public void yIncrementInputUpdate(GTextField source, GEvent event) { //_CODE_:yIncrementInput:605349:
  yIncrement = int(yIncrementInput.getText());
} //_CODE_:yIncrementInput:605349:

public void runButtonClicked(GButton source, GEvent event) { //_CODE_:runButton:720669:
  if (polyA.variable.equals(polyB.variable)){ //Displays all of the answers to the operations aswell as the detail boards when clicked
    sumDisplay.setText(polyA.addPolynomial(polyB)); 
    productDisplay.setText(polyA.multiplyPolynomial(polyB));
    differenceDisplayASubB.setText(polyA.subtractPolynomial(polyB));
    differenceDisplayBSubA.setText(polyB.subtractPolynomial(polyA));
    ADivByBDisplay.setText(polyA.dividePolynomial(polyB)[0]);
    BDivByADisplay.setText(polyB.dividePolynomial(polyA)[0]);
    remainderAOverBDisplay.setText(polyA.dividePolynomial(polyB)[1]);
    remainderBOverADisplay.setText(polyB.dividePolynomial(polyA)[1]);
    divisorAOverBDisplay.setText(polyB.polynomial);
    divisorBOverADisplay.setText(polyA.polynomial);
    sameVariableDisplay.setText(polyA.variable);
  }
  else{
    sameVariableDisplay.setText("No common Variable");
  }
  //Details polyA
  degreeDisplayA.setText(str(polyA.degree));
  commonVariableDisplayA.setText(polyA.variable);
  rootDisplayA.setText(polyA.rootDisplay); //CONVERT INTO STRING
  leadingCoefficientDisplayA.setText(str(polyA.leadingCoefficient)); //Fix
  posNegDisplayA.setText(polyA.posNeg);
  arrangedDisplayA.setText(polyA.polynomial);
  localMaximaDisplayA.setText(polyA.maximaDisplay);
  localMinimaDisplayA.setText(polyA.minimaDisplay);  
  
  //Details polyB
  degreeDisplayB.setText(str(polyB.degree));
  commonVariableDisplayB.setText(polyB.variable);
  rootDisplayB.setText(polyB.rootDisplay);
  leadingCoefficientDisplayB.setText(str(polyB.leadingCoefficient));
  posNegDisplayB.setText(polyB.posNeg);
  arrangedDisplayB.setText(polyB.polynomial);
  localMaximaDisplayB.setText(polyB.maximaDisplay);
  localMinimaDisplayB.setText(polyB.minimaDisplay);  
  
} //_CODE_:runButton:720669:

//ColorSliders
public void polyARedSliderUpdate(GSlider source, GEvent event) { //_CODE_:polyARedSlider:545995:
  polyARed = polyARedSlider.getValueI();
} //_CODE_:polyARedSlider:545995:

public void polyBBlueSliderUpdate(GSlider source, GEvent event) { //_CODE_:polyBBlueSlider:286837:
  polyBBlue = polyBBlueSlider.getValueI();
} //_CODE_:polyBBlueSlider:286837:

public void polyBGreenSliderUpdate(GSlider source, GEvent event) { //_CODE_:polyBGreenSlider:663529:
  polyBGreen = polyBGreenSlider.getValueI();
} //_CODE_:polyBGreenSlider:663529:

public void polyBRedSliderUpdate(GSlider source, GEvent event) { //_CODE_:polyBRedSlider:617142:
  polyBRed = polyBRedSlider.getValueI();
} //_CODE_:polyBRedSlider:617142:

public void polyABlueSliderUpdate(GSlider source, GEvent event) { //_CODE_:polyABlueSlider:606982:
  polyABlue = polyABlueSlider.getValueI();
} //_CODE_:polyABlueSlider:606982:

public void polyAGreenSliderUpdate(GSlider source, GEvent event) { //_CODE_:polyAGreenSlider:729078:
  polyAGreen = polyAGreenSlider.getValueI();
} //_CODE_:polyAGreenSlider:729078:

synchronized public void win_drawA(PApplet appc, GWinData data) { //_CODE_:polyADetails:976462:
  appc.background(230);
} //_CODE_:polyADetails:976462:

public void win_closeA(GWindow window) { //_CODE_:polyADetails:539846:
  polyADetails = GWindow.getWindow(this, "Polynomial A Details", 500, 0, 400, 165, JAVA2D);
  polyADetails.noLoop();
  polyADetails.setActionOnClose(G4P.CLOSE_WINDOW);
  polyADetails.addDrawHandler(this, "win_drawA");
  polyADetails.addOnCloseHandler(this, "win_closeA");
  label5 = new GLabel(polyADetails, 4, 4, 392, 40);
  label5.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label5.setText("Polynomial A Detail Board");
  label5.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label5.setOpaque(false);
  commonVariableDisplayA = new GLabel(polyADetails, 96, 50, 34, 30);
  commonVariableDisplayA.setText("__");
  commonVariableDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  commonVariableDisplayA.setOpaque(false);
  label4 = new GLabel(polyADetails, 10, 50, 80, 30);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setText("Common Variable");
  label4.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label4.setOpaque(false);
  rootDisplayA = new GLabel(polyADetails, 182, 50, 208, 30);
  rootDisplayA.setText("__");
  rootDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  rootDisplayA.setOpaque(false);
  label6 = new GLabel(polyADetails, 136, 50, 40, 30);
  label6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label6.setText("Roots");
  label6.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label6.setOpaque(false);
  label3 = new GLabel(polyADetails, 10, 86, 80, 30);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("Leading Coefficient");
  label3.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label3.setOpaque(false);
  leadingCoefficientDisplayA = new GLabel(polyADetails, 96, 86, 34, 30);
  leadingCoefficientDisplayA.setText("__");
  leadingCoefficientDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  leadingCoefficientDisplayA.setOpaque(false);
  posNegDisplayA = new GLabel(polyADetails, 212, 86, 153, 30);
  posNegDisplayA.setText("__");
  posNegDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  posNegDisplayA.setOpaque(false);
  labelS = new GLabel(polyADetails, 136, 86, 70, 30);
  labelS.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelS.setText("Positive or Negative");
  labelS.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  labelS.setOpaque(false);
  label7 = new GLabel(polyADetails, 10, 122, 80, 30);
  label7.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label7.setText("Local Maxima");
  label7.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label7.setOpaque(false);
  localMinimaDisplayA = new GLabel(polyADetails, 268, 122, 80, 30);
  localMinimaDisplayA.setText("__");
  localMinimaDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  localMinimaDisplayA.setOpaque(false);
  label9 = new GLabel(polyADetails, 182, 122, 80, 30);
  label9.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label9.setText("Local Minima");
  label9.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label9.setOpaque(false);
  localMaximaDisplayA = new GLabel(polyADetails, 96, 122, 80, 30);
  localMaximaDisplayA.setText("__");
  localMaximaDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  localMaximaDisplayA.setOpaque(false);
  polyADetails.loop();
  polyADetails.setVisible(false);
} //_CODE_:polyADetails:539846:

synchronized public void win_drawB(PApplet appc, GWinData data) { //_CODE_:polyBDetails:466420:
  appc.background(230);
} //_CODE_:polyBDetails:466420:

public void win_closeB(GWindow window) { //_CODE_:polyBDetails:990108:
polyBDetails = GWindow.getWindow(this, "Polynomial B Details", 900, 0, 400, 165, JAVA2D);
  polyBDetails.noLoop();
  polyBDetails.setActionOnClose(G4P.CLOSE_WINDOW);
  polyBDetails.addDrawHandler(this, "win_drawB");
  polyBDetails.addOnCloseHandler(this, "win_closeB");
  label8 = new GLabel(polyBDetails, 4, 4, 392, 40);
  label8.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label8.setText("Polynomial B Detail Board");
  label8.setOpaque(false);
  label10 = new GLabel(polyBDetails, 10, 50, 80, 30);
  label10.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label10.setText("Common Variable");
  label10.setOpaque(false);
  commonVariableDisplayB = new GLabel(polyBDetails, 96, 50, 34, 30);
  commonVariableDisplayB.setText("__");
  commonVariableDisplayB.setOpaque(false);
  label12 = new GLabel(polyBDetails, 136, 50, 40, 30);
  label12.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label12.setText("Roots");
  label12.setOpaque(false);
  rootDisplayB = new GLabel(polyBDetails, 182, 50, 208, 30);
  rootDisplayB.setText("__");
  rootDisplayB.setOpaque(false);
  label14 = new GLabel(polyBDetails, 10, 86, 80, 30);
  label14.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label14.setText("Leading Coefficient");
  label14.setOpaque(false);
  leadingCoefficientDisplayB = new GLabel(polyBDetails, 96, 86, 34, 30);
  leadingCoefficientDisplayB.setText("__");
  leadingCoefficientDisplayB.setOpaque(false);
  label16 = new GLabel(polyBDetails, 136, 86, 70, 30);
  label16.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label16.setText("Positive or Negative");
  label16.setOpaque(false);
  posNegDisplayB = new GLabel(polyBDetails, 212, 86, 153, 30);
  posNegDisplayB.setText("__");
  posNegDisplayB.setOpaque(false);
  label18 = new GLabel(polyBDetails, 10, 122, 80, 30);
  label18.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label18.setText("Local Maxima");
  label18.setOpaque(false);
  localMaximaDisplayB = new GLabel(polyBDetails, 96, 122, 80, 30);
  localMaximaDisplayB.setText("__");
  localMaximaDisplayB.setOpaque(false);
  label20 = new GLabel(polyBDetails, 182, 122, 80, 30);
  label20.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label20.setText("Local Minima");
  label20.setOpaque(false);
  localMinimaDisplayB = new GLabel(polyBDetails, 268, 122, 80, 30);
  localMinimaDisplayB.setText("__");
  localMinimaDisplayB.setOpaque(false);
  polyBDetails.loop();
  polyBDetails.setVisible(false);
} //_CODE_:polyBDetails:990108:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Graph");
  ControlBoard = GWindow.getWindow(this, "Command Center", 0, 0, 500, 700, JAVA2D);
  ControlBoard.noLoop();
  ControlBoard.setActionOnClose(G4P.EXIT_APP);
  ControlBoard.addDrawHandler(this, "win_drawBoard");
  ControlBoard.addOnCloseHandler(this, "win_closeBoard");
  Title = new GLabel(ControlBoard, 4, 1, 492, 40);
  Title.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Title.setText("Control Board");
  Title.setTextBold();
  Title.setOpaque(false);
  polynomialA = new GTextField(ControlBoard, 96, 50, 214, 30, G4P.SCROLLBARS_NONE);
  polynomialA.setPromptText("Enter a Polynomial...");
  polynomialA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  polynomialA.setOpaque(true);
  polynomialA.addEventHandler(this, "polynomialAUpdate");
  label2 = new GLabel(ControlBoard, 10, 50, 80, 30);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Polynomial A");
  label2.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label2.setOpaque(false);
  degreeBoxA = new GLabel(ControlBoard, 316, 50, 45, 30);
  degreeBoxA.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  degreeBoxA.setText("Degree");
  degreeBoxA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  degreeBoxA.setOpaque(false);
  degreeDisplayA = new GLabel(ControlBoard, 367, 50, 35, 30);
  degreeDisplayA.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  degreeDisplayA.setText("__");
  degreeDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  degreeDisplayA.setOpaque(false);
  infoButtonA = new GButton(ControlBoard, 408, 50, 82, 30);
  infoButtonA.setText("Polynomial A Details");
  infoButtonA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  infoButtonA.addEventHandler(this, "infoButtonAClicked");
  label1 = new GLabel(ControlBoard, 10, 89, 80, 30);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Polynomial B");
  label1.setOpaque(false);
  polynomialB = new GTextField(ControlBoard, 96, 89, 214, 30, G4P.SCROLLBARS_NONE);
  polynomialB.setPromptText("Enter a Polynomial...");
  polynomialB.setOpaque(true);
  polynomialB.addEventHandler(this, "polynomialBUpdate");
  degreeBoxB = new GLabel(ControlBoard, 316, 89, 45, 30);
  degreeBoxB.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  degreeBoxB.setText("Degree");
  degreeBoxB.setOpaque(false);
  degreeDisplayB = new GLabel(ControlBoard, 367, 89, 35, 30);
  degreeDisplayB.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  degreeDisplayB.setText("__");
  degreeDisplayB.setOpaque(false);
  infoButtonB = new GButton(ControlBoard, 408, 89, 82, 30);
  infoButtonB.setText("Polynomial B Details");
  infoButtonB.addEventHandler(this, "infoButtonBClicked");
  label11 = new GLabel(ControlBoard, 3, 135, 492, 30);
  label11.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label11.setText("Operations Information");
  label11.setTextBold();
  label11.setOpaque(false);
  label13 = new GLabel(ControlBoard, 10, 174, 179, 20);
  label13.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label13.setText("Common Variable of A and B");
  label13.setOpaque(false);
  sameVariableDisplay = new GLabel(ControlBoard, 195, 170, 83, 27);
  sameVariableDisplay.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  sameVariableDisplay.setText("__");
  sameVariableDisplay.setOpaque(false);
  differenceDisplayASubB = new GLabel(ControlBoard, 165, 272, 104, 31);
  differenceDisplayASubB.setText("__");
  differenceDisplayASubB.setOpaque(false);
  label17 = new GLabel(ControlBoard, 10, 272, 65, 30);
  label17.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label17.setText("Difference:");
  label17.setOpaque(false);
  sumDisplay = new GLabel(ControlBoard, 56, 200, 438, 30);
  sumDisplay.setText("__");
  sumDisplay.setOpaque(false);
  label22 = new GLabel(ControlBoard, 10, 200, 45, 30);
  label22.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label22.setText("Sum:");
  label22.setOpaque(false);
  label15 = new GLabel(ControlBoard, 10, 236, 60, 30);
  label15.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label15.setText("Product:");
  label15.setOpaque(false);
  productDisplay = new GLabel(ControlBoard, 70, 236, 424, 30);
  productDisplay.setText("__");
  productDisplay.setOpaque(false);
  label19 = new GLabel(ControlBoard, 10, 309, 55, 30);
  label19.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label19.setText("Quotient:");
  label19.setOpaque(false);
  ADivByBDisplay = new GLabel(ControlBoard, 159, 309, 107, 30);
  ADivByBDisplay.setText("__");
  ADivByBDisplay.setOpaque(false);
  remainderAOverBDisplay = new GLabel(ControlBoard, 10, 340, 185, 20);
  remainderAOverBDisplay.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  remainderAOverBDisplay.setText("__");
  remainderAOverBDisplay.setOpaque(false);
  label21 = new GLabel(ControlBoard, 76, 272, 84, 30);
  label21.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label21.setText("Polynomial A-Polynomial B");
  label21.setOpaque(false);
  label27 = new GLabel(ControlBoard, 276, 272, 84, 30);
  label27.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label27.setText("Polynomial B - Polynomial A");
  label27.setOpaque(false);
  differenceDisplayBSubA = new GLabel(ControlBoard, 366, 272, 128, 30);
  differenceDisplayBSubA.setText("__");
  differenceDisplayBSubA.setOpaque(false);
  drawGraphButton = new GButton(ControlBoard, 403, 494, 80, 30);
  drawGraphButton.setText("Draw Graph");
  drawGraphButton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  drawGraphButton.addEventHandler(this, "drawGraphButtonClicked");
  labelhm = new GLabel(ControlBoard, 4, 388, 492, 30);
  labelhm.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelhm.setText("Graph Options");
  labelhm.setTextBold();
  labelhm.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  labelhm.setOpaque(false);
  label28 = new GLabel(ControlBoard, 65, 309, 90, 30);
  label28.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label28.setText("Polynomial A / Polynomial B");
  label28.setOpaque(false);
  label29 = new GLabel(ControlBoard, 269, 309, 90, 30);
  label29.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label29.setText("Polynomial B / Polynomial A");
  label29.setOpaque(false);
  BDivByADisplay = new GLabel(ControlBoard, 366, 308, 128, 30);
  BDivByADisplay.setText("__");
  BDivByADisplay.setOpaque(false);
  label30 = new GLabel(ControlBoard, 10, 425, 80, 20);
  label30.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label30.setText("x Maximum");
  label30.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  label30.setOpaque(false);
  label31 = new GLabel(ControlBoard, 10, 447, 80, 20);
  label31.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label31.setText("x Minimum");
  label31.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  label31.setOpaque(false);
  labelhm2 = new GLabel(ControlBoard, 201, 425, 80, 20);
  labelhm2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelhm2.setText("y Maximum");
  labelhm2.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  labelhm2.setOpaque(false);
  xMaxInput = new GTextField(ControlBoard, 93, 425, 105, 20, G4P.SCROLLBARS_NONE);
  xMaxInput.setText("10");
  xMaxInput.setPromptText("Enter integer...");
  xMaxInput.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  xMaxInput.setOpaque(true);
  xMaxInput.addEventHandler(this, "xMaxInputUpdate");
  xMinInput = new GTextField(ControlBoard, 92, 447, 105, 20, G4P.SCROLLBARS_NONE);
  xMinInput.setText("-10");
  xMinInput.setPromptText("Enter integer...");
  xMinInput.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  xMinInput.setOpaque(true);
  xMinInput.addEventHandler(this, "xMinInputUpdate");
  labelYMin = new GLabel(ControlBoard, 201, 447, 80, 20);
  labelYMin.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelYMin.setText("y Minimum");
  labelYMin.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  labelYMin.setOpaque(false);
  yMaxInput = new GTextField(ControlBoard, 285, 425, 105, 20, G4P.SCROLLBARS_NONE);
  yMaxInput.setText("10");
  yMaxInput.setPromptText("Enter integer...");
  yMaxInput.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  yMaxInput.setOpaque(true);
  yMaxInput.addEventHandler(this, "yMaxInputUpdate");
  yMinInput = new GTextField(ControlBoard, 285, 446, 105, 20, G4P.SCROLLBARS_NONE);
  yMinInput.setText("-10");
  yMinInput.setPromptText("Enter integer...");
  yMinInput.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  yMinInput.setOpaque(true);
  yMinInput.addEventHandler(this, "yMinInputUpdate");
  label2oo = new GLabel(ControlBoard, 10, 470, 80, 20);
  label2oo.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2oo.setText("x Increment");
  label2oo.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  label2oo.setOpaque(false);
  labelwaa = new GLabel(ControlBoard, 201, 470, 80, 20);
  labelwaa.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelwaa.setText("y Increment");
  labelwaa.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  labelwaa.setOpaque(false);
  xIncrementInput = new GTextField(ControlBoard, 94, 470, 105, 20, G4P.SCROLLBARS_NONE);
  xIncrementInput.setText("1");
  xIncrementInput.setPromptText("Enter integer > 0...");
  xIncrementInput.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  xIncrementInput.setOpaque(true);
  xIncrementInput.addEventHandler(this, "xIncrementInputUpdate");
  yIncrementInput = new GTextField(ControlBoard, 285, 470, 105, 20, G4P.SCROLLBARS_NONE);
  yIncrementInput.setText("1");
  yIncrementInput.setPromptText("Enter integer > 0...");
  yIncrementInput.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  yIncrementInput.setOpaque(true);
  yIncrementInput.addEventHandler(this, "yIncrementInputUpdate");
  label26 = new GLabel(ControlBoard, 8, 496, 120, 30);
  label26.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label26.setText("Polynomial A Color");
  label26.setTextBold();
  label26.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  label26.setOpaque(false);
  label32 = new GLabel(ControlBoard, 200, 496, 120, 30);
  label32.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label32.setText("Polynomial B Color");
  label32.setTextBold();
  label32.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  label32.setOpaque(false);
  remainderBOverADisplay = new GLabel(ControlBoard, 269, 340, 225, 20);
  remainderBOverADisplay.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  remainderBOverADisplay.setText("__");
  remainderBOverADisplay.setOpaque(false);
  label33 = new GLabel(ControlBoard, 10, 350, 185, 20);
  label33.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label33.setText("---------------------------------");
  label33.setOpaque(false);
  label34 = new GLabel(ControlBoard, 270, 350, 224, 20);
  label34.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label34.setText("-----------------------------");
  label34.setOpaque(false);
  divisorAOverBDisplay = new GLabel(ControlBoard, 9, 361, 186, 20);
  divisorAOverBDisplay.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  divisorAOverBDisplay.setText("__");
  divisorAOverBDisplay.setOpaque(false);
  divisorBOverADisplay = new GLabel(ControlBoard, 269, 361, 225, 20);
  divisorBOverADisplay.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  divisorBOverADisplay.setText("__");
  divisorBOverADisplay.setOpaque(false);
  runButton = new GButton(ControlBoard, 289, 167, 196, 30);
  runButton.setText("Run Operations + Details");
  runButton.addEventHandler(this, "runButtonClicked");
  label23 = new GLabel(ControlBoard, 195, 339, 80, 20);
  label23.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label23.setText("Remainders");
  label23.setOpaque(false);
  label35 = new GLabel(ControlBoard, 194, 360, 80, 20);
  label35.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label35.setText("Divisors");
  label35.setOpaque(false);
  label36 = new GLabel(ControlBoard, 8, 541, 80, 20);
  label36.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label36.setText("Red");
  label36.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label36.setOpaque(false);
  label37 = new GLabel(ControlBoard, 8, 589, 80, 20);
  label37.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label37.setText("Green");
  label37.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label37.setOpaque(false);
  label38 = new GLabel(ControlBoard, 8, 636, 80, 20);
  label38.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label38.setText("Blue");
  label38.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label38.setOpaque(false);
  label39 = new GLabel(ControlBoard, 200, 636, 80, 20);
  label39.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label39.setText("Blue");
  label39.setOpaque(false);
  label40 = new GLabel(ControlBoard, 200, 589, 80, 20);
  label40.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label40.setText("Green");
  label40.setOpaque(false);
  label41 = new GLabel(ControlBoard, 200, 541, 80, 20);
  label41.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label41.setText("Red");
  label41.setOpaque(false);
  polyARedSlider = new GSlider(ControlBoard, 93, 529, 100, 45, 10.0);
  polyARedSlider.setShowValue(true);
  polyARedSlider.setShowLimits(true);
  polyARedSlider.setLimits(30, 0, 255);
  polyARedSlider.setShowTicks(true);
  polyARedSlider.setNumberFormat(G4P.INTEGER, 0);
  polyARedSlider.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  polyARedSlider.setOpaque(false);
  polyARedSlider.addEventHandler(this, "polyARedSliderUpdate");
  polyBBlueSlider = new GSlider(ControlBoard, 285, 628, 100, 45, 10.0);
  polyBBlueSlider.setShowValue(true);
  polyBBlueSlider.setShowLimits(true);
  polyBBlueSlider.setLimits(0, 0, 255);
  polyBBlueSlider.setShowTicks(true);
  polyBBlueSlider.setNumberFormat(G4P.INTEGER, 0);
  polyBBlueSlider.setOpaque(false);
  polyBBlueSlider.addEventHandler(this, "polyBBlueSliderUpdate");
  polyBGreenSlider = new GSlider(ControlBoard, 284, 576, 100, 45, 10.0);
  polyBGreenSlider.setShowValue(true);
  polyBGreenSlider.setShowLimits(true);
  polyBGreenSlider.setLimits(120, 0, 255);
  polyBGreenSlider.setShowTicks(true);
  polyBGreenSlider.setNumberFormat(G4P.INTEGER, 0);
  polyBGreenSlider.setOpaque(false);
  polyBGreenSlider.addEventHandler(this, "polyBGreenSliderUpdate");
  polyBRedSlider = new GSlider(ControlBoard, 284, 529, 100, 45, 10.0);
  polyBRedSlider.setShowValue(true);
  polyBRedSlider.setShowLimits(true);
  polyBRedSlider.setLimits(255, 0, 255);
  polyBRedSlider.setShowTicks(true);
  polyBRedSlider.setNumberFormat(G4P.INTEGER, 0);
  polyBRedSlider.setOpaque(false);
  polyBRedSlider.addEventHandler(this, "polyBRedSliderUpdate");
  polyABlueSlider = new GSlider(ControlBoard, 91, 628, 100, 45, 10.0);
  polyABlueSlider.setShowValue(true);
  polyABlueSlider.setShowLimits(true);
  polyABlueSlider.setLimits(30, 0, 255);
  polyABlueSlider.setShowTicks(true);
  polyABlueSlider.setNumberFormat(G4P.INTEGER, 0);
  polyABlueSlider.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  polyABlueSlider.setOpaque(false);
  polyABlueSlider.addEventHandler(this, "polyABlueSliderUpdate");
  polyAGreenSlider = new GSlider(ControlBoard, 92, 578, 100, 45, 10.0);
  polyAGreenSlider.setShowValue(true);
  polyAGreenSlider.setShowLimits(true);
  polyAGreenSlider.setLimits(170, 0, 255);
  polyAGreenSlider.setShowTicks(true);
  polyAGreenSlider.setNumberFormat(G4P.INTEGER, 0);
  polyAGreenSlider.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  polyAGreenSlider.setOpaque(false);
  polyAGreenSlider.addEventHandler(this, "polyAGreenSliderUpdate");
  graphErrorText = new GLabel(ControlBoard, 403, 541, 80, 100);
  graphErrorText.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  graphErrorText.setOpaque(false);
  polyADetails = GWindow.getWindow(this, "Polynomial A Details", 500, 0, 400, 200, JAVA2D);
  polyADetails.noLoop();
  polyADetails.setActionOnClose(G4P.CLOSE_WINDOW);
  polyADetails.addDrawHandler(this, "win_drawA");
  polyADetails.addOnCloseHandler(this, "win_closeA");
  label5 = new GLabel(polyADetails, 4, 4, 392, 40);
  label5.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label5.setText("Polynomial A Detail Board");
  label5.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label5.setOpaque(false);
  commonVariableDisplayA = new GLabel(polyADetails, 70, 44, 79, 41);
  commonVariableDisplayA.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  commonVariableDisplayA.setText("__");
  commonVariableDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  commonVariableDisplayA.setOpaque(false);
  label4 = new GLabel(polyADetails, 10, 50, 56, 30);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setText("Common Variable");
  label4.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label4.setOpaque(false);
  rootDisplayA = new GLabel(polyADetails, 199, 50, 193, 30);
  rootDisplayA.setText("__");
  rootDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  rootDisplayA.setOpaque(false);
  label6 = new GLabel(polyADetails, 153, 50, 40, 30);
  label6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label6.setText("Roots");
  label6.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label6.setOpaque(false);
  label3 = new GLabel(polyADetails, 10, 86, 80, 30);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("Leading Coefficient");
  label3.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label3.setOpaque(false);
  leadingCoefficientDisplayA = new GLabel(polyADetails, 96, 86, 34, 30);
  leadingCoefficientDisplayA.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  leadingCoefficientDisplayA.setText("__");
  leadingCoefficientDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  leadingCoefficientDisplayA.setOpaque(false);
  posNegDisplayA = new GLabel(polyADetails, 212, 86, 153, 30);
  posNegDisplayA.setText("__");
  posNegDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  posNegDisplayA.setOpaque(false);
  labelS = new GLabel(polyADetails, 136, 86, 70, 30);
  labelS.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelS.setText("Positive or Negative");
  labelS.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  labelS.setOpaque(false);
  label7 = new GLabel(polyADetails, 10, 122, 80, 30);
  label7.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label7.setText("Local Maxima");
  label7.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label7.setOpaque(false);
  localMinimaDisplayA = new GLabel(polyADetails, 268, 122, 80, 30);
  localMinimaDisplayA.setText("__");
  localMinimaDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  localMinimaDisplayA.setOpaque(false);
  label9 = new GLabel(polyADetails, 182, 122, 80, 30);
  label9.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label9.setText("Local Minima");
  label9.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label9.setOpaque(false);
  localMaximaDisplayA = new GLabel(polyADetails, 96, 122, 80, 30);
  localMaximaDisplayA.setText("__");
  localMaximaDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  localMaximaDisplayA.setOpaque(false);
  label24 = new GLabel(polyADetails, 10, 158, 80, 30);
  label24.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label24.setText("Rearranged Polynomial");
  label24.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label24.setOpaque(false);
  arrangedDisplayA = new GLabel(polyADetails, 96, 158, 297, 30);
  arrangedDisplayA.setText("__");
  arrangedDisplayA.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  arrangedDisplayA.setOpaque(false);
  polyBDetails = GWindow.getWindow(this, "Polynomial B Details", 900, 0, 400, 200, JAVA2D);
  polyBDetails.noLoop();
  polyBDetails.setActionOnClose(G4P.CLOSE_WINDOW);
  polyBDetails.addDrawHandler(this, "win_drawB");
  polyBDetails.addOnCloseHandler(this, "win_closeB");
  label8 = new GLabel(polyBDetails, 4, 4, 392, 40);
  label8.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label8.setText("Polynomial B Detail Board");
  label8.setOpaque(false);
  label10 = new GLabel(polyBDetails, 10, 50, 56, 30);
  label10.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label10.setText("Common Variable");
  label10.setOpaque(false);
  commonVariableDisplayB = new GLabel(polyBDetails, 70, 44, 79, 41);
  commonVariableDisplayB.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  commonVariableDisplayB.setText("__");
  commonVariableDisplayB.setOpaque(false);
  label12 = new GLabel(polyBDetails, 153, 50, 40, 30);
  label12.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label12.setText("Roots");
  label12.setOpaque(false);
  rootDisplayB = new GLabel(polyBDetails, 199, 50, 193, 30);
  rootDisplayB.setText("__");
  rootDisplayB.setOpaque(false);
  label14 = new GLabel(polyBDetails, 10, 86, 80, 30);
  label14.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label14.setText("Leading Coefficient");
  label14.setOpaque(false);
  leadingCoefficientDisplayB = new GLabel(polyBDetails, 96, 86, 34, 30);
  leadingCoefficientDisplayB.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  leadingCoefficientDisplayB.setText("__");
  leadingCoefficientDisplayB.setOpaque(false);
  label16 = new GLabel(polyBDetails, 136, 86, 70, 30);
  label16.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label16.setText("Positive or Negative");
  label16.setOpaque(false);
  posNegDisplayB = new GLabel(polyBDetails, 212, 86, 153, 30);
  posNegDisplayB.setText("__");
  posNegDisplayB.setOpaque(false);
  label18 = new GLabel(polyBDetails, 10, 122, 80, 30);
  label18.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label18.setText("Local Maxima");
  label18.setOpaque(false);
  localMaximaDisplayB = new GLabel(polyBDetails, 96, 122, 80, 30);
  localMaximaDisplayB.setText("__");
  localMaximaDisplayB.setOpaque(false);
  label20 = new GLabel(polyBDetails, 182, 122, 80, 30);
  label20.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label20.setText("Local Minima");
  label20.setOpaque(false);
  localMinimaDisplayB = new GLabel(polyBDetails, 268, 122, 80, 30);
  localMinimaDisplayB.setText("__");
  localMinimaDisplayB.setOpaque(false);
  label25 = new GLabel(polyBDetails, 10, 158, 80, 30);
  label25.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label25.setText("Rearranged Polynomial");
  label25.setOpaque(false);
  arrangedDisplayB = new GLabel(polyBDetails, 96, 158, 297, 30);
  arrangedDisplayB.setText("__");
  arrangedDisplayB.setOpaque(false);
  ControlBoard.loop();
  polyADetails.loop();
  polyBDetails.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow ControlBoard;
GLabel Title; 
GTextField polynomialA; 
GLabel label2; 
GLabel degreeBoxA; 
GLabel degreeDisplayA; 
GButton infoButtonA; 
GLabel label1; 
GTextField polynomialB; 
GLabel degreeBoxB; 
GLabel degreeDisplayB; 
GButton infoButtonB; 
GLabel label11; 
GLabel label13; 
GLabel sameVariableDisplay; 
GLabel differenceDisplayASubB; 
GLabel label17; 
GLabel sumDisplay; 
GLabel label22; 
GLabel label15; 
GLabel productDisplay; 
GLabel label19; 
GLabel ADivByBDisplay; 
GLabel remainderAOverBDisplay; 
GLabel label21; 
GLabel label27; 
GLabel differenceDisplayBSubA; 
GButton drawGraphButton; 
GLabel labelhm; 
GLabel label28; 
GLabel label29; 
GLabel BDivByADisplay; 
GLabel label30; 
GLabel label31; 
GLabel labelhm2; 
GTextField xMaxInput; 
GTextField xMinInput; 
GLabel labelYMin; 
GTextField yMaxInput; 
GTextField yMinInput; 
GLabel label2oo; 
GLabel labelwaa; 
GTextField xIncrementInput; 
GTextField yIncrementInput; 
GLabel label26; 
GLabel label32; 
GLabel remainderBOverADisplay; 
GLabel label33; 
GLabel label34; 
GLabel divisorAOverBDisplay; 
GLabel divisorBOverADisplay; 
GButton runButton; 
GLabel label23; 
GLabel label35; 
GLabel label36; 
GLabel label37; 
GLabel label38; 
GLabel label39; 
GLabel label40; 
GLabel label41; 
GSlider polyARedSlider; 
GSlider polyBBlueSlider; 
GSlider polyBGreenSlider; 
GSlider polyBRedSlider; 
GSlider polyABlueSlider; 
GSlider polyAGreenSlider; 
GLabel graphErrorText; 
GWindow polyADetails;
GLabel label5; 
GLabel commonVariableDisplayA; 
GLabel label4; 
GLabel rootDisplayA; 
GLabel label6; 
GLabel label3; 
GLabel leadingCoefficientDisplayA; 
GLabel posNegDisplayA; 
GLabel labelS; 
GLabel label7; 
GLabel localMinimaDisplayA; 
GLabel label9; 
GLabel localMaximaDisplayA; 
GLabel label24; 
GLabel arrangedDisplayA; 
GWindow polyBDetails;
GLabel label8; 
GLabel label10; 
GLabel commonVariableDisplayB; 
GLabel label12; 
GLabel rootDisplayB; 
GLabel label14; 
GLabel leadingCoefficientDisplayB; 
GLabel label16; 
GLabel posNegDisplayB; 
GLabel label18; 
GLabel localMaximaDisplayB; 
GLabel label20; 
GLabel localMinimaDisplayB; 
GLabel label25; 
GLabel arrangedDisplayB; 
