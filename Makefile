# Simple Makefile Program to compile Memoria VM
NAME = memoria
SRC_FILE = vm
ADAC = gnat

all: build clean

build:
	@$(ADAC) make $(SRC_FILE).adb -o $(NAME)
	@echo "---> Built Memoria VM"

clean:
	@rm $(SRC_FILE).ali $(SRC_FILE).o
	@echo "---> Removed build files"

fresh:
	@rm $(NAME)
	@echo "---> Cleaned Working Directory"
