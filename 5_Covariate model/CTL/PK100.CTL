$PROB DECITABINE_110411
$INPUT ID TAD TIME AMT RATE DV MDV SS II DOSE ISM BW AP CLCR CRRT DAI SEPS EDEM DAY
$DATA FLU_F22_30.csv IGNORE=@

$SUBROUTINE ADVAN1 TRANS2 

$PK

 TVCL = THETA(1)
 TVV  = THETA(2)
 
 CL   = TVCL  * EXP(ETA(1))
 V    = TVV  * EXP(ETA(2))
  
 S1   = V
 
$ERROR
  IPRED  = F
  W     = SQRT(THETA(3)**2 + THETA(4)**2 * IPRED**2)
  IRES  = DV - IPRED
  IWRES  = IRES / W
  Y     = IPRED + W * EPS(1)
  
$THETA
 (0, 1.63)
 (0, 62) 
 0.0001 FIX
 0.12
 
$OMEGA 
 0.11
 0.04
 
$SIGMA 
 1 FIX
 
$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 INTER PRINT=10 SIGDIGITS=3 

$TABLE ID TIME TAD AMT RATE MDV IPRED IWRES
       ONEHEADER NOPRINT FILE=sdtab100
$TABLE ID CL V
       NOAPPEND ONEHEADER NOPRINT FILE=patab100
$TABLE ID BW AP CLCR DAY 
       NOAPPEND ONEHEADER NOPRINT  FILE=cotab100
$TABLE ID ISM CRRT SEPS EDEM DAI
       NOAPPEND ONEHEADER NOPRINT  FILE=catab100

