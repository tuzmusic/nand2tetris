// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/05/Memory.tst

load Memory.hdl,
output-file Memory.out,
compare-to Memory.cmp,
output-list in%D1.6.1 load%B2.1.2 address%B1.15.1 out%D1.6.1;

echo "Before you run this script, select the 'Screen' option from the 'View' menu";

set in -1,				// Set RAM[0] = -1. Doesn't output YET
set load 1,       // SCREEN also interprets this as [0] = -1
set address 0,    // -> Set SCR[0] = -1
tick,
output;
tock,
output;

set in 9999,			// RAM[0] outputs its value, written in previous step
set load 0,       // RAM[0] = -1, SCR[0] = -1
tick,             // OUT = R && S = -1 && -1 = 1..11 && 1..11 = 1..11 = -1
output;
tock,
output;

set address %X2000,		// Did not also write to upper RAM or Screen
eval,                 // RAM[0x2000] is up in the high RAM. Should be 0.
output;               // 0x2000 >> 2 == 0x800; SCR[0x800] == 0
set address %X4000,   // OUT = 0 && 0 = 0
eval,
output;

set in 2222,  			// Set RAM[0x2000] = 2222 
set load 1,         // Set SCR[0x800] = 2222
set address %X2000, // output is still t-1 = 0 && 0 = 0
tick,
output;
tock,
output;

set in 9999,			// write RAM[0x2000] = 9999. also output its t-1
set load 0,       //       SCR[0x0800] = 9999
tick,             // output t-1 which, for this address, is 2222
output;           // 2222 && 2222 = 2222 (x && x = x)
tock,
output;

set address 0,			// Did not also write to lower RAM or Screen
eval,               // load from RAM[0], SCR[0] = -1
output;             // out = -1 && -1 = -1

set address %X4000, // 0x4000 = 10..00(15)
eval,               // load RAM[0], SCR[0x1000] = 0 && 0 = 0
output;

set load 0,				// Low order address bits connected
set address %X0001, eval, output;     // read from a bunch of bits that 
set address %X0002, eval, output;     // haven't been written to (0)
set address %X0004, eval, output;
set address %X0008, eval, output;
set address %X0010, eval, output;
set address %X0020, eval, output;
set address %X0040, eval, output;
set address %X0080, eval, output;
set address %X0100, eval, output;
set address %X0200, eval, output;
set address %X0400, eval, output;
set address %X0800, eval, output;
set address %X1000, eval, output;
set address %X2000, eval, output;     // we did write 2222 here though!

set address %X1234,		// RAM[0x1234] = 1234
set in 1234,          // SCR[0x48D]  = 1234
set load 1,           // output = t-1 though, which = 0
tick,
output;               
tock,                 // without changing anything, we write it again
output;               // and since this is the t+1 from before, we read
                      // the new value

set load 0,           // Did not also write to upper RAM or Screen 
set address %X2234,		// change to a clean address. out=0
eval, output;
set address %X6234,   // change to another clean address. out=0
eval, output;         // THIS IS A KEYBOARD ADDRESS!!!!!!

set address %X2345,		// RAM[0x2345] = 2345
set in 2345,          // write to a new address. note that by this point
set load 1,           // i've realized that I don't care where on the screen
tick,                 // we're writing too. (RIGHT????)
output;           
tock,                 // next time around, we output what we just wrote
output;

set load 0,           // some new clean addresses
set address %X0345,		// Did not also write to lower RAM or Screen 
eval, output;
set address %X4345,
eval, output;

// Keyboard test

set address 24576,    // 0x6000 = keyboard address!
echo "Click the Keyboard icon and hold down the 'K' key (uppercase) until you see the next message (it should appear shortly after that) ...",
// It's important to keep holding the key down since if the system is busy,
// the memory will zero itself before being outputted.

while out <> 75 {   // KBD **must** output somehow
    eval,
}

clear-echo,
output;

// Screen test

set load 1,
set in -1,
set address %X4FCF,  // sets this address to -1. this is a line on the screen.
tick,                
tock,                
output,              
                     

set address %X504F,  // input and load have not changed, 
tick,                // so this sets *this* address to -1,   
tock,                // creating another line on the screen
output;              // this is line 37 & 38 of the output

set address %X0FCF,		// Did not also write to lower or upper RAM
eval,                 
output;
set address %X2FCF,
eval,
output;

set load 0,				// Low order address bits connected
set address %X4FCE, eval, output;
set address %X4FCD, eval, output;
set address %X4FCB, eval, output;
set address %X4FC7, eval, output;
set address %X4FDF, eval, output;
set address %X4FEF, eval, output;
set address %X4F8F, eval, output;
set address %X4F4F, eval, output;
set address %X4ECF, eval, output;
set address %X4DCF, eval, output;
set address %X4BCF, eval, output;
set address %X47CF, eval, output;
set address %X5FCF, eval, output;


set load 0,
set address 24576,
echo "Make sure you see ONLY two horizontal lines in the middle of the screen. Hold down 'Y' (uppercase) until you see the next message ...",
// It's important to keep holding the key down since if the system is busy,
// the memory will zero itself before being outputted.

while out <> 89 {
    eval,
}

clear-echo,
output;
