static class Polynomial {
  boolean validSign;
  String variable, posNeg, polynomial;
  int degree, leadingCoefficient;
  int[] exponents;
  int[] coefficients;
  String[] roots;
  String[] minima;
  String[] maxima;
  String rootDisplay, minimaDisplay, maximaDisplay;
  
  Polynomial(String p) {
    // Checks if any polynomial is written
    if (p.length() > 0) {
      this.validSign = checkSign(p);
      
      // Looks for variables when the characters provided are valid
      if (this.validSign) {
        this.variable = getCommonVariable(p);
        
        // If the other two checks succeed, all other functions to gather information will run
        if (this.variable.length() == 1 || this.variable.equals("No variables exist")) {
          getDegreeAndExponents(p);
          getCoefficients(p);
          rearrange();
          rewritePolynomial();
          this.posNeg = isNegative();
          this.roots = findRoots();
        }    
      }
      // Reports to user if any characters that are entered are invalid
      else {
        this.polynomial = "Polynomial error: Invalid characters";
      }
    }
    
    // Reports to user that nothing is written
    else {
      this.validSign = false;
      this.polynomial = "Error: No polynomial written";
    }
  }
  
  boolean checkSign(String p) {
    char[] characters = p.toCharArray();
    for (int i = 0; i < characters.length; i++) {
      switch(characters[i]) {
        // If character is valid, move to next one
        case '+':
        case '-':
        case '^':
        case ' ':
          break;
        default:
          // Checks if character is a number using ASCII
          if (int(characters[i]) >= 48 && int(characters[i]) <= 57) {
            break;
          }
          // If character is an invalid character for polynomial, then the equation is invalid
          else if (int(characters[i]) < 97 || int(characters[i]) > 122) {
            return false;
          }
      }
    }
    return true;
  }
  
  String getCommonVariable(String p) {
    char[] characters = p.toCharArray();
    ArrayList<String> strChars = new ArrayList<String>();
    
    // Convert characters from array into arraylist of strings so some characters may be freely removed
    for (int i = 0; i < characters.length; i++) {
      strChars.add(str(characters[i]));
    }
    
    // Remove numbers, signs (^, +/-), and spaces from the arraylist
    int testInt;
    for (int i = 0; i < strChars.size(); i++) {
      testInt = int(strChars.get(i));
      
      // Removes all numbers (excluding 0) in arraylist
      if (testInt != 0) {
        strChars.remove(i);
        i--;
      }
      // Removes signs, spaces, and zeros from arraylist
      else {
        switch(strChars.get(i)) {
          case "^":
          case "-":
          case "+":
          case "0":
          case " ":
            strChars.remove(i);
            i--;
        }
      }
    }
    
    // If any variables remain, check to see they match to satisfy common variable
    String variable;
    if (strChars.size() > 0) {
      variable = strChars.get(0);
      for (int i = 0; i < strChars.size(); i++) {
        if (!strChars.get(i).equals(variable)) {
          variable = "Error: no common variable";
        }
      }
    }
    // If no variables are present and the line is a horizontal line
    else {
      variable = "No variables exist";
    }
    
    return variable;
  }
  
  void getDegreeAndExponents(String p) {
    // If equation is simply a constant
    if (p.indexOf(this.variable) == -1) {
      this.degree = 0;
      this.exponents = new int[1];
      this.exponents[0] = 0;
    }
    // If equation has variables
    else {
      char[] characters = p.toCharArray();
      ArrayList<String> strChars = new ArrayList<String>();
      
      // Change all minus signs to plus signs to make working with strings easier, as coefficients do not matter here
      for (int i = 0; i < characters.length; i++) {
        if (characters[i] == '-') {
          characters[i] = '+';
        }
      }
      
      // Convert characters from array into arraylist of strings so some characters may be freely removed
      for (int i = 0; i < characters.length; i++) {
        strChars.add(str(characters[i]));
      }
      
      // Remove exponent signs and spaces from the arraylist
      for (int i = 0; i < strChars.size(); i++) {       
        // Removes signs and spaces from arraylist
        if (strChars.get(i).equals("^") || strChars.get(i).equals(" ")) {
          strChars.remove(i);
          i--;
        }
      }
      
      // Gather exponents
      ArrayList<Integer> exponents = new ArrayList<Integer>();
      boolean conLeftOpen = false; // If everything from the left starts with a plus sign and ends on a plus sign without meeting variables (for constants)
      
      for (int i = 0; i < strChars.size(); i++) {
        if (strChars.get(i).equals(this.variable)) {
          try {
            // If there is no exponent written after, the exponent is 1
            if (strChars.get(i + 1).equals("+")) {
              exponents.add(1);
            }
            // If there is an exponent written after, take the exponent and add into arraylist
            else {
              ArrayList<String> digits = new ArrayList<String>();
              int j = i + 1;
              
              // If exponent has two or more digits
              try {
                while (!strChars.get(j).equals("+") && j < strChars.size()) {
                  digits.add(strChars.get(j));
                  j++;
                }
              }
              catch (Exception e) {
              }
              
              String[] combineDigits = new String[digits.size()];
              for (int n = 0; n < digits.size(); n++) {
                combineDigits[n] = digits.get(n);
              }
              
              exponents.add(int(join(combineDigits, "")));
            }
          }
          // If we cannot find anything written after x, the polynomial is simply degree 1 and adds the only exponent
          catch (Exception e) {
            exponents.add(1);
          }
        }
        
        // Find constants
        else if (!strChars.get(i).equals("+")) { // Since only characters are digits, variables, and plus signs, statement is "if character is a number"
          try {
            // If constant were to be at the beginning of the root, we only worry about what's on the right
            if (i == 0) {
              if (strChars.get(i + 1).equals("+")) {
                exponents.add(0);
              }
              // Constants with more than one digit
              else if (!strChars.get(i + 1).equals(this.variable)) {
                for (int a = i + 1; a < strChars.size(); a++) {
                  if (strChars.get(a).equals(this.variable)) {
                    break;
                  }
                  else if (strChars.get(a).equals("+")) {
                    exponents.add(0);
                    break;
                  }
                }
              }
            }
            
            // If constant were to be at the end, we only worry about what's on the left
            else if (i == strChars.size() - 1) {
              if (strChars.get(i - 1).equals("+")) {
                exponents.add(0);
              }
              else if (!strChars.get(i - 1).equals(this.variable)) {
                for (int a = i - 1; a >= 0; a--) {
                  if (strChars.get(a).equals(this.variable)) {
                    break;
                  }
                  else if (strChars.get(a).equals("+")) {
                    exponents.add(0);
                    break;
                  }
                }
              }
            }
            else {
              // If constant is a single digit
              if (strChars.get(i - 1).equals("+") && strChars.get(i + 1).equals("+")) {
                exponents.add(0);
              }
              // If the digit being verified is beside a variable, close the left end
              else if (strChars.get(i - 1).equals(this.variable) || strChars.get(i + 1).equals(this.variable)) {
                conLeftOpen = false;
              }
              else {
                // First digit of constant
                if (strChars.get(i - 1).equals("+")) {
                  conLeftOpen = true;
                }
                // Verifies that the constant is not simply a coefficient, and adds the exponent
                else if (strChars.get(i + 1).equals("+")) {                 
                  if (conLeftOpen) {
                    exponents.add(0);
                    conLeftOpen = false;
                  }
                }
              }
            }
          }
          // If the loops go out of range, they are constants because no variables are beside
          catch (Exception e) {
            exponents.add(0);
          }
        }
      }
      
      // Convert arraylist into array and return to class field
      int[] listExponents = new int[exponents.size()];
      for (int i = 0; i < exponents.size(); i++) {
        listExponents[i] = exponents.get(i);
      }
      this.exponents = listExponents;
      
      // Find highest exponent, which is the degree of the polynomial
      this.degree = max(listExponents);
    }
  }
  
  void getCoefficients(String p) {
    // If equation is simply a constant
    if (p.indexOf(this.variable) == -1) {
      this.coefficients = new int[1];
      this.coefficients[0] = int(p);
    }
    // If equation has variables
    else {
      char[] characters = p.toCharArray();
      ArrayList<String> strChars = new ArrayList<String>();
      
      // Convert characters from array into arraylist of strings so some characters may be freely removed
      for (int i = 0; i < characters.length; i++) {
        strChars.add(str(characters[i]));
      }
      
      // Removes exponents
      for (int i = 0; i < strChars.size(); i++) {
        if (strChars.get(i).equals("^")) {
          int j = i + 1;
          try {
            while ((!strChars.get(j).equals("+") && !strChars.get(j).equals("-")) && j < strChars.size()) {
              strChars.remove(j);
            }
          }
          // Loop stops once out of range
          catch (Exception e) {
          }
        }
      }
      
      // Remove exponent signs and spaces from the arraylist
      for (int i = 0; i < strChars.size(); i++) {       
        // Removes signs and spaces from arraylist
        if (strChars.get(i).equals("^") || strChars.get(i).equals(" ")) {
          strChars.remove(i);
          i--;
        }
      }
      
      // Gather coefficients
      ArrayList<Integer> coefficients = new ArrayList<Integer>();
      StringList constantDigits = new StringList();
      boolean conLeftOpen = false;
      
      for (int i = 0; i < strChars.size(); i++) {
        if (strChars.get(i).equals(this.variable)) {
          try {
            // If there is no coefficient written before, the coefficient is 1
            if (strChars.get(i - 1).equals("+")) {            
              coefficients.add(1);
            }
            // If there is a negative sign written before, the coefficient is -1
            else if (strChars.get(i - 1).equals("-")) {
              coefficients.add(-1);
            }
            // If there is an coefficient written before, take the coefficient and add into string list
            else {
              StringList digits = new StringList();
              int j = i - 1;
              
              // If coefficient has two or more digits
              try {
                while ((!strChars.get(j).equals("+") && !strChars.get(j).equals("-")) && j >= 0) {
                  digits.append(strChars.get(j));
                  j--;
                }
                
                // If coefficient is also negative
                if (strChars.get(j).equals("-")) {
                  digits.append(strChars.get(j));
                }
              }
              catch (Exception e) {
              }
              
              // Since it worked backwards, reverse order of array values
              digits.reverse();
              
              String[] combineDigits = new String[digits.size()];
              for (int n = 0; n < digits.size(); n++) {
                combineDigits[n] = digits.get(n);
              }
              
              coefficients.add(int(join(combineDigits, "")));
            }
          }
          // If we cannot find anything written before x, the coefficient is again 1
          catch (Exception e) {
            coefficients.add(1);
          }
        }
        
        // Find constants
        else if (!strChars.get(i).equals("+")) {
          // If constant begins at the first character, only focus on what's on the right
          if (i == 0) {
            // If first character is the only digit
            if (strChars.get(i + 1).equals("+") || strChars.get(i + 1).equals("-")) {
              coefficients.add(int(strChars.get(i)));
            }
            // If first character is the first digit of a multi digit constant
            else if (!strChars.get(i + 1).equals(this.variable)) {
              conLeftOpen = true;
              constantDigits.append(strChars.get(i));
            }
          }
          
          // If digits reach the end of the polynomial, only focus on what's on the left
          else if (i == strChars.size() - 1) {
            // Single digit constant at the end
            if (strChars.get(i - 1).equals("+")) {
              coefficients.add(int(strChars.get(i)));
            }
            // Multi digit constant at the end
            else {
              if (conLeftOpen) {
                constantDigits.append(strChars.get(i));
                
                String[] combineConstant = new String[constantDigits.size()];
                for (int n = 0; n < constantDigits.size(); n++) {
                  combineConstant[n] = constantDigits.get(n);
                }
                
                coefficients.add(int(join(combineConstant, "")));
                conLeftOpen = false;
                constantDigits = new StringList();
              }
            }
          }
          
          // If the constant is found anywhere else in the equation
          else {
            // Because coefficients can be negative, we want to include the negative signs
            if (strChars.get(i).equals("-")) {
              conLeftOpen = true;
              constantDigits.append(strChars.get(i));
            }
            else {
              // If there is a variable after the digits, it is not a constant
              if (strChars.get(i + 1).equals(this.variable)) {
                conLeftOpen = false;
                constantDigits = new StringList();
              }
              // If signs are on both sides, it is a single positive digit constant
              else if (strChars.get(i - 1).equals("+") && (strChars.get(i + 1).equals("+") || strChars.get(i + 1).equals("-"))) {
                coefficients.add(int(strChars.get(i)));
              }
              // If plus sign is on the left of a digit but not on the other, there is an open left end and the constant has more than one digit
              else if (strChars.get(i - 1).equals("+")) {
                conLeftOpen = true;
                constantDigits.append(strChars.get(i));
              }
              // If plus or minus sign is on the right side, the digits stop there and it is confirmed to be a constant if left end is open
              else if (strChars.get(i + 1).equals("+") || strChars.get(i + 1).equals("-")) {
                if (conLeftOpen) {
                  constantDigits.append(strChars.get(i));
              
                  String[] combineConstant = new String[constantDigits.size()];
                  for (int n = 0; n < constantDigits.size(); n++) {
                    combineConstant[n] = constantDigits.get(n);
                  }
                
                  coefficients.add(int(join(combineConstant, "")));
                  conLeftOpen = false;
                  constantDigits = new StringList();
                }
              }
              else {
                constantDigits.append(strChars.get(i));
              }
            }
          }
        }
      }
      
      // Convert arraylist into array and return to class field
      int[] listCoefficients = new int[coefficients.size()];
      for (int i = 0; i < coefficients.size(); i++) {
        listCoefficients[i] = coefficients.get(i);
      }
      
      this.coefficients = listCoefficients;
    }
  }
  
  void rewritePolynomial() {
    // To rewrite polynomial with no variables or exponents (degree 0)
    if (this.degree == 0) {
      this.polynomial = str(this.coefficients[0]);
    }
    
    // To rewrite polynomial with no exponents (degree 1)
    else if (this.degree == 1) {
      // With constant after
      if (this.exponents.length > 1) {
        String[] twoTerms = new String[2]; // Two terms, one with exponent of 1 and the other with constant
        // If the exponent of 1 has a coefficient of 1, the "1" does not need to be printed with the variable
        if (this.coefficients[0] == 1) {
          twoTerms[0] = this.variable;
        }
        // If the exponent of 1 has a coefficient of -1, only "-" needs to be printed with the variable
        else if (this.coefficients[0] == -1) {
          twoTerms[0] = "-" + this.variable;
        }
        // Both the coefficient and variable to be printed
        else {
          twoTerms[0] = str(this.coefficients[0]) + this.variable;
        }
        
        // For the constant, if the constant is positive, print a "+" with the constant
        if (this.coefficients[1] > 0) {
          twoTerms[1] = "+" + str(this.coefficients[1]);
        }
        // If the constant is negative, just print the integer
        else {
          twoTerms[1] = str(this.coefficients[1]);
        }
        this.polynomial = join(twoTerms, "");
      }
      
      // Without a constant after
      else {
        // If the exponent of 1 has a coefficient of 1, the "1" does not need to be printed with the variable
        if (this.coefficients[0] == 1) {
          this.polynomial = this.variable;
        }
        // If the exponent of 1 has a coefficient of -1, only "-" needs to be printed with the variable
        else if (this.coefficients[0] == -1) {
          this.polynomial = "-" + this.variable;
        }
        // Both the coefficient and variable need to be printed
        else {
          this.polynomial = str(this.coefficients[0]) + this.variable;
        }
      }
    }
    
    // For any other degree
    else {
      String[] terms = new String[this.exponents.length];
      
      for (int i = 0; i < this.exponents.length; i++) {
        // First term
        if (i == 0) {
          // If coefficient is not needed to be written (coefficient of 1)
          if (this.coefficients[0] == 1) {
            terms[0] = this.variable + "^" + str(this.exponents[0]);
          }
          // If coefficient is -1, then the 1 does not need to be written
          else if (this.coefficients[0] == -1) {
            terms[0] = "-" + this.variable + "^" + str(this.exponents[0]);
          }
          // Any other coefficient
          else {
            terms[0] = str(this.coefficients[0]) + this.variable + "^" + str(this.exponents[0]);
          }
        }
        else {    
          // Exponent of 1
          if (this.exponents[i] == 1) {
            // Positive coefficient
            if (this.coefficients[i] > 0) {
              // Coefficient of 1
              if (this.coefficients[i] == 1) {
                terms[i] = "+" + this.variable;
              }
              else {
                terms[i] = "+" + str(this.coefficients[i]) + this.variable;
              }
            }
            // Negative coefficient
            else {
              // Coefficient of -1
              if (this.coefficients[i] == -1) {
                terms[i] = "-" + this.variable;
              }
              else {
                terms[i] = str(this.coefficients[i]) + this.variable;
              }
            }
          }
          
          // Constants
          else if (this.exponents[i] == 0) {
            if (this.coefficients[i] > 0) {
              terms[i] = "+" + str(this.coefficients[i]);
            }
            else {
              terms[i] = str(this.coefficients[i]);
            }
          }
          
          // Any other exponent
          else {
            // Positive coefficient
            if (this.coefficients[i] > 0) {
              // Coefficient of 1
              if (this.coefficients[i] == 1) {
                terms[i] = "+" + this.variable + "^" + str(this.exponents[i]);
              }
              else {
                terms[i] = "+" + str(this.coefficients[i]) + this.variable + "^" + str(this.exponents[i]);
              }
            }
            // Negative coefficient
            else {
              // Coefficient of -1
              if (this.coefficients[i] == -1) {
                terms[i] = "-" + this.variable + "^" + str(this.exponents[i]);
              }
              else {
                terms[i] = str(this.coefficients[i]) + this.variable + "^" + str(this.exponents[i]);
              }
            }
          }
        }
      }
      this.polynomial = join(terms, "");
    }
  }
  
  String isNegative() {
    // If coefficient is negative, return true (is negative)
    if (this.coefficients[0] < 0) {
      return "Negative";
    }
    // Otherwise, return false (is not negative)
    else {
      return "Positive";
    }
  }
  
  void rearrange() {  
    ArrayList<Integer> arrangedExpF = new ArrayList<Integer>();
    ArrayList<Integer> arrangedCoeF = new ArrayList<Integer>();
    ArrayList<Integer> expO = new ArrayList<Integer>();
    ArrayList<Integer> coeO = new ArrayList<Integer>();
    
    // Move all exponents into arraylist
    for (int a = 0; a < this.exponents.length; a++) {
      expO.add(this.exponents[a]);
      coeO.add(this.coefficients[a]);
    }
    
    // Rearrange exponents and coefficients simultaneously sorting from highest to lowest degree
    while (expO.size() > 0) {
      int max = 0;
      int index = 0;
      
      // Find highest value in current arraylist
      for (int i = 0; i < expO.size(); i++) {
         if (max < expO.get(i)) {
           max = expO.get(i);
           index = i;
         }
      }
      
      // Add current highest exponent and coefficient to sorted arraylist
      arrangedExpF.add(max);
      arrangedCoeF.add(coeO.get(index));
      expO.remove(index);
      coeO.remove(index);
    }
    
    // Combine like terms and simplify polynomial
    for (int i = 0; i < arrangedExpF.size(); i++) {
      for (int j = 0; j < arrangedExpF.size(); j++) {
        // If there are multiple indices with the same exponent, combine the coefficients and remove duplicate exponents (as well as the coefficient at that exponent)
        if (j != i && arrangedExpF.get(j) == arrangedExpF.get(i)) {
          int newCoe = arrangedCoeF.get(i) + arrangedCoeF.get(j); // Combine coefficients
          arrangedCoeF.set(i, newCoe);
          arrangedExpF.remove(j); // Leave only the original exponent
          arrangedCoeF.remove(j); // Remove coefficient at the same index as removed exponent
          j--; // Go back one index and find more repeating exponents
        }
      }
    }
    
    // Remove coefficients of 0 and their exponents because it is a constant
    for (int i = 0; i < arrangedCoeF.size(); i++) {
      if (arrangedCoeF.get(i) == 0) {
        arrangedExpF.remove(i);
        arrangedCoeF.remove(i);
        i--;
      }
    }
    
    // Form arrays
    int[] aExpF;
    int[] aCoeF;
    
    // If there are still exponents
    if (arrangedExpF.size() > 0) {
      aExpF = new int[arrangedExpF.size()];
      aCoeF = new int[arrangedCoeF.size()];
      this.degree = arrangedExpF.get(0);
      this.leadingCoefficient = arrangedCoeF.get(0);
    
      // Convert arraylist to arrays    
      for (int e = 0; e < arrangedExpF.size(); e++) {
        aExpF[e] = arrangedExpF.get(e);
        aCoeF[e] = arrangedCoeF.get(e); 
      }
    }
    // Polynomial will be a straight line at y = 0
    else {
      aExpF = new int[1];
      aCoeF = new int[1];
      
      aExpF[0] = 0;
      aCoeF[0] = 0;
      
      this.degree = 0;
    }
    
    // Replace current arrays with rearranged arrays
    this.exponents = aExpF;
    this.coefficients = aCoeF;
  }
  
  String[] findRoots() { // Use integer root theorem to find all rational roots in given polynomial
    ArrayList<String> roots = new ArrayList<String>();
    ArrayList<Integer> rootNums = new ArrayList<Integer>();
    ArrayList<Integer> rootDens = new ArrayList<Integer>();
    ArrayList<Float> rootVals = new ArrayList<Float>();
    ArrayList<String> arrangedRoots = new ArrayList<String>();
    
    // Check if there is no constant, then there will be a root of 0 because x can be factored out
    if (this.exponents[this.exponents.length - 1] != 0) { // Arrays are sorted, if 0 is not lowest exponent, there is a factor of 0
      roots.add("0");
      rootNums.add(0);
      rootDens.add(1);
      rootVals.add(0.0);
    }
    // If polynomial is simply a line at 0
    else if (this.leadingCoefficient == 0 && this.degree == 0) {
      String[] lineAt0 = new String[1];
      lineAt0[0] = "0";
      
      return lineAt0;
    }
    
    float firstCo = this.coefficients[0];
    float lastCo = this.coefficients[this.coefficients.length - 1];
    ArrayList<Integer> num = new ArrayList<Integer>();
    ArrayList<Integer> den = new ArrayList<Integer>();    
    
    // Make the leading coefficient and final coefficient positive to find factors
    if (firstCo < 0) {
      firstCo *= -1;
    }
    if (lastCo < 0) {
      lastCo *= -1;
    }
    
    // Final coefficient factors will be numerators
    for (int i = 1; i <= lastCo; i++) {
      if (lastCo % i == 0) {
        num.add(i);
        num.add(i * -1);
      }
    }
    
    // Leading coefficient factors will be denominators
    for (int i = 1; i <= firstCo; i++) {
      if (firstCo % i == 0) {
        den.add(i);
      }
    }
    
    // Find all rational values that make the function equal 0
    for (int i = 0; i < den.size(); i++) {
      for (int j = 0; j < num.size(); j++) {
        float x = num.get(j) / float(den.get(i));
        
        if (round(evaluateAtX(x)) == 0) { // Grabs integer value that assumes whether one value is close enough or not (because floats are inaccurate)
          rootNums.add(num.get(j));
          rootDens.add(den.get(i));
          rootVals.add(x); // Adds the float of the rational value to help sort roots in order
          
          // Add the strings of the rational values
          if (den.get(i) == 1) { // If dividing by 1, "/1" is not necessary
            roots.add(str(num.get(j)));
          }
          else { // We can create the string for unsimplified fractions now because the simplified fractions come first as numerators are used starting from 1
            roots.add(str(num.get(j)) + "/" + str(den.get(i))); // and the duplicates of the simplified fraction will be deleted later on
          }
        }
      }
    }
    
    // Simplify each fraction
    for (int i = 0; i < rootNums.size(); i++) {
      // For every fraction aside from 0/1, because 0/1 does not need simplifying and would break GCD function
      if (rootNums.get(i) != 0) {
        int indexGCD = getGCD(rootNums.get(i), rootDens.get(i));
        
        rootNums.set(i, rootNums.get(i) / indexGCD);
        rootDens.set(i, rootDens.get(i) / indexGCD);
      }
    }
    
    // Remove duplicate fractions
    for (int i = 0; i < rootNums.size(); i++) {
      for (int j = 0; j < rootNums.size(); j++) {
        if (j != i && rootNums.get(j) == rootNums.get(i) && rootDens.get(j) == rootDens.get(i)) {          
          rootNums.remove(j);
          rootDens.remove(j);
          rootVals.remove(j);
          roots.remove(j);
          j--;
        }
      }
    }
    
    // Use the float values of remaining fractions to sort from least to greatest
    while (rootVals.size() > 0) {
      float min = rootVals.get(0);
      int index = 0;
      
      // Find lowest value in current arraylist
      for (int i = 0; i < rootVals.size(); i++) {
         if (min > rootVals.get(i)) {
           min = rootVals.get(i);
           index = i;
         }
      }
      
      // Add the string at the same index as the lowest value to arraylist
      arrangedRoots.add(roots.get(index));
      roots.remove(index);
      rootVals.remove(index);
    }
    
    String[] rootArray;
    // If no rational roots were to be found
    if (arrangedRoots.size() == 0) {      
      rootArray = new String[1];
      rootArray[0] = "No rational roots";
    }
    
    // Convert arraylist to array and return array
    else {
      rootArray = new String[arrangedRoots.size()];
      for (int i = 0; i < arrangedRoots.size(); i++) {
        rootArray[i] = arrangedRoots.get(i);
      }
    }
    
    return rootArray;
  }
  
  void findLocalExtrema() {
    // Create filler polynomial object to use rewrite polynomial function
    Polynomial filler = new Polynomial(this.variable);
    
    ArrayList<Integer> derivExp = new ArrayList<Integer>();
    ArrayList<Integer> derivCoe = new ArrayList<Integer>();
    
    // Takes exponent and coefficient arrays from main polynomial and transfers to arraylist
    for (int i = 0; i < this.exponents.length; i++) {
      derivExp.add(this.exponents[i]);
      derivCoe.add(this.coefficients[i]);
    }
    
    // Use chain rule to differentiate function
    for (int i = 0; i < derivExp.size(); i++) {
      if (derivExp.get(i) == 0) {
        derivExp.remove(i);
        derivCoe.remove(i);
        i--;
      }
      else {
        derivCoe.set(i, derivCoe.get(i) * derivExp.get(i));
        derivExp.set(i, derivExp.get(i) - 1);
      }
    }
    
    int[] fillerExp;
    int[] fillerCoe;
    // If derivative has only a constant of 0
    if (derivExp.size() == 0) {
      fillerExp = new int[1];
      fillerCoe = new int[1];
      fillerExp[0] = 0;
      fillerCoe[0] = 0;
    }
    // Convert arraylist back to array
    else {
      fillerExp = new int[derivExp.size()];
      fillerCoe = new int[derivCoe.size()];
      for (int i = 0; i < derivExp.size(); i++) {
        fillerExp[i] = derivExp.get(i);
        fillerCoe[i] = derivCoe.get(i);
      }
    }
    
    // Redefine components to rewrite polynomial to create polynomial object of derivative
    filler.exponents = fillerExp;
    filler.coefficients = fillerCoe;
    filler.degree = fillerExp[0];
    filler.rewritePolynomial();
    
    // Create polynomial object for the derivative
    Polynomial deriv = new Polynomial(filler.polynomial);
    
    // Create separate arrays and arraylists for extrema
    String[] minima;
    String[] maxima;
    ArrayList<String> minList = new ArrayList<String>();
    ArrayList<String> maxList = new ArrayList<String>();
    
    // If the derivative has no roots, there is no turning point for the main polynomial
    if (deriv.roots[0] == "No rational roots") {
      minima = new String[1];
      maxima = new String[1];
      minima[0] = "No rational local minima";
      maxima[0] = "No rational local maxima";
      this.minima = minima;
      this.maxima = maxima;
    }
    // Find if the main polynomial has turning points
    else {
      ArrayList<Integer> critNum = new ArrayList<Integer>();
      ArrayList<Integer> critDen = new ArrayList<Integer>();
      
      // Break roots of derivative into fractions
      for (int i = 0; i < deriv.roots.length; i++) {
        int indexSlash = deriv.roots[i].indexOf("/");
        if (indexSlash == -1) {
          critNum.add(int(deriv.roots[i]));
          critDen.add(1);
        }
        else {
          critNum.add(int(deriv.roots[i].substring(0, indexSlash)));
          critDen.add(int(deriv.roots[i].substring(indexSlash + 1)));
        }
      }

      // Find critical numbers
      float critLeft, critRight;
      for (int i = 0; i < critNum.size(); i++) {
        float x = critNum.get(i) / float(critDen.get(i));
        // Evaluate function at critical numbers
        critLeft = deriv.evaluateAtX(x - 0.01);
        critRight = deriv.evaluateAtX(x + 0.01);
        
        // If slope of left side of critical number is negative while the right side is positive, there is a local minimum
        if (critLeft < 0 && critRight > 0) {
          if (critDen.get(i) == 1) {
            minList.add(str(critNum.get(i)));
          }
          else {
            minList.add(str(critNum.get(i)) + "/" + str(critDen.get(i)));
          }
        }
        // If slope of right side of critical number is negative while the left side is positive, there is a local maximum
        else if (critLeft > 0 && critRight < 0) {
          if (critDen.get(i) == 1) {
            maxList.add(str(critNum.get(i)));
          }
          else {
            maxList.add(str(critNum.get(i)) + "/" + str(critDen.get(i)));
          }
        }
      }
      // If no slope change from negative to positive in the main polynomial is located
      if (minList.size() == 0) {
        minima = new String[1];
        minima[0] = "No rational local minima";
        this.minima = minima;
      }
      // Convert arraylist of minima to array and return array
      else {
        minima = new String[minList.size()];
        for (int i = 0; i < minList.size(); i++) {
          minima[i] = minList.get(i);
        }
        this.minima = minima;
      }
      
      // If no slope change from positive to negative in the main polynomial is located
      if (maxList.size() == 0) {
        maxima = new String[1];
        maxima[0] = "No rational local maxima";
        this.maxima = maxima;
      }
      // Convert arraylist of maxima to array and return array
      else {
        maxima = new String[maxList.size()];
        for (int i = 0; i < maxList.size(); i++) {
          maxima[i] = maxList.get(i);
        }
        this.maxima = maxima;
      }
    }
  }
  
  String subtractPolynomial(Polynomial b) {
    // Create filler polynomial to use functions within the class
    Polynomial difference = new Polynomial(this.variable);
    
    ArrayList<Integer> joinedExponents = new ArrayList<Integer>(); // preparing for answer arrays
    ArrayList<Integer> joinedCoefficients = new ArrayList<Integer>();
    
    for (int i = 0; i < this.exponents.length; i++){ // adding exponents in polynomial a and exponents in polynomial b together in one array
      joinedExponents.add(this.exponents[i]);
      joinedCoefficients.add(this.coefficients[i]);
    }
    for (int j = 0; j < b.exponents.length; j++){ // adding coefficients in polynomial a and coefficients in polynomial b together in one array
      joinedExponents.add(b.exponents[j]);
      joinedCoefficients.add(b.coefficients[j] * -1); // multiply by -1 as an operation of subtraction, then add each coefficient to complete the operation properly
    }

    for (int n = 0; n < joinedExponents.size(); n++){
      int searchDigit = joinedExponents.get(n);
      for (int m = 0; m < joinedExponents.size(); m++){
        if ((searchDigit == joinedExponents.get(m)) && (n != m)){ // Checks for like terms excluding itself
          joinedCoefficients.set(m, joinedCoefficients.get(n) + joinedCoefficients.get(m)); // Adds the earliest coefficient to the later one so that the order of the exponents is still the same
          joinedCoefficients.remove(n);// Removes the exponent and number so that it doesnt get recalculated
          joinedExponents.remove(n);
          n--; // Since the n is removed a new value is in place for that n value in the array and so this is to ensure that no exponent is missed
          break;
        }
      }
    }
    int[] arrangedSubtractedExp = new int[joinedExponents.size()];
    int[] arrangedSubtractedCoe = new int[joinedCoefficients.size()];
    for (int k = 0; k < joinedExponents.size(); k++){ // Turning ArrayList into Array
      arrangedSubtractedExp[k] = joinedExponents.get(k);
      arrangedSubtractedCoe[k] = joinedCoefficients.get(k);
    }
    
    // Use polynomial class functions with the filler to produce an organized version of the polynomial
    difference.exponents = arrangedSubtractedExp;
    difference.coefficients = arrangedSubtractedCoe;
    difference.rearrange();
    difference.rewritePolynomial();
    
    // Return the filler's polynomial
    return difference.polynomial;
  }
  
  
  String addPolynomial(Polynomial b) { // Basically same operations as subtracting but has the polynomials adding instead
    Polynomial sum = new Polynomial(this.variable);
  
    ArrayList<Integer> joinedCoefficients = new ArrayList<Integer>();
    ArrayList<Integer> joinedExponents = new ArrayList<Integer>();
    
    for (int i = 0; i < this.exponents.length; i++){ 
      joinedExponents.add(this.exponents[i]);
      joinedCoefficients.add(this.coefficients[i]);
    }
    for (int j = 0; j < b.exponents.length; j++){
      joinedExponents.add(b.exponents[j]);
      joinedCoefficients.add(b.coefficients[j]);
    }
    
    for (int n = 0; n < joinedExponents.size(); n++){
      int searchDigit = joinedExponents.get(n);
      for (int m = 0; m < joinedExponents.size(); m++){
        if ((searchDigit == joinedExponents.get(m)) && (n != m)){
          joinedCoefficients.set(m, joinedCoefficients.get(n) + joinedCoefficients.get(m));
          joinedCoefficients.remove(n);
          joinedExponents.remove(n);
          n--;
          break;
        }
      }
    }
    
    int[] arrangedAddedExp = new int[joinedExponents.size()];
    int[] arrangedAddedCoe = new int[joinedCoefficients.size()];
    for (int k = 0; k < joinedExponents.size(); k++){
      arrangedAddedExp[k] = joinedExponents.get(k);
      arrangedAddedCoe[k] = joinedCoefficients.get(k);    
    }
    
    sum.exponents = arrangedAddedExp;
    sum.coefficients = arrangedAddedCoe;
    sum.rearrange();
    sum.rewritePolynomial();
    
    return sum.polynomial;
  }
  
  String multiplyPolynomial(Polynomial b) {
    // Create filler polynomial to use the functions of the class
    Polynomial product = new Polynomial(this.variable);
    
    ArrayList<Integer> multipliedExponents = new ArrayList<Integer>();
    ArrayList<Integer> multipliedCoefficients = new ArrayList<Integer>();
    
    for (int i = 0; i < this.exponents.length; i++){
      for (int j = 0; j < b.exponents.length; j++){
        multipliedExponents.add( this.exponents[i] + b.exponents[j]); // Multiplies all coefficients and adds exponents together
        multipliedCoefficients.add( this.coefficients[i] * b.coefficients[j]);
      }
    }    
    for (int n = 0; n < multipliedExponents.size(); n++){
      int searchDigit = multipliedExponents.get(n);// Searches for like terms by selecting one number and comparing it with each other exponent in the array
      
      for (int m = 0; m < multipliedExponents.size(); m++){
        if ((searchDigit == multipliedExponents.get(m)) && (n != m)){
          multipliedCoefficients.set(m, multipliedCoefficients.get(n) + multipliedCoefficients.get(m)); //adds the coefficients of like terms
          multipliedCoefficients.remove(n); // Removes the coefficients and exponents of the previous pair of like terms to prevent it from duplicating
          multipliedExponents.remove(n);
          n--;
          break;
        }
      }
    }
    
    // Copies values of arraylist to new arrays
    int[] productExp = new int[multipliedExponents.size()];
    int[] productCoe = new int[multipliedCoefficients.size()];
    for (int i = 0; i < multipliedExponents.size(); i++) {
      productExp[i] = multipliedExponents.get(i);
      productCoe[i] = multipliedCoefficients.get(i);
    }
    
    // Use polynomial class functions with the filler to produce an organized version of the polynomial
    product.exponents = productExp;
    product.coefficients = productCoe;
    product.rearrange();
    product.rewritePolynomial();
    
    // Returns the filler's polynomial
    return product.polynomial;
  }
  
  String[] dividePolynomial(Polynomial b) {
    String[] finals = new String[2];
    
    // Create filler polynomials for the quotient and remainder to use polynomial functions
    Polynomial quoFiller = new Polynomial(this.variable);
    Polynomial remFiller = new Polynomial(this.variable);
    
    // Check to make sure polynomial isn't being divided by a coefficient of 0, as division by 0 is undefined
    if (b.leadingCoefficient == 0) {
      finals[0] = "Division error: division by 0";
      finals[1] = "Error";
      
      return finals;
    }
    
    // Move array of exponents and coefficients to respective arraylists
    ArrayList<Integer> thisExp = new ArrayList<Integer>();
    ArrayList<Integer> thisCoe = new ArrayList<Integer>();
    ArrayList<Integer> bExp = new ArrayList<Integer>();
    ArrayList<Integer> bCoe = new ArrayList<Integer>();
    
    // Also create arraylist to store quotient exponents and coefficients
    ArrayList<Integer> quoExp = new ArrayList<Integer>();
    ArrayList<Integer> quoCoe = new ArrayList<Integer>();
    
    // Move values from array to arraylist, but also fill in the gaps between exponents with exponents that have a coefficient of 0
    int thisExpGap = 0;
    for (int i = 0; i < this.exponents.length; i++) {
      if (i != 0 && this.exponents[i] != this.exponents[i - 1] - 1) {
        thisExpGap = this.exponents[i - 1] - this.exponents[i]; // Find gap between previous exponent and current exponent
        for (int j = 1; j < thisExpGap; j++) { // Fill in the gap with exponents that have a coefficient of 0
          thisExp.add(this.exponents[i - 1] - j);
          thisCoe.add(0);
        }
        // Add the current exponent and current coefficient
        thisExp.add(this.exponents[i]);
        thisCoe.add(this.coefficients[i]);
      }
      // Fill in the remaining coefficients and exponents with 0s if the last exponent is not 0
      else if (i == this.exponents.length - 1 && this.exponents[i] != 0) {
        thisExpGap = this.exponents[i];
        thisExp.add(this.exponents[i]);
        thisCoe.add(this.coefficients[i]);
        for (int j = 1; j <= thisExpGap; j++) {
          thisExp.add(this.exponents[i] - j);
          thisCoe.add(0);
        }
      }
      // Add the current exponent and current coefficient
      else {
        thisExp.add(this.exponents[i]);
        thisCoe.add(this.coefficients[i]);
      }
    }
    
    // Repeat the same process but with the other polynomial
    for (int i = 0; i < b.exponents.length; i++) {
      if (i != 0 && b.exponents[i] != b.exponents[i - 1] - 1) {
        thisExpGap = b.exponents[i - 1] - b.exponents[i];
        for (int j = 1; j < thisExpGap; j++) {
          bExp.add(b.exponents[i - 1] - j);
          bCoe.add(0);
        }
        bExp.add(b.exponents[i]);
        bCoe.add(b.coefficients[i]);
      }
      else if (i == b.exponents.length - 1 && b.exponents[i] != 0) {
        thisExpGap = b.exponents[i];
        bExp.add(b.exponents[i]);
        bCoe.add(b.coefficients[i]);
        for (int j = 1; j <= thisExpGap; j++) {
          bExp.add(b.exponents[i] - j);
          bCoe.add(0);
        }
      }
      else {
        bExp.add(b.exponents[i]);
        bCoe.add(b.coefficients[i]);
      }
    }
    
    // While-loop that represents polynomial long division
    boolean divisible = true;
    while (divisible) {
      // If the coefficient of the divisor is not a factor and does not eliminate the exponent
      if (thisCoe.get(0) % bCoe.get(0) != 0) {
        divisible = false;
      }
      
      // If the degrees are equal, it is the last loop
      if (thisExp.get(0) - bExp.get(0) == 0) {
        divisible = false;
      }
      // If the divisor's degree is less, stop the loop
      else if (thisExp.get(0) - bExp.get(0) < 0) {
        divisible = false;
        break;
      }
      
      // Find what the divisor needs to be multiplied by to eliminate leading term
      int quotientCoe = int(thisCoe.get(0) / float(bCoe.get(0)));
      int quotientExp = int(thisExp.get(0) - bExp.get(0));
    
      // Add exponent and coefficient to quotient arraylists
      quoExp.add(quotientExp);
      quoCoe.add(quotientCoe);
      
      // Multiply divisor by quotient exponent and coefficient and subtract from dividend
      for (int i = 0; i < bExp.size(); i++) {
        thisCoe.set(i, thisCoe.get(i) - bCoe.get(i) * quotientCoe);
      }
      
      // Remove any extra leading terms that have a coefficient of 0
      while (thisCoe.get(0) == 0) {
        thisCoe.remove(0);
        thisExp.remove(0);
        
        // If the arraylists are out of terms, make sure the loop doesn't run again
        if (thisCoe.size() == 0) {
          divisible = false;
          break;
        }
      }
    }
    
    // Move arraylists to arrays
    int[] quoExponents = new int[quoExp.size()];
    int[] quoCoefficients = new int[quoCoe.size()];
    int[] remExponents = new int[thisExp.size()];
    int[] remCoefficients = new int[thisCoe.size()];
    
    for (int i = 0; i < quoExp.size(); i++) {
      quoExponents[i] = quoExp.get(i);
      quoCoefficients[i] = quoCoe.get(i);
    }
    
    // Remainder is just remaining values from the dividend
    for (int i = 0; i < thisExp.size(); i++) {
      remExponents[i] = thisExp.get(i);
      remCoefficients[i] = thisCoe.get(i);
    }
    
    // Fill filler fields for quotient and remainder to use rewritePolynomial() function
    quoFiller.exponents = quoExponents;
    quoFiller.coefficients = quoCoefficients;
    remFiller.exponents = remExponents;
    remFiller.coefficients = remCoefficients;
    quoFiller.rearrange();
    remFiller.rearrange();
    quoFiller.rewritePolynomial();
    remFiller.rewritePolynomial();
    
    // Take polynomial of quotient filler, which is the quotient, and polynomial of remainder filler, which is the remainder
    finals[0] = quoFiller.polynomial;
    finals[1] = remFiller.polynomial;
    
    // Return quotient and remainder
    return finals;
  }
  
  float evaluateAtX(float x) {
    float sum = 0;
    
    // Evaluate the function at the given x value
    for (int i = 0; i < this.exponents.length; i++) {
      sum += this.coefficients[i] * pow(x, this.exponents[i]);
    }
    
    // Return float
    return sum;
  }
  
  void createDisplayVariables(){
    if (this.roots[0] == "No rational roots") // If roots are not rational it will print this in display
      this.rootDisplay = "No rational roots";
    else{
      String connectedRoots = join(this.roots, ","); // If there are rational roots it will print this
      String shownRoots = "x = "+connectedRoots;
      this.rootDisplay = shownRoots;
      }
    
    if (this.minima[0] == "No rational local minima"){ // Similar to rootsDisplay but with local minima
      this.minimaDisplay = "No rational local minima"; 
    }
      else{
      String connectedMinima = join(this.minima, ",");
      String shownMinima = "x = "+connectedMinima;
      this.minimaDisplay = shownMinima;
    }
    
    if (this.maxima[0] == "No rational local maxima"){ // Similar to rootsDisplay but with local maxima
      this.maximaDisplay = "No rational local maxima";
    }
    else{
      String connectedMaxima = join(this.maxima, ",");
      String shownMaxima = "x = "+connectedMaxima;
      this.maximaDisplay = shownMaxima;
    }
  }
  
  static int getGCD(int a, int b) { // Get greatest common divisor function
    int max, min, rem;
    
    // Distinguishes which of the two values is smaller and which is larger
    max = Math.max(a, b);
    min = Math.min(a, b);
    
    // Use modulo to find remainder of the higher value divided by the smaller value
    rem = max % min;
    
    // Use Euclid's algorithm to find the greatest common divisor
    while (rem > 0) {
        max = min;
        min = rem;
        rem = max % min;
    }
    
    // Return the greatest common divisor
    return min;
  }
}
