//NSLOOKUP JOB (JOB),'NCAT',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID,
//     REGION=4096K,MSGLEVEL=(1,1)
//ASSEM        EXEC ASMFCL,MAC='SYS2.MACLIB',MAC1='SYS2.SXMACLIB',
//             MAC2='SYS1.AMODGEN',
//             PARM.LKED='(XREF,LET,LIST,CAL)'
//ASM.SYSIN    DD DISP=SHR,DSN=SYSGEN.TCPIP.SAMPLIB(NSLOOKUP)
//LKED.SYSLMOD DD DISP=SHR,DSN=SYS2.CMDLIB(NSLOOKUP)
//LKED.SYSLIB   DD  DSN=SYS2.LINKLIB,DISP=SHR