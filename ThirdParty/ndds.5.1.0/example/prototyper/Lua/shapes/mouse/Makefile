mouse.so: mouse.c
	gcc -Wall -shared -fPIC -o mouse.so -llua mouse.c
	@#gcc -Wall -shared -fPIC -o mouse.so -I/usr/include/lua5.2 -llua5.2 mouse.c
	
clean:
	rm mouse.so
