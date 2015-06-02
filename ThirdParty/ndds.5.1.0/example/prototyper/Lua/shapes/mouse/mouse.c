/******************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--****************************************************************************/

/* mouse.c
 * gcc -Wall -shared -fPIC -o mouse.so -I/usr/include/lua5.2 -llua5.2 mouse.c
 * Note the word "mouse" matches the string after the underscore in
 * function luaopen_mouse(). This is a must.
*/

#include <lua.h>  
#include <lauxlib.h> 
#include <lualib.h>
#include <stdio.h>
#include <stdlib.h>                            
#include <unistd.h>

#include <linux/input.h>
#include <fcntl.h>
        
#define MOUSEFILE "/dev/input/event0"

int globalClickUp = 1;

static int mouse(lua_State *L) {
    int fd;
    struct input_event ie;
    const char *fileName = NULL;
    char *event = NULL;

    fileName = lua_tostring(L,-1);
    if (fileName == NULL) {
        fileName = MOUSEFILE;
    } 
    if((fd = open(fileName, O_RDONLY)) == -1) {
        perror("opening device");
        exit(EXIT_FAILURE);
    }
    ie.type = -1;
    
    while(read(fd, &ie, sizeof(struct input_event))) {
        /*
        printf("time %ld.%06ld\ttype %d\tcode %d\tvalue %d\n",
               ie.time.tv_sec, ie.time.tv_usec, ie.type, ie.code, ie.value);
        */
        break;
    }
    close(fd);
    switch(ie.type) {
        default:
            event = "NO_EVENT";
            printf("NO EVENT: %d\n", ie.type);
            break;
        case 4:
            if (globalClickUp == 1) {
                globalClickUp = 0;
            } else {
                globalClickUp = 1;
                if (ie.value == 589825) {
                    event = "LEFT_CLICK";
                } else {
                    event = "RIGHT_CLICK";
                }
            }
            break;
        case 2:
            switch(ie.code) {
                case 8:
                    if (ie.value > 0) {
                        event = "WHEEL_UP";
                    } else {
                        event = "WHEEL_DOWN";
                    }
                    break;
                case 0:
                    if (ie.value > 0) {
                        event = "RIGHT";
                    } else {
                        event = "LEFT";
                    }
                    break;
                case 1:
                    if (ie.value > 0) {
                        event = "DOWN";
                    } else {
                        event = "UP";
                    }
                    break;
            }
            break;
    }
    lua_pushstring(L, event);
    return 1;
}


/* Register this file's functions with the
 * luaopen_libraryname() function, where libraryname
 * is the name of the compiled .so output. In other words
 * it's the filename (but not extension) after the -o
 * in the cc command.
 *
 * So for instance, if your cc command has -o mouse.so then
 * this function would be called luaopen_mouse().
 *
 * This function should contain lua_register() commands for
 * each function you want available from Lua.
 *
*/
int luaopen_mouse(lua_State *L){
	lua_register(
			L,               /* Lua state variable */
			"mouse",        /* func name as known in Lua */
			mouse          /* func name in this file */
			);  
	return 0;
}
