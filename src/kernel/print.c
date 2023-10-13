#include "../include/print.h"

struct Char {
    char character;
    unsigned char color;
};

struct Char *text_buffer = (struct Char *) 0xb8000;

const static unsigned int NUM_COLS = 80;
const static unsigned int NUM_ROWS = 25;

unsigned int cursor_col = 0;
unsigned int cursor_row = 0;
unsigned int color = PRINT_COLOR_WHITE | PRINT_COLOR_BLACK << 4;

void home()
{
    cursor_col = 0;
    cursor_row = 0;
}

void scroll_up_row(unsigned int row)
{
    for (unsigned int col = 0; col < NUM_COLS; col++) {
        text_buffer[col + NUM_COLS * (row - 1)] = text_buffer[col + NUM_COLS * row];
    }
}

void scroll_up()
{
    for (unsigned int row = 1; row < NUM_ROWS; row++) {
        scroll_up_row(row);
    }
}

void scroll_down_row(unsigned int row)
{
    for (unsigned int col = 0; col < NUM_COLS; col++) {
        text_buffer[col + NUM_COLS * (row + 1)] = text_buffer[col + NUM_COLS * row];
    }
}

void scroll_down()
{
    for (unsigned int row = NUM_ROWS - 2; row >= 0; row--) {
        scroll_up_row(row);
    }
}

void clear_row(unsigned int row)
{
    struct Char empty = {
        .character = ' ',
        .color = color,
    };
    for (unsigned int col = 0; col < NUM_COLS; col++) {
        text_buffer[col + NUM_COLS * row] = empty;
    }
}

void print_clear()
{
    for (unsigned int row = 0; row < NUM_ROWS; row++) {
        clear_row(row);
    }
    home();
}

void move_down()
{
    if (cursor_row == NUM_ROWS - 1) {
        scroll_up();
    } else {
        cursor_row++;
    }
}

void move_up()
{
    if (cursor_row == 0) {
        scroll_down();
    } else {
        cursor_row--;
    }
}

void move_left()
{
    cursor_col--;
    if (cursor_col < 0) {
        cursor_col = NUM_COLS - 1;
        move_up();
    }
}

void move_right()
{
    cursor_col++;
    if (cursor_col == NUM_COLS) {
        cursor_col = 0;
        move_down();
    }
}

void print_char(char character)
{
    switch (character) {
        case 8:
            move_left();
            break;
        case 9:
            move_right();
            break;
        case 10:
            move_down();
            break;
        case 11:
            move_up();
            break;
        case 13:
            cursor_col = 0;
            break;
        default:
            if (character >= 32 && character < 127)
            {
                struct Char printable = {
                    .character = character,
                    .color = color,
                };
                text_buffer[cursor_col + NUM_COLS * cursor_row] = printable;
                move_right();
            }
    }
}

void print_str(char *string)
{
    char a;
    while (a = *string++) {
        print_char(a);
    }
}

void print_set_color(unsigned int foreground, unsigned int background)
{
    color = foreground | background << 4;
}
