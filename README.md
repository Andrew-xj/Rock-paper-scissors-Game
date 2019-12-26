Rock-paper-scissors Game
======================================

## Introductions:

Rock-paper-scissors is a project based on verilog language development. It is a experiment project for my required course, Comprehensive experiment of digital circuit. 

Most of these modules are well tested and shouldn't have issues. However, I'm generally allowing myself to upload things which may have issues.

## Modules:

`Game520.v`: The top module of the project.

`debounce.v`: This module is used for eliminating the jitter of all the buttons.

`clk.v`: This module provides different frequencies for the entire project.

`round.v`: This module controls the show of dot array. There are 4 modes in the whole game: beginning animation, the result of each turn, all leds off and ending animation. 

`segment.v`: This module displays two players' scores in two digital tubes.

`lcd_1602_driver`: This module displays two players' scores on the LCD.

`beep.v`: This module provides the background music for the game.

`score.v`: This module is used to update two players' score and judge whether the game is ended.
