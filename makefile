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

SRCS := main.cpp stack/stack.cpp

OBJS := $(SRCS:%=$(OBJ_DIR)%.o)
DEPS := $(SRCS:%=$(OBJ_DIR)%.d)

$(TARGET): $(OBJS)
	@echo LD $(TARGET)
	@$(CXX) $(OBJS) $(LDFLAGS) -o $(TARGET)
	@echo Done!

.PHONY: debug
debug: CFLAGS += $(DEBUG_CFLAGS)
debug: CXXFLAGS += $(DEBUG_CXXFLAGS)
debug: $(TARGET)

$(OBJ_DIR)%.c.o: $(SRC_DIR)%.c
	@echo CC $@
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -MMD -MP $< -c -o $@

$(OBJ_DIR)%.cpp.o: $(SRC_DIR)%.cpp
	@echo CXX $@
	@mkdir -p $(dir $@)
	@$(CXX) $(CXXFLAGS) -MMD -MP $< -c -o $@

.PHONY: clean
clean: 
	@echo RM $(OBJ_DIR)
	@rm -rf $(OBJ_DIR)

.PHONY: run
run: debug
	./$(TARGET)

-include $(DEPS)
