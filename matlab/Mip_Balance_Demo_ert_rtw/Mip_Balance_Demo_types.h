/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Mip_Balance_Demo_types.h
 *
 * Code generated for Simulink model 'Mip_Balance_Demo'.
 *
 * Model version                  : 1.39
 * Simulink Coder version         : 9.0 (R2018b) 24-May-2018
 * C/C++ source code generated on : Mon Dec 24 13:12:04 2018
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_Mip_Balance_Demo_types_h_
#define RTW_HEADER_Mip_Balance_Demo_types_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#ifndef typedef_beagleboneblue_bbblueLED_Mip__T
#define typedef_beagleboneblue_bbblueLED_Mip__T

typedef struct {
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
} beagleboneblue_bbblueLED_Mip__T;

#endif                                 /*typedef_beagleboneblue_bbblueLED_Mip__T*/

#ifndef typedef_beagleboneblue_bbblueButton_M_T
#define typedef_beagleboneblue_bbblueButton_M_T

typedef struct {
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  real_T SampleTime;
} beagleboneblue_bbblueButton_M_T;

#endif                                 /*typedef_beagleboneblue_bbblueButton_M_T*/

#ifndef typedef_beagleboneblue_fccr_bbblueIMU_T
#define typedef_beagleboneblue_fccr_bbblueIMU_T

typedef struct {
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  real_T SampleTime;
} beagleboneblue_fccr_bbblueIMU_T;

#endif                                 /*typedef_beagleboneblue_fccr_bbblueIMU_T*/

#ifndef typedef_beagleboneblue_bbblueEncoder__T
#define typedef_beagleboneblue_bbblueEncoder__T

typedef struct {
  int32_T isInitialized;
  real_T SampleTime;
} beagleboneblue_bbblueEncoder__T;

#endif                                 /*typedef_beagleboneblue_bbblueEncoder__T*/

#ifndef typedef_cell_wrap_Mip_Balance_Demo_T
#define typedef_cell_wrap_Mip_Balance_Demo_T

typedef struct {
  uint32_T f1[8];
} cell_wrap_Mip_Balance_Demo_T;

#endif                                 /*typedef_cell_wrap_Mip_Balance_Demo_T*/

#ifndef typedef_beagleboneblue_bbblueDCMotor__T
#define typedef_beagleboneblue_bbblueDCMotor__T

typedef struct {
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  cell_wrap_Mip_Balance_Demo_T inputVarSize;
} beagleboneblue_bbblueDCMotor__T;

#endif                                 /*typedef_beagleboneblue_bbblueDCMotor__T*/

/* Parameters (default storage) */
typedef struct P_Mip_Balance_Demo_T_ P_Mip_Balance_Demo_T;

/* Forward declaration for rtModel */
typedef struct tag_RTM_Mip_Balance_Demo_T RT_MODEL_Mip_Balance_Demo_T;

#endif                                 /* RTW_HEADER_Mip_Balance_Demo_types_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
