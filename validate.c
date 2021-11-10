/* 
Ellie Dove (edove1@umbc.edu)
CMSC 313 PROJ4 
validate.c
C file used to validate user input
*/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

int ARR_LENGTH = 10;
int CAPITAL_A = 65;
int CAPITAL_Z = 90;
char PERIOD = '.';
char QUESTION = '?';
char EXCLAMATION = '!';

// Displays current messages (NOT ENCRYPTED)
void display(char** array){
    for (int i = 0; i < ARR_LENGTH; i++){
        printf("Message[%d]: %s\n", i, array[i]);
    }
    printf("\n");
}

// Reads in user's input string from keyboard
int readMessage(char** array, int index){
    // Returns 1 if valid string
    // Returns 0 otherwise
    int buffer = 256;
    int position = 0;

    // Allocate string for buffer size
    char* str = malloc(sizeof(char) * buffer);

    int currCha;
    int cont = 1;
    int invalid = 0;

    printf("Enter your message-> ");
    while (cont == 1){
        // Get char from stdin
        currCha = fgetc(stdin);
        
        // See if we're at the end of the string
        if (currCha == EOF || currCha == '\n'){
            // Finish the off the string, end loop
            str[position] = '\0';
            cont = 0;
        }
        // Check that position 1 is capital
        else if (position == 0 && ((int)currCha < CAPITAL_A || (int)currCha > CAPITAL_Z)){
            printf("Invalid Message\n\n");
            invalid = 1;
        }
        else{
            // Add the current char to the char array (str)
            str[position] = currCha;
        }

        position++;

        // Increase buffer size if we've maxed out
        if (position >= buffer){
            currCha = fgetc(stdin);
            buffer += 256;
            str = realloc(str, buffer);
        }
    }
    
    // End of string index
    int end = position-2;

    // Final check to determine return
    if (invalid == 0){
        // Check punctuation
        if(str[end] != PERIOD && str[end] != QUESTION && str[end] != EXCLAMATION){
            printf("Invalid Message\n\n");
            invalid = 1;
            return 0;
        }
        // Set the current index to str
        index = index % ARR_LENGTH;
        array[index] = str;
        return 1;
    }
    else{
        return 0;
    }
}

// Calculates square root for jump cipher
int squareRoot(char* message, int* length){
    int len = strlen(message);
    *length = len;
    return sqrt(len);
}

void easterEgg(){
    /*
    It doesn't always work :( Sometimes print formatting breaks it
    This is a spotify song code converted to ASCII
    
    To use: Open spotify, select search, click camera icon and scan code in terminal
    If too zoomed in - ctrl+scroll down to zoom out (hopefully it works on your terminal)

    Song: Men At Work - Land Down Under
    Link: https://open.spotify.com/track/3ZZq9396zv8pcn5GYVhxUi?si=59ae497297024b68
    */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    printf("                                                                                                                                                                                                                                                                                                       .\n\
                                                                                                                                                                                                                                                                                                           .\n\
                                                                                                                                                                                                                                                                                                           .\n\
                                                                                                                                                                                                                                                                                                           .\n\
                                                                                                                                                                                                                                                                                                           .\n\
                                                                                                                                                                                                                                                                                                           .\n\
                                                                                                                                                                                                                                                                                                           .\n\
                            .';cldxxkkxxdlc;..                                                                          .:xkd;    ,dkxc.   .okko.                                .lxkd'    :xkx;                                ,dkxc.   .oxkl.                                                            .\n\
                        .,lx0NWMMMMMMMMMMMMWX0xc'                                                                       ,0MMMk.  .kMMMK,   lWMMNl                                :XMMWd   '0MMMO.                              .kMMMK,   lWMMNc                                                            .\n\
                      'lONMMMMMMMMMMMMMMMMMMMMMMNOl.                                                                    ,KMMMk.  .kMMMK,   lWMMWl                                :NMMMd.  '0MMMO.                              .kMMMK,   oWMMNl    ..'.                                                    .\n\
                    ,xXWMMMMMMMMMMMMMMMMMMMMMMMMMMWKo'                                                                  ,KMMMk.  .kMMMK,   lWMMWl                                :NMMMd.  '0MMMO.                              .kMMMK,   oWMMNl   .kXNKc                                                   .\n\
                  .oXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKl.                                                                ,KMMMk.  .kMMMK,   lWMMWl                                :NMMWd.  '0MMMO.                              .kMMMK,   oWMMNl   ;XMMMx.                                                  .\n\
                 ,OWMMMMMMMMWWWWNNWWWWWMMMMMMMMMMMMMMMWk'                                                      .;ll:.   ,KMMMk.  .kMMMK,   lWMMNl              'clc'    .:ll;.   :NMMMd.  '0MMMO.            .;ll:.    ,clc.   .kMMMK,   oWMMNl   ;XMMMx.                                                  .\n\
                ;0MMMWKkdolc:;,,'''',,;:cloxOKNWMMMMMMMWO'                                                     :NMMNl   ,KMMMk.  .kMMMK,   lWMMWl    ..',.    .kMMMO'   oWMMX:   :NMMMd.  '0MMMO.            :XMMNl   '0MMWx.  .kMMMK,   oWMMNl   ;XMMMx.                      .',.                        .\n\
               '0MMMWx.                      ..;cd0NWMMMMk.                                                    cNMMWo   ,KMMMk.  .kMMMK,   lWMMWl   'kNNWXl   .OMMM0'   dWMMNc   :NMMMd.  '0MMMO.            cNMMWo   ,KMMMk.  .kMMMK,   oWMMNl   ;XMMMx.                     ,ONNKc                       .\n\
              .dWMMMWO;'';clodxxxxxxxddol:;'.      'lKMMMWo                        .dO0k,   .cO0Oc.   ;k0Oo.   cNMMWo   ,KMMMk.  .kMMMK,   lWMMWl   ;XMMMMx.  .OMMM0'   dWMMNc   :NMMMd.  '0MMMO.   ;k0Oo.   cNMMWo   ,KMMMk.  .kMMMK,   oWMMNl   ;XMMMx.            ,x0Od.   :NMMWd.                      .\n\
              ,KMMMMMMWNNWMWNNXXXXXXNNWWMMWNXOxl;.  .kMMMM0'              .coo:.   :XMMWd.  '0MMMO.  .xMMMX;   cNMMWo   ,KMMMk.  .kMMMK,   lWMMWl   ;XMMMMx.  .OMMM0'   dWMMNc   :NMMMd.  '0MMMO.  .xMMMX;   cNMMWo   ,KMMMk.  .kMMMK,   oWMMNl   ;XMMMx.   'lol,    dWMMN:   :NMMWd.   ,lol'              .\n\
              cNMMMMMMW0dl:;'........',;coxOKNWMWKkk0WMMMMX;              oWMMX:   :NMMWd.  '0MMMO.  .xMMMX;   cNMMWo   ,KMMMk.  .kMMMK,   lWMMWl   ;XMMMMx.  .OMMM0'   dWMMNc   :NMMMd.  '0MMMO.  .xMMMX;   cNMMWo   ,KMMMk.  .kMMMK,   oWMMNl   ;XMMMx.  .kMMMO'   dWMMNc   :NMMWd.  .OMMMO.             .\n\
              lWMMMMMMK;   ..'',,,,''...    .':d0NMMMMMMMMN:              dWMMNc   :XMMWd.  '0MMMO.  .xMMMX;   cNMMWo   ,KMMMk.  .kMMMK,   lWMMWl   ;XMMMMx.  .OMMM0'   dWMMNc   :NMMMd.  '0MMMO.  .xMMMX;   cNMMWo   ,KMMMk.  .kMMMK,   oWMMNl   ;XMMMx.  .OMMM0'   dWMMNc   :NMMWd.  '0MMMO.             .\n\
              cNMMMMMMW0xxOKXNNWWWWWNXK0kdl:'.  .:KMMMMMMMX;              oWMMX:   :XMMWd.  '0MMMO.  .xMMMX;   cNMMWo   ,KMMMk.  .kMMMK,   lWMMWl   ;XMMMMx.  .OMMM0'   dWMMNc   :NMMMd.  '0MMMO.  .xMMMX;   cNMMWo   ,KMMMk.  .kMMMK,   oWMMNl   ;XMMMx.  .kMMMO.   dWMMNc   :NMMWd.  .OMMMk.             .\n\
              ,KMMMMMMMMWNXK0OkxxxxxkO0XNWMWN0dc;oXMMMMMMMO'              .:ll;.   :XMMWd.  '0MMMO.  .xMMMX;   cNMMWo   ,KMMMk.  .kMMMK,   lWMMWl   ;XMMMMx.  .OMMM0'   dWMMNc   :NMMMd.  '0MMMO.  .xMMMX;   cNMMWo   ,KMMMk.  .kMMMK,   oWMMNl   ;XMMMx.   'cll'    dWMMN:   :NMMWd.   'loc'              .\n\
              .dWMMMMMMXl'..............';cdONWMWMMMMMMMMNl                        .okOx,   .ckOk:    ,xOkl.   cNMMWo   ,KMMMk.  .kMMMK,   lWMMWl   ;XMMMMx.  .OMMM0'   dWMMNc   :NMMMd.  '0MMMO.   ,xOkl.   cNMMWo   ,KMMMk.  .kMMMK,   oWMMNl   ;XMMMx.            ,dOOo.   :NMMWd.                      .\n\
               'OMMMMMMXdcldxkOO000Okxdlc,. .'lKMMMMMMMMWk.                                                    cNMMWo   ,KMMMk.  .kMMMK,   lWMMWl   .kXNNKl   .OMMM0'   dWMMNc   :NMMMd.  '0MMMO.            cNMMWo   ,KMMMk.  .kMMMK,   oWMMNl   ;XMMMx.                     'ONNKc                       .\n\
                ,0MMMMMMMMMMMMMMMMMMMMMMMWXko:c0MMMMMMMWO'                                                     :XMMNl   ,KMMMk.  .kMMMK,   lWMMWl    ...'.    .kWMMO.   lWMMX;   :NMMMd.  '0MMMO.            :XMMNl   '0MMWx.  .kMMMK,   oWMMNl   ;XMMMx.                      ..'.                        .\n\
                 'OWMMMMMMMMMMMMMMMMMMMMMMMMMWWMMMMMMMWx.                                                      .,cc;.   ,KMMMk.  .kMMMK,   lWMMWl              .:lc'    .;cc,    :NMMMd.  '0MMMO.            .,cl;.    'cl:.   .kMMMK,   oWMMNl   ;XMMMx.                                                  .\n\
                  .lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKc.                                                                ,KMMMk.  .kMMMK,   lWMMWl                                :NMMMd.  '0MMMO.                              .kMMMK,   oWMMNl   ;XMMMx.                                                  .\n\
                    'dKWMMMMMMMMMMMMMMMMMMMMMMMMMMWKo.                                                                  ,KMMMk.  .kMMMK,   lWMMWl                                :NMMMd.  '0MMMO.                              .kMMMK,   oWMMNl   .xXX0c                                                   .\n\
                      .cOXWMMMMMMMMMMMMMMMMMMMMWXkc.                                                                    ,KMMMk.  .kMMMK,   lWMMWl                                :NMMMd.  '0MMMO.                              .kMMMK,   oWMMNl     ...                                                    .\n\
                         'cd0XWMMMMMMMMMMMMNXOd:.                                                                       '0MMMk.  .kMMMK,   lWMMNc                                :XMMWd   'OMMMO.                              .xMMMK,   lWMMNc                                                            .\n\
                             .,:loddxxddol:,.                                                                           .:dxo,    ,oxd:.   .lxxl.                                .cdxo'    ;dxd;                                ,oxd:.   .lxxl.                                                            .\n\
                                                                                                                                                                                                                                                                                                           .\n\
                                                                                                                                                                                                                                                                                                        ");
                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                            
}




