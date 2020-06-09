#  BullsEye

This project folder contrains two games

### Bulls Eye
here the user approximates the slider position to a randomaly generated target value.  Depending how close
the user is to the target, they will score points.  

### RGB Bulls Eye
similar to the regular Bulls Eye, but now the user must approximate 3 slider positions in order to match a randomly
generated color.

## MVC
The goal of this assignment was to refactor the code of an allready completed BullsEye game to implement the MVC 
design architecture and then use that model to create the RGB version of the game.  I was given the choice to use a Struct or Class for the model, I 
went with a Struct.  This is because according to Apples documentation states to use structures by default when deciding how to store data or model behavior.  
Unless I need to controll Identity or use Objective-C interoperabilty,  defaulting to structures and dealing with Value types is more efficient and prefered. 


