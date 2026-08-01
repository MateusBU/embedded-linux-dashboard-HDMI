
/* ===========================
*          INCLUDES
* =========================== */
#include <stdio.h>
#include <stdlib.h>

#include "lvgl/lvgl.h"

#include "../include/fb_driver.h"
/* ===========================
 *           DEFINES
 * =========================== */

/* ===========================
 *     LOCAL VARIABLES
 * =========================== */


/* ===========================
 *    LOCAL PROTOTYPES
 * =========================== */

/* ===========================
 *   GLOBAL FUNCTIONS
 * =========================== */
int main(void) {

    /*lvgl init*/
    lv_init();

    /* register framebuffer driver*/
    if(fb_driver_init() != 0) {
        fprintf(stderr, "[main] fail to init framebuffer\n");
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

/* ===========================
 *   LOCAL FUNCTIONS
 * =========================== */
