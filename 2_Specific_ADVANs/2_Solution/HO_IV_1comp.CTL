$PROB HO_IV_1comp
$DATA ..//HOdata_IV.csv IGNORE=@
$INPUT ID TIME AMT DV MDV SEX AGE WT HT

$SUBROUTINE ADVAN1 TRANS2
$PK
;---- FIXED EFFECT DEFINITION ---- 
 TVCL = THETA(1)
 TVV  = THETA(2)
 
;---- RANDOM EFFECT DEFINITION ----

 CL   = TVCL * EXP(ETA(1))
 V    = TVV  * EXP(ETA(2))
 
 S1 = V
 
 KE   = CL/V
 
$ERROR
 IPRED  = F
 W      = SQRT(THETA(3)**2 + THETA(4)**2 * IPRED**2)
 IRES   = DV - IPRED
 IWRES  = IRES / W
 Y      = IPRED + W * EPS(1)

$THETA
 (0, 10, 30)
 (0, 30, 100)
  
 0.001 FIX
 (0, 0.3, 1)

$OMEGA
 0.01
 0.01
 
$SIGMA
 1 FIX

$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 INTER PRINT=10 SIGDIGITS=3 

$TABLE ID TIME AMT DV MDV IPRED CWRES IWRES  ONEHEADER NOPRINT FILE = sdtab3
$TABLE ID ETA(1) ETA(2)                      ONEHEADER NOPRINT NOAPPEND FILE = patab3
$TABLE ID SEX                                ONEHEADER NOPRINT NOAPPEND FILE = catab3
$TABLE ID AGE WT HT                          ONEHEADER NOPRINT NOAPPEND FILE = cotab3




