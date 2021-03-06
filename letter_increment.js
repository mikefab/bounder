
//create a string containing all letters
var alphaChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

//initialize a test character to 'A'

//this function accepts a character, increments it
//by one, and returns it
function incrementLetter(letterToIncrement){

 //find where the letter is at in the alphaChars string
 var indexOfLetter = alphaChars.search(letterToIncrement);

 //if it's not the last letter, then return the next
 //letter in the string
 if (indexOfLetter+1 < alphaChars.length) {
   return(alphaChars.charAt(indexOfLetter+1));
 }

 //otherwise return the input letter
 else{
   return(letterToIncrement);
 }
}


//called when the button is clicked
//sets our test character to the next character
//using the incrementLetter function and then
//alerts it
function tester(value){
 myChar = incrementLetter(value);
 return(myChar);
}
