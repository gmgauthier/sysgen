//ZP60021  JOB (SYSGEN),'J07 M35: ZP60021',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             REGION=4096K
/*JOBPARM LINES=100
//JOBCAT   DD  DSN=SYS1.VSAM.MASTER.CATALOG,DISP=SHR
//*
//*  ZAP TO DISPLAY KEYBOARD CHARACTERS IN A PRINTED DUMP.
//*
//RECEIVE EXEC SMPREC,WORK='SYSALLDA'
//SMPPTFIN DD  *
++USERMOD(ZP60021)       /* SHOW KEYBOARD CHARACTERS IN DUMP */  .
++VER(Z038) FMID(EBB1102) PRE(UZ61115)
 /*
   PROBLEM DESCRIPTION:
     DUMPS SHOW PERIODS OBSCURING LOWER CASE AND OTHER CHARACTERS.
       WHEN A DUMP SUCH AS A SYSUDUMP FORMATS STORAGE CONTENTS
       INTO HEXADECIMAL AND CHARACTER DATA, THE CHARACTER DATA
       WRITTEN IS ALL PERIODS EXCEPT FOR SPACES, UPPER CASE
       ALPHABETIC AND NUMERIC EBCDIC CHARACTERS.

       THIS USERMOD REPLACES THE PERIODS TO BE USED FOR THE OTHER
       US KEYBOARD CHARACTERS IN THE RELEVANT TRANSLATE TABLE
       WITH THE CODE POINTS THEMSELVES SO THAT THESE CHARACTERS
       CAN APPEAR IN STORAGE DUMP.

   SPECIAL CONDITIONS:
     ACTION:
       A "CLPA" MUST BE PERFORMED AT IPL TIME FOR THIS SYSMOD TO
       BECOME ACTIVE.

   COMMENTS:
     PRYCROFT SIX P/L PUBLIC DOMAIN USERMOD FOR MVS 3.8 NO. 21.

     THE FOLLOWING MODULES AND/OR MACROS ARE AFFECTED BY THIS USERMOD:
     MODULES:
       IEAVAD51
 */.
++ZAP(IEAVAD51) DISTLIB(AOSC5).
 NAME IEAVAD51
 IDRDATA ZP60021
VER 01E6 4B4B4B4B4B4B4B4B   ........    HEX 00 -> 07
VER 0226 404B4B4B4B4B4B4B    .......    HEX 40 -> 47
VER 02D6 F0F1F2F3F4F5F6F7   01234567    HEX F0 -> F7
VER 02DE F8F94B4B4B4B4B4B   89......    HEX F8 -> FF
REP 022E 4B4B4A4B4C4D4E4F   ..¢.<(+|    HEX 48 -> 4F
REP 0236 504B4B4B4B4B4B4B   &.......    HEX 50 -> 57
REP 023E 4B4B5A5B5C5D5E5F   ..!$*);¬    HEX 58 -> 5F
REP 0246 60614B4B4B4B4B4B   -/......    HEX 60 -> 67
REP 024E 4B4B6A6B6C6D6E6F   ..Š,%_>?    HEX 68 -> 6F
REP 025E 4B797A7B7C7D7E7F   .`:#@'="    HEX 78 -> 7F
REP 0266 4B81828384858687   .abcdefg    HEX 80 -> 87
REP 026E 88894B4B4B4B4B4B   hi......    HEX 88 -> 8F
REP 0276 4B91929394959697   .jklmnop    HEX 90 -> 97
REP 027E 98994B4B4B4B4B4B   qr......    HEX 98 -> 9F
REP 0286 4BA1A2A3A4A5A6A7   .~stuvwx    HEX A0 -> A7
REP 028E A8A94B4B4BAD4B4B   yz...[..    HEX A8 -> AF
REP 029E 4B4B4B4B4BBD4B4B   .....]..    HEX B8 -> BF
REP 02A6 C0C1C2C3C4C5C6C7   {ABCDEFG    HEX C0 -> C7
REP 02AE C8C94B4B4B4B4B4B   HI......    HEX C8 -> CF
REP 02B6 D0D1D2D3D4D5D6D7   }JKLMNOP    HEX D0 -> D7
REP 02BE D8D94B4B4B4B4B4B   QR......    HEX D8 -> DF
REP 02C6 E04BE2E3E4E5E6E7   \.STUVWX    HEX E0 -> E7
REP 02CE E8E94B4B4B4B4B4B   YZ......    HEX E8 -> EF
/*
//SMPCNTL  DD  *
  RECEIVE
          SELECT(ZP60021)
          .
/*
//*
//APPLYCK EXEC SMPAPP,WORK='SYSALLDA'
//SMPCNTL  DD  *
  APPLY
        SELECT(ZP60021)
        CHECK
        .
/*
//*
//APPLY   EXEC SMPAPP,COND=(0,NE),WORK='SYSALLDA'
//SMPCNTL  DD  *
  APPLY
        SELECT(ZP60021)
        DIS(WRITE)
        .
/*
//