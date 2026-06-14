# dashboard/Makefile
#
# Usage:
#   make          → build the project
#   make clean    → remove object files and the binary
#   make install  → install the binary to /usr/local/bin
#   make run      → build and run the application

# ------------------------------------------------------------------ #
# Toolchain                                                          #
# ------------------------------------------------------------------ #

CC = gcc

# ------------------------------------------------------------------ #
# Local LVGL (lvgl/ directory inside the project)                    #
# ------------------------------------------------------------------ #

LVGL_DIR = lvgl

# Collect all LVGL .c source files recursively
LVGL_SRC = $(shell find $(LVGL_DIR)/src -name "*.c")
LVGL_OBJ = $(LVGL_SRC:.c=.o)

# ------------------------------------------------------------------ #
# Compilation flags                                                  #
# ------------------------------------------------------------------ #

CFLAGS  = -Wall -Wextra -std=c11 -O2 \
          -I. \
          -I$(LVGL_DIR)

# Debug build: uncomment the line below and comment out the one above
# CFLAGS = -Wall -Wextra -std=c11 -g3 -O0 -I. -I$(LVGL_DIR)

LDFLAGS = -pthread -lm

# ------------------------------------------------------------------ #
# Project source files                                               #
# ------------------------------------------------------------------ #

TARGET = dashboard

SRC = src/main.c \
      src/sensor.c \
      drivers/fb_driver.c \
      drivers/input_driver.c \
      ui/dashboard_ui.c

OBJ = $(SRC:.c=.o)

# ------------------------------------------------------------------ #
# Build rules                                                        #
# ------------------------------------------------------------------ #

.PHONY: all clean install run

all: $(TARGET)

# Link project sources with LVGL
$(TARGET): $(OBJ) $(LVGL_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
	@echo ""
	@echo "  Binary: $(TARGET)"
	@echo "  Size: $$(du -sh $(TARGET) | cut -f1)"
	@echo ""

%.o: %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(LVGL_OBJ) $(TARGET)

install: $(TARGET)
	install -m 755 $(TARGET) /usr/local/bin/$(TARGET)

run: $(TARGET)
	./$(TARGET)