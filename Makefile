SRC_DIR = ./src/

all: clean
	fpc $(SRC_DIR)Converter.pas

clean:
	rm -f $(SRC_DIR)Converter.o
	rm -f $(SRC_DIR)ModuleApp.o
	rm -f $(SRC_DIR)ModuleTasks.o
	rm -f $(SRC_DIR)ModuleApp.ppu
	rm -f $(SRC_DIR)ModuleTasks.ppu
	rm -f $(SRC_DIR)Converter.exe