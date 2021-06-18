# directories
SRC_DIR = ./src
OBJ_DIR = ./obj

all: clean
	@cls 
	@if not exist $(OBJ_DIR) md obj
	@fpc -FEobj $(SRC_DIR)/Converter.pas
	@mv $(OBJ_DIR)/Converter.exe ./.

clean:
	@rm -f $(OBJ_DIR)/Converter.o
	@rm -f $(OBJ_DIR)/ModuleApp.o
	@rm -f $(OBJ_DIR)/ModuleTasks.o
	@rm -f $(OBJ_DIR)/ModuleApp.ppu
	@rm -f $(OBJ_DIR)/ModuleTasks.ppu
	@rm -f ./Converter.exe