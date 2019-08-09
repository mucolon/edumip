/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Mip_Balance_Demo_data.c
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

#include "Mip_Balance_Demo.h"
#include "Mip_Balance_Demo_private.h"

/* Block parameters (default storage) */
P_Mip_Balance_Demo_T Mip_Balance_Demo_P = {
  /* Mask Parameter: CompareToConstant_const
   * Referenced by: '<S6>/Constant'
   */
  1.0,

  /* Expression: 0.1
   * Referenced by: '<Root>/Button'
   */
  0.1,

  /* Computed Parameter: U_Y0
   * Referenced by: '<S4>/U'
   */
  0.0,

  /* Expression: 0.9
   * Referenced by: '<S4>/D2_GAIN'
   */
  0.9,

  /* Expression: [0.28,  -0.5581,  0.2781]
   * Referenced by: '<S4>/D2 100 hz Slow Loop Controller1'
   */
  { 0.28, -0.5581, 0.2781 },

  /* Expression: [1.00000,  -1.86046,   0.86046]
   * Referenced by: '<S4>/D2 100 hz Slow Loop Controller1'
   */
  { 1.0, -1.86046, 0.86046 },

  /* Expression: 0
   * Referenced by: '<S4>/D2 100 hz Slow Loop Controller1'
   */
  0.0,

  /* Computed Parameter: Integratorforpositionkeeping_ga
   * Referenced by: '<S4>/Integrator for  position keeping'
   */
  5.0E-5,

  /* Expression: 0
   * Referenced by: '<S4>/Integrator for  position keeping'
   */
  0.0,

  /* Expression: 0.8
   * Referenced by: '<S4>/D1_GAIN'
   */
  0.8,

  /* Expression: [-4.945, 8.862, -3.967]
   * Referenced by: '<S4>/D1 100hz Fast Loop Controller'
   */
  { -4.945, 8.862, -3.967 },

  /* Expression: [1.000, -1.481, 0.4812]
   * Referenced by: '<S4>/D1 100hz Fast Loop Controller'
   */
  { 1.0, -1.481, 0.4812 },

  /* Expression: 0
   * Referenced by: '<S4>/D1 100hz Fast Loop Controller'
   */
  0.0,

  /* Expression: 0.01
   * Referenced by: '<S5>/MATLAB System1'
   */
  0.01,

  /* Expression: 0.01
   * Referenced by: '<S5>/ENCODER_CHANNEL_L'
   */
  0.01,

  /* Expression: 0.01
   * Referenced by: '<S5>/ENCODER_CHANNEL_R'
   */
  0.01,

  /* Expression: [0 wc*dt]
   * Referenced by: '<S9>/Low Pass '
   */
  { 0.0, 0.005 },

  /* Expression: [1 (wc*dt - 1)]
   * Referenced by: '<S9>/Low Pass '
   */
  { 1.0, -0.995 },

  /* Expression: 0
   * Referenced by: '<S9>/Low Pass '
   */
  0.0,

  /* Computed Parameter: IntegrateGyro_gainval
   * Referenced by: '<S8>/Integrate Gyro'
   */
  0.01,

  /* Expression: 0
   * Referenced by: '<S8>/Integrate Gyro'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<S8>/Gain2'
   */
  1.0,

  /* Expression: [1 -1]
   * Referenced by: '<S9>/High Pass  '
   */
  { 1.0, -1.0 },

  /* Expression: [1 (wc*dt - 1)]
   * Referenced by: '<S9>/High Pass  '
   */
  { 1.0, -0.995 },

  /* Expression: 0
   * Referenced by: '<S9>/High Pass  '
   */
  0.0,

  /* Expression: .49
   * Referenced by: '<S5>/Mount Angle'
   */
  0.49,

  /* Expression: 2*pi
   * Referenced by: '<S5>/Gain4'
   */
  6.2831853071795862,

  /* Expression: 1/35.555
   * Referenced by: '<S5>/Gain5'
   */
  0.028125439459991564,

  /* Expression: 1/60
   * Referenced by: '<S5>/Gain6'
   */
  0.016666666666666666,

  /* Expression: 1
   * Referenced by: '<S1>/Phi Ref'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<S3>/Saturation'
   */
  1.0,

  /* Expression: -1
   * Referenced by: '<S3>/Saturation'
   */
  -1.0,

  /* Expression: 0
   * Referenced by: '<S7>/Constant'
   */
  0.0,

  /* Expression: 100
   * Referenced by: '<S5>/Gain'
   */
  100.0,

  /* Expression: 1
   * Referenced by: '<S5>/MOTOR_POLARITY_L'
   */
  1.0,

  /* Expression: -1
   * Referenced by: '<S5>/MOTOR_POLARITY_R'
   */
  -1.0,

  /* Expression: pi/180
   * Referenced by: '<S10>/Gain1'
   */
  0.017453292519943295,

  /* Expression: -1
   * Referenced by: '<S8>/Gain1'
   */
  -1.0,

  /* Computed Parameter: DiscreteTimeIntegrator_gainval
   * Referenced by: '<S12>/Discrete-Time Integrator'
   */
  0.01,

  /* Expression: 0
   * Referenced by: '<S12>/Discrete-Time Integrator'
   */
  0.0,

  /* Expression: .9
   * Referenced by: '<S12>/Soft Start Time1'
   */
  0.9,

  /* Expression: 1
   * Referenced by: '<S12>/Saturation'
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<S12>/Saturation'
   */
  0.0,

  /* Expression: .5
   * Referenced by: '<S11>/Sat Timeout'
   */
  0.5,

  /* Expression: .6
   * Referenced by: '<S13>/Start Angle'
   */
  0.6,

  /* Expression: 1
   * Referenced by: '<S13>/Start Timeout'
   */
  1.0,

  /* Computed Parameter: WaitCounter_gainval
   * Referenced by: '<S14>/Wait Counter'
   */
  0.01,

  /* Expression: 0
   * Referenced by: '<S14>/Wait Counter'
   */
  0.0,

  /* Expression: 3
   * Referenced by: '<S14>/Wait to Start'
   */
  3.0,

  /* Expression: 1
   * Referenced by: '<S14>/Constant'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<Root>/Pulse Generator'
   */
  1.0,

  /* Expression: 10
   * Referenced by: '<Root>/Pulse Generator'
   */
  10.0,

  /* Expression: 5
   * Referenced by: '<Root>/Pulse Generator'
   */
  5.0,

  /* Expression: 0
   * Referenced by: '<Root>/Pulse Generator'
   */
  0.0,

  /* Computed Parameter: Gain3_Gain
   * Referenced by: '<S5>/Gain3'
   */
  { { 0UL, 0x40000000UL } },

  /* Computed Parameter: ENCODER_POLARITY_L_Gain
   * Referenced by: '<S5>/ENCODER_POLARITY_L'
   */
  1073741824,

  /* Computed Parameter: ENCODER_POLARITY_R_Gain
   * Referenced by: '<S5>/ENCODER_POLARITY_R'
   */
  MIN_int32_T,

  /* Computed Parameter: UnitDelay_InitialCondition
   * Referenced by: '<S2>/Unit Delay'
   */
  0,

  /* Computed Parameter: DiscreteTimeIntegrator_IC_l
   * Referenced by: '<S11>/Discrete-Time Integrator'
   */
  0U,

  /* Computed Parameter: StartCounter_IC
   * Referenced by: '<S13>/Start Counter'
   */
  0U
};

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
