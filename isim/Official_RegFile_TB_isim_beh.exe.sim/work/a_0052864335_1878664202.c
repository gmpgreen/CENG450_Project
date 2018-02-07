/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xc3576ebc */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/lymacasm/RegFile_ALU/Official_RegFile_TB.vhd";



static void work_a_0052864335_1878664202_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;

LAB0:    t1 = (t0 + 3472U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(21, ng0);
    t2 = (t0 + 4328);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(21, ng0);
    t7 = (10 * 1000000LL);
    t2 = (t0 + 3280);
    xsi_process_wait(t2, t7);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(22, ng0);
    t2 = (t0 + 4328);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(22, ng0);
    t7 = (10 * 1000000LL);
    t2 = (t0 + 3280);
    xsi_process_wait(t2, t7);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_0052864335_1878664202_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    unsigned char t11;
    unsigned char t12;

LAB0:    t1 = (t0 + 3720U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(25, ng0);
    t2 = (t0 + 4392);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(25, ng0);
    t2 = (t0 + 7136);
    t4 = (t0 + 4456);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(25, ng0);
    t2 = (t0 + 7139);
    t4 = (t0 + 4520);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(25, ng0);
    t2 = (t0 + 4584);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(25, ng0);
    t2 = (t0 + 7142);
    t4 = (t0 + 4648);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(26, ng0);
    t2 = (t0 + 7145);
    t4 = (t0 + 4712);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 16U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(27, ng0);

LAB6:    t2 = (t0 + 4040);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    t5 = (t0 + 4040);
    *((int *)t5) = 0;
    xsi_set_current_line(27, ng0);

LAB13:    t2 = (t0 + 4056);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB14;
    goto LAB1;

LAB5:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)2);
    if (t11 == 1)
        goto LAB8;

LAB9:    t9 = (unsigned char)0;

LAB10:    if (t9 == 1)
        goto LAB4;
    else
        goto LAB6;

LAB7:    goto LAB5;

LAB8:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB10;

LAB11:    t5 = (t0 + 4056);
    *((int *)t5) = 0;
    xsi_set_current_line(27, ng0);

LAB20:    t2 = (t0 + 4072);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB21;
    goto LAB1;

LAB12:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB15;

LAB16:    t9 = (unsigned char)0;

LAB17:    if (t9 == 1)
        goto LAB11;
    else
        goto LAB13;

LAB14:    goto LAB12;

LAB15:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB17;

LAB18:    t5 = (t0 + 4072);
    *((int *)t5) = 0;
    xsi_set_current_line(28, ng0);
    t2 = (t0 + 4392);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(29, ng0);

LAB27:    t2 = (t0 + 4088);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB28;
    goto LAB1;

LAB19:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB22;

LAB23:    t9 = (unsigned char)0;

LAB24:    if (t9 == 1)
        goto LAB18;
    else
        goto LAB20;

LAB21:    goto LAB19;

LAB22:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB24;

LAB25:    t5 = (t0 + 4088);
    *((int *)t5) = 0;
    xsi_set_current_line(29, ng0);
    t2 = (t0 + 4584);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(29, ng0);
    t2 = (t0 + 7161);
    t4 = (t0 + 4712);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 16U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(30, ng0);

LAB34:    t2 = (t0 + 4104);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB35;
    goto LAB1;

LAB26:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB29;

LAB30:    t9 = (unsigned char)0;

LAB31:    if (t9 == 1)
        goto LAB25;
    else
        goto LAB27;

LAB28:    goto LAB26;

LAB29:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB31;

LAB32:    t5 = (t0 + 4104);
    *((int *)t5) = 0;
    xsi_set_current_line(30, ng0);
    t2 = (t0 + 7177);
    t4 = (t0 + 4648);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(30, ng0);
    t2 = (t0 + 7180);
    t4 = (t0 + 4712);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 16U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(31, ng0);

LAB41:    t2 = (t0 + 4120);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB42;
    goto LAB1;

LAB33:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB36;

LAB37:    t9 = (unsigned char)0;

LAB38:    if (t9 == 1)
        goto LAB32;
    else
        goto LAB34;

LAB35:    goto LAB33;

LAB36:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB38;

LAB39:    t5 = (t0 + 4120);
    *((int *)t5) = 0;
    xsi_set_current_line(31, ng0);
    t2 = (t0 + 7196);
    t4 = (t0 + 4648);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(31, ng0);
    t2 = (t0 + 7199);
    t4 = (t0 + 4712);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 16U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(32, ng0);

LAB48:    t2 = (t0 + 4136);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB49;
    goto LAB1;

LAB40:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB43;

LAB44:    t9 = (unsigned char)0;

LAB45:    if (t9 == 1)
        goto LAB39;
    else
        goto LAB41;

LAB42:    goto LAB40;

LAB43:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB45;

LAB46:    t5 = (t0 + 4136);
    *((int *)t5) = 0;
    xsi_set_current_line(32, ng0);
    t2 = (t0 + 7215);
    t4 = (t0 + 4648);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(32, ng0);
    t2 = (t0 + 7218);
    t4 = (t0 + 4712);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 16U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(33, ng0);

LAB55:    t2 = (t0 + 4152);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB56;
    goto LAB1;

LAB47:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB50;

LAB51:    t9 = (unsigned char)0;

LAB52:    if (t9 == 1)
        goto LAB46;
    else
        goto LAB48;

LAB49:    goto LAB47;

LAB50:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB52;

LAB53:    t5 = (t0 + 4152);
    *((int *)t5) = 0;
    xsi_set_current_line(33, ng0);
    t2 = (t0 + 7234);
    t4 = (t0 + 4648);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(33, ng0);
    t2 = (t0 + 7237);
    t4 = (t0 + 4712);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 16U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(34, ng0);

LAB62:    t2 = (t0 + 4168);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB63;
    goto LAB1;

LAB54:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB57;

LAB58:    t9 = (unsigned char)0;

LAB59:    if (t9 == 1)
        goto LAB53;
    else
        goto LAB55;

LAB56:    goto LAB54;

LAB57:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB59;

LAB60:    t5 = (t0 + 4168);
    *((int *)t5) = 0;
    xsi_set_current_line(34, ng0);
    t2 = (t0 + 7253);
    t4 = (t0 + 4648);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(34, ng0);
    t2 = (t0 + 7256);
    t4 = (t0 + 4712);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 16U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(35, ng0);

LAB69:    t2 = (t0 + 4184);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB70;
    goto LAB1;

LAB61:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB64;

LAB65:    t9 = (unsigned char)0;

LAB66:    if (t9 == 1)
        goto LAB60;
    else
        goto LAB62;

LAB63:    goto LAB61;

LAB64:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB66;

LAB67:    t5 = (t0 + 4184);
    *((int *)t5) = 0;
    xsi_set_current_line(35, ng0);
    t2 = (t0 + 4584);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(36, ng0);

LAB76:    t2 = (t0 + 4200);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB77;
    goto LAB1;

LAB68:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB71;

LAB72:    t9 = (unsigned char)0;

LAB73:    if (t9 == 1)
        goto LAB67;
    else
        goto LAB69;

LAB70:    goto LAB68;

LAB71:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB73;

LAB74:    t5 = (t0 + 4200);
    *((int *)t5) = 0;
    xsi_set_current_line(36, ng0);
    t2 = (t0 + 7272);
    t4 = (t0 + 4520);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(37, ng0);

LAB83:    t2 = (t0 + 4216);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB84;
    goto LAB1;

LAB75:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB78;

LAB79:    t9 = (unsigned char)0;

LAB80:    if (t9 == 1)
        goto LAB74;
    else
        goto LAB76;

LAB77:    goto LAB75;

LAB78:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB80;

LAB81:    t5 = (t0 + 4216);
    *((int *)t5) = 0;
    xsi_set_current_line(37, ng0);
    t2 = (t0 + 7275);
    t4 = (t0 + 4456);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(38, ng0);

LAB90:    t2 = (t0 + 4232);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB91;
    goto LAB1;

LAB82:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB85;

LAB86:    t9 = (unsigned char)0;

LAB87:    if (t9 == 1)
        goto LAB81;
    else
        goto LAB83;

LAB84:    goto LAB82;

LAB85:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB87;

LAB88:    t5 = (t0 + 4232);
    *((int *)t5) = 0;
    xsi_set_current_line(38, ng0);
    t2 = (t0 + 7278);
    t4 = (t0 + 4520);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(39, ng0);

LAB97:    t2 = (t0 + 4248);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB98;
    goto LAB1;

LAB89:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB92;

LAB93:    t9 = (unsigned char)0;

LAB94:    if (t9 == 1)
        goto LAB88;
    else
        goto LAB90;

LAB91:    goto LAB89;

LAB92:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB94;

LAB95:    t5 = (t0 + 4248);
    *((int *)t5) = 0;
    xsi_set_current_line(39, ng0);
    t2 = (t0 + 7281);
    t4 = (t0 + 4456);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(40, ng0);
    t2 = (t0 + 7284);
    t4 = (t0 + 4520);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(40, ng0);

LAB104:    *((char **)t1) = &&LAB105;
    goto LAB1;

LAB96:    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB99;

LAB100:    t9 = (unsigned char)0;

LAB101:    if (t9 == 1)
        goto LAB95;
    else
        goto LAB97;

LAB98:    goto LAB96;

LAB99:    t3 = (t0 + 1152U);
    t12 = xsi_signal_has_event(t3);
    t9 = t12;
    goto LAB101;

LAB102:    goto LAB2;

LAB103:    goto LAB102;

LAB105:    goto LAB103;

}


extern void work_a_0052864335_1878664202_init()
{
	static char *pe[] = {(void *)work_a_0052864335_1878664202_p_0,(void *)work_a_0052864335_1878664202_p_1};
	xsi_register_didat("work_a_0052864335_1878664202", "isim/Official_RegFile_TB_isim_beh.exe.sim/work/a_0052864335_1878664202.didat");
	xsi_register_executes(pe);
}
