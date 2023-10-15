#pragma once

enum {
    PRINT_COLOR_BLACK,
    PRINT_COLOR_BLUE,
    PRINT_COLOR_GREEN,
    PRINT_COLOR_CYAN,
    PRINT_COLOR_RED,
    PRINT_COLOR_MAGENTA,
    PRINT_COLOR_BROWN,
    PRINT_COLOR_LIGHT_GRAY,
    PRINT_COLOR_DARK_GRAY,
    PRINT_COLOR_LIGHT_BLUE,
    PRINT_COLOR_LIGHT_GREEN,
    PRINT_COLOR_LIGHT_CYAN,
    PRINT_COLOR_LIGHT_RED,
    PRINT_COLOR_PINK,
    PRINT_COLOR_YELLOW,
    PRINT_COLOR_WHITE,
};

void print_clear();
void print_char(char character);
void print_str(char *string);
void print_set_color(unsigned int foreground, unsigned int background);
