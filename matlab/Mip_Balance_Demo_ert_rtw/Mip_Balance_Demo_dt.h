/*
 * Mip_Balance_Demo_dt.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "Mip_Balance_Demo".
 *
 * Model version              : 1.39
 * Simulink Coder version : 9.0 (R2018b) 24-May-2018
 * C source code generated on : Mon Dec 24 13:12:04 2018
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "ext_types.h"

/* data type size table */
static uint_T rtDataTypeSizes[] = {
  sizeof(real_T),
  sizeof(real32_T),
  sizeof(int8_T),
  sizeof(uint8_T),
  sizeof(int16_T),
  sizeof(uint16_T),
  sizeof(int32_T),
  sizeof(uint32_T),
  sizeof(boolean_T),
  sizeof(fcn_call_T),
  sizeof(int_T),
  sizeof(pointer_T),
  sizeof(action_T),
  2*sizeof(uint32_T),
  sizeof(uint8_T),
  sizeof(int32_T),
  sizeof(int64m_T),
  sizeof(int32_T),
  sizeof(int64m_T),
  sizeof(int64m_T),
  sizeof(beagleboneblue_bbblueEncoder__T),
  sizeof(beagleboneblue_fccr_bbblueIMU_T),
  sizeof(beagleboneblue_bbblueDCMotor__T),
  sizeof(beagleboneblue_bbblueButton_M_T),
  sizeof(beagleboneblue_bbblueLED_Mip__T),
  sizeof(uint8_T),
  sizeof(int64m_T),
  sizeof(uint64m_T),
  sizeof(int96m_T),
  sizeof(uint96m_T),
  sizeof(int128m_T),
  sizeof(uint128m_T),
  sizeof(int160m_T),
  sizeof(uint160m_T),
  sizeof(int192m_T),
  sizeof(uint192m_T),
  sizeof(int224m_T),
  sizeof(uint224m_T),
  sizeof(int256m_T),
  sizeof(uint256m_T)
};

/* data type name table */
static const char_T * rtDataTypeNames[] = {
  "real_T",
  "real32_T",
  "int8_T",
  "uint8_T",
  "int16_T",
  "uint16_T",
  "int32_T",
  "uint32_T",
  "boolean_T",
  "fcn_call_T",
  "int_T",
  "pointer_T",
  "action_T",
  "timer_uint32_pair_T",
  "uint8_T",
  "int32_T",
  "int64m_T",
  "int32_T",
  "int64m_T",
  "int64m_T",
  "beagleboneblue_bbblueEncoder__T",
  "beagleboneblue_fccr_bbblueIMU_T",
  "beagleboneblue_bbblueDCMotor__T",
  "beagleboneblue_bbblueButton_M_T",
  "beagleboneblue_bbblueLED_Mip__T",
  "uint8_T",
  "int64m_T",
  "uint64m_T",
  "int96m_T",
  "uint96m_T",
  "int128m_T",
  "uint128m_T",
  "int160m_T",
  "uint160m_T",
  "int192m_T",
  "uint192m_T",
  "int224m_T",
  "uint224m_T",
  "int256m_T",
  "uint256m_T"
};

/* data type transitions for block I/O structure */
static DataTypeTransition rtBTransitions[] = {
  { (char_T *)(&Mip_Balance_Demo_B.Sum1), 0, 0, 8 }
  ,

  { (char_T *)(&Mip_Balance_Demo_DW.obj), 22, 0, 2 },

  { (char_T *)(&Mip_Balance_Demo_DW.obj_l), 21, 0, 1 },

  { (char_T *)(&Mip_Balance_Demo_DW.obj_h), 23, 0, 1 },

  { (char_T *)(&Mip_Balance_Demo_DW.obj_d), 20, 0, 2 },

  { (char_T *)(&Mip_Balance_Demo_DW.obj_lf), 24, 0, 1 },

  { (char_T *)(&Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE), 0, 0, 10 },

  { (char_T *)(&Mip_Balance_Demo_DW.u1_PWORK.LoggedData[0]), 11, 0, 7 },

  { (char_T *)(&Mip_Balance_Demo_DW.clockTickCounter), 6, 0, 1 },

  { (char_T *)(&Mip_Balance_Demo_DW.UnitDelay_DSTATE), 8, 0, 1 },

  { (char_T *)(&Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE_n), 14, 0, 2 },

  { (char_T *)(&Mip_Balance_Demo_DW.DiscreteTimeIntegrator_PrevRese), 2, 0, 5 },

  { (char_T *)(&Mip_Balance_Demo_DW.Controller_MODE), 8, 0, 1 }
};

/* data type transition table for block I/O structure */
static DataTypeTransitionTable rtBTransTable = {
  13U,
  rtBTransitions
};

/* data type transitions for Parameters structure */
static DataTypeTransition rtPTransitions[] = {
  { (char_T *)(&Mip_Balance_Demo_P.CompareToConstant_const), 0, 0, 66 },

  { (char_T *)(&Mip_Balance_Demo_P.Gain3_Gain), 19, 0, 1 },

  { (char_T *)(&Mip_Balance_Demo_P.ENCODER_POLARITY_L_Gain), 15, 0, 2 },

  { (char_T *)(&Mip_Balance_Demo_P.UnitDelay_InitialCondition), 8, 0, 1 },

  { (char_T *)(&Mip_Balance_Demo_P.DiscreteTimeIntegrator_IC_l), 14, 0, 2 }
};

/* data type transition table for Parameters structure */
static DataTypeTransitionTable rtPTransTable = {
  5U,
  rtPTransitions
};

/* [EOF] Mip_Balance_Demo_dt.h */
