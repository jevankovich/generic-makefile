CC ?= gcc
CXX ?= g++

CFLAGS += --std=c99 -O3
DEBUG_CFLAGS += -g -O0 -Wall -Werror -pedantic

CXXFLAGS += --std=c++14 -O3
DEBUG_CXXFLAGS += -g -O0 -Wall -Werror -pedantic

LDFLAGS += 

SRC_DIR := src/
OBJ_DIR := obj/

TARGET := main

SRCS := main.cpp

OBJS := $(addsuffix .o,$(SRCS))
OBJS := $(addprefix $(OBJ_DIR),$(OBJS))

$(TARGET): dirs $(OBJS) makefile
	@echo LD $(TARGET)
	@$(CXX) $(OBJS) $(LDFLAGS) -o $(TARGET)

.PHONY: debug
debug: CFLAGS += $(DEBUG_CFLAGS)
debug: CXXFLAGS += $(DEBUG_CXXFLAGS)
debug: $(TARGET)

$(OBJ_DIR)%.c.o: $(SRC_DIR)%.c makefile
	@echo CC $@
	@$(CC) $(CFLAGS) -MMD -MP $< -c -o $@

$(OBJ_DIR)%.cpp.o: $(SRC_DIR)%.cpp makefile
	@echo CXX $@
	@$(CXX) $(CXXFLAGS) -MMD -MP $< -c -o $@

.PHONY: clean
clean: 
	@echo RM $(OBJ_DIR)
	@rm -rf $(OBJ_DIR)

.PHONY: dirs
dirs:
	@mkdir -p $(OBJ_DIR)

-include $(OBJ_DIR)*.d
