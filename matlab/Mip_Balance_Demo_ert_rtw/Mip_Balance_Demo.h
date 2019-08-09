/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Mip_Balance_Demo.h
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

#ifndef RTW_HEADER_Mip_Balance_Demo_h_
#define RTW_HEADER_Mip_Balance_Demo_h_
#include <math.h>
#include <float.h>
#include <string.h>
#include <stddef.h>
#ifndef Mip_Balance_Demo_COMMON_INCLUDES_
# define Mip_Balance_Demo_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_extmode.h"
#include "sysran_types.h"
#include "dt_info.h"
#include "ext_work.h"
#include "MW_bbblue_driver.h"
#include "fccr_bbblue_driver.h"
#endif                                 /* Mip_Balance_Demo_COMMON_INCLUDES_ */

#include "Mip_Balance_Demo_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_defines.h"
#include "rt_nonfinite.h"
#include "rtGetInf.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWExtModeInfo
# define rtmGetRTWExtModeInfo(rtm)     ((rtm)->extModeInfo)
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
# define rtmGetTPtr(rtm)               (&(rtm)->Timing.taskTime0)
#endif

/* Block signals (default storage) */
typedef struct {
  real_T Sum1;                         /* '<S5>/Sum1' */
  real_T phirad;                       /* '<S5>/Sum2' */
  real_T PhiRef;                       /* '<S1>/Phi Ref' */
  real_T Multiply;                     /* '<S1>/Multiply' */
  real_T Saturation;                   /* '<S3>/Saturation' */
  real_T Multiply_n;                   /* '<S3>/Multiply' */
  real_T Sum2;                         /* '<S4>/Sum2' */
  real_T D1100hzFastLoopController;    /* '<S4>/D1 100hz Fast Loop Controller' */
  real_T denAccum;
  real_T denAccum_m;
  real_T MOTOR_POLARITY_R;             /* '<S5>/MOTOR_POLARITY_R' */
  real_T WaitCounter;                  /* '<S14>/Wait Counter' */
} B_Mip_Balance_Demo_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  beagleboneblue_bbblueDCMotor__T obj; /* '<S5>/MOTOR_CHANNEL_L' */
  beagleboneblue_bbblueDCMotor__T obj_f;/* '<S5>/MOTOR_CHANNEL_R' */
  beagleboneblue_fccr_bbblueIMU_T obj_l;/* '<S5>/MATLAB System1' */
  beagleboneblue_bbblueButton_M_T obj_h;/* '<Root>/Button' */
  beagleboneblue_bbblueEncoder__T obj_d;/* '<S5>/ENCODER_CHANNEL_R' */
  beagleboneblue_bbblueEncoder__T obj_a;/* '<S5>/ENCODER_CHANNEL_L' */
  beagleboneblue_bbblueLED_Mip__T obj_lf;/* '<Root>/LED' */
  real_T DiscreteTimeIntegrator_DSTATE;/* '<S12>/Discrete-Time Integrator' */
  real_T WaitCounter_DSTATE;           /* '<S14>/Wait Counter' */
  real_T LowPass_states;               /* '<S9>/Low Pass ' */
  real_T IntegrateGyro_DSTATE;         /* '<S8>/Integrate Gyro' */
  real_T HighPass_states;              /* '<S9>/High Pass  ' */
  real_T D2100hzSlowLoopController1_stat[2];/* '<S4>/D2 100 hz Slow Loop Controller1' */
  real_T Integratorforpositionkeeping_DS;/* '<S4>/Integrator for  position keeping' */
  real_T D1100hzFastLoopController_state[2];/* '<S4>/D1 100hz Fast Loop Controller' */
  struct {
    void *LoggedData[3];
  } u1_PWORK;                          /* '<S1>/u1' */

  struct {
    void *LoggedData[2];
  } Theta_PWORK;                       /* '<S4>/Theta' */

  struct {
    void *LoggedData[2];
  } Phi_PWORK;                         /* '<S4>/Phi' */

  int32_T clockTickCounter;            /* '<Root>/Pulse Generator' */
  boolean_T UnitDelay_DSTATE;          /* '<S2>/Unit Delay' */
  uint8_T DiscreteTimeIntegrator_DSTATE_n;/* '<S11>/Discrete-Time Integrator' */
  uint8_T StartCounter_DSTATE;         /* '<S13>/Start Counter' */
  int8_T DiscreteTimeIntegrator_PrevRese;/* '<S12>/Discrete-Time Integrator' */
  int8_T DiscreteTimeIntegrator_PrevRe_e;/* '<S11>/Discrete-Time Integrator' */
  int8_T StartCounter_PrevResetState;  /* '<S13>/Start Counter' */
  int8_T WaitCounter_PrevResetState;   /* '<S14>/Wait Counter' */
  int8_T Controller_SubsysRanBC;       /* '<S1>/Controller' */
  boolean_T Controller_MODE;           /* '<S1>/Controller' */
} DW_Mip_Balance_Demo_T;

/* Parameters (default storage) */
struct P_Mip_Balance_Demo_T_ {
  real_T CompareToConstant_const;      /* Mask Parameter: CompareToConstant_const
                                        * Referenced by: '<S6>/Constant'
                                        */
  real_T Button_SampleTime;            /* Expression: 0.1
                                        * Referenced by: '<Root>/Button'
                                        */
  real_T U_Y0;                         /* Computed Parameter: U_Y0
                                        * Referenced by: '<S4>/U'
                                        */
  real_T D2_GAIN_Gain;                 /* Expression: 0.9
                                        * Referenced by: '<S4>/D2_GAIN'
                                        */
  real_T D2100hzSlowLoopController1_NumC[3];/* Expression: [0.28,  -0.5581,  0.2781]
                                             * Referenced by: '<S4>/D2 100 hz Slow Loop Controller1'
                                             */
  real_T D2100hzSlowLoopController1_DenC[3];/* Expression: [1.00000,  -1.86046,   0.86046]
                                             * Referenced by: '<S4>/D2 100 hz Slow Loop Controller1'
                                             */
  real_T D2100hzSlowLoopController1_Init;/* Expression: 0
                                          * Referenced by: '<S4>/D2 100 hz Slow Loop Controller1'
                                          */
  real_T Integratorforpositionkeeping_ga;/* Computed Parameter: Integratorforpositionkeeping_ga
                                          * Referenced by: '<S4>/Integrator for  position keeping'
                                          */
  real_T Integratorforpositionkeeping_IC;/* Expression: 0
                                          * Referenced by: '<S4>/Integrator for  position keeping'
                                          */
  real_T D1_GAIN_Gain;                 /* Expression: 0.8
                                        * Referenced by: '<S4>/D1_GAIN'
                                        */
  real_T D1100hzFastLoopController_NumCo[3];/* Expression: [-4.945, 8.862, -3.967]
                                             * Referenced by: '<S4>/D1 100hz Fast Loop Controller'
                                             */
  real_T D1100hzFastLoopController_DenCo[3];/* Expression: [1.000, -1.481, 0.4812]
                                             * Referenced by: '<S4>/D1 100hz Fast Loop Controller'
                                             */
  real_T D1100hzFastLoopController_Initi;/* Expression: 0
                                          * Referenced by: '<S4>/D1 100hz Fast Loop Controller'
                                          */
  real_T MATLABSystem1_SampleTime;     /* Expression: 0.01
                                        * Referenced by: '<S5>/MATLAB System1'
                                        */
  real_T ENCODER_CHANNEL_L_SampleTime; /* Expression: 0.01
                                        * Referenced by: '<S5>/ENCODER_CHANNEL_L'
                                        */
  real_T ENCODER_CHANNEL_R_SampleTime; /* Expression: 0.01
                                        * Referenced by: '<S5>/ENCODER_CHANNEL_R'
                                        */
  real_T LowPass_NumCoef[2];           /* Expression: [0 wc*dt]
                                        * Referenced by: '<S9>/Low Pass '
                                        */
  real_T LowPass_DenCoef[2];           /* Expression: [1 (wc*dt - 1)]
                                        * Referenced by: '<S9>/Low Pass '
                                        */
  real_T LowPass_InitialStates;        /* Expression: 0
                                        * Referenced by: '<S9>/Low Pass '
                                        */
  real_T IntegrateGyro_gainval;        /* Computed Parameter: IntegrateGyro_gainval
                                        * Referenced by: '<S8>/Integrate Gyro'
                                        */
  real_T IntegrateGyro_IC;             /* Expression: 0
                                        * Referenced by: '<S8>/Integrate Gyro'
                                        */
  real_T Gain2_Gain;                   /* Expression: 1
                                        * Referenced by: '<S8>/Gain2'
                                        */
  real_T HighPass_NumCoef[2];          /* Expression: [1 -1]
                                        * Referenced by: '<S9>/High Pass  '
                                        */
  real_T HighPass_DenCoef[2];          /* Expression: [1 (wc*dt - 1)]
                                        * Referenced by: '<S9>/High Pass  '
                                        */
  real_T HighPass_InitialStates;       /* Expression: 0
                                        * Referenced by: '<S9>/High Pass  '
                                        */
  real_T MountAngle_Value;             /* Expression: .49
                                        * Referenced by: '<S5>/Mount Angle'
                                        */
  real_T Gain4_Gain;                   /* Expression: 2*pi
                                        * Referenced by: '<S5>/Gain4'
                                        */
  real_T Gain5_Gain;                   /* Expression: 1/35.555
                                        * Referenced by: '<S5>/Gain5'
                                        */
  real_T Gain6_Gain;                   /* Expression: 1/60
                                        * Referenced by: '<S5>/Gain6'
                                        */
  real_T PhiRef_Value;                 /* Expression: 1
                                        * Referenced by: '<S1>/Phi Ref'
                                        */
  real_T Saturation_UpperSat;          /* Expression: 1
                                        * Referenced by: '<S3>/Saturation'
                                        */
  real_T Saturation_LowerSat;          /* Expression: -1
                                        * Referenced by: '<S3>/Saturation'
                                        */
  real_T Constant_Value;               /* Expression: 0
                                        * Referenced by: '<S7>/Constant'
                                        */
  real_T Gain_Gain;                    /* Expression: 100
                                        * Referenced by: '<S5>/Gain'
                                        */
  real_T MOTOR_POLARITY_L_Gain;        /* Expression: 1
                                        * Referenced by: '<S5>/MOTOR_POLARITY_L'
                                        */
  real_T MOTOR_POLARITY_R_Gain;        /* Expression: -1
                                        * Referenced by: '<S5>/MOTOR_POLARITY_R'
                                        */
  real_T Gain1_Gain;                   /* Expression: pi/180
                                        * Referenced by: '<S10>/Gain1'
                                        */
  real_T Gain1_Gain_o;                 /* Expression: -1
                                        * Referenced by: '<S8>/Gain1'
                                        */
  real_T DiscreteTimeIntegrator_gainval;/* Computed Parameter: DiscreteTimeIntegrator_gainval
                                         * Referenced by: '<S12>/Discrete-Time Integrator'
                                         */
  real_T DiscreteTimeIntegrator_IC;    /* Expression: 0
                                        * Referenced by: '<S12>/Discrete-Time Integrator'
                                        */
  real_T SoftStartTime1_Value;         /* Expression: .9
                                        * Referenced by: '<S12>/Soft Start Time1'
                                        */
  real_T Saturation_UpperSat_g;        /* Expression: 1
                                        * Referenced by: '<S12>/Saturation'
                                        */
  real_T Saturation_LowerSat_e;        /* Expression: 0
                                        * Referenced by: '<S12>/Saturation'
                                        */
  real_T SatTimeout_Value;             /* Expression: .5
                                        * Referenced by: '<S11>/Sat Timeout'
                                        */
  real_T StartAngle_Value;             /* Expression: .6
                                        * Referenced by: '<S13>/Start Angle'
                                        */
  real_T StartTimeout_Value;           /* Expression: 1
                                        * Referenced by: '<S13>/Start Timeout'
                                        */
  real_T WaitCounter_gainval;          /* Computed Parameter: WaitCounter_gainval
                                        * Referenced by: '<S14>/Wait Counter'
                                        */
  real_T WaitCounter_IC;               /* Expression: 0
                                        * Referenced by: '<S14>/Wait Counter'
                                        */
  real_T WaittoStart_Value;            /* Expression: 3
                                        * Referenced by: '<S14>/Wait to Start'
                                        */
  real_T Constant_Value_j;             /* Expression: 1
                                        * Referenced by: '<S14>/Constant'
                                        */
  real_T PulseGenerator_Amp;           /* Expression: 1
                                        * Referenced by: '<Root>/Pulse Generator'
                                        */
  real_T PulseGenerator_Period;        /* Expression: 10
                                        * Referenced by: '<Root>/Pulse Generator'
                                        */
  real_T PulseGenerator_Duty;          /* Expression: 5
                                        * Referenced by: '<Root>/Pulse Generator'
                                        */
  real_T PulseGenerator_PhaseDelay;    /* Expression: 0
                                        * Referenced by: '<Root>/Pulse Generator'
                                        */
  int64m_T Gain3_Gain;                 /* Computed Parameter: Gain3_Gain
                                        * Referenced by: '<S5>/Gain3'
                                        */
  int32_T ENCODER_POLARITY_L_Gain;     /* Computed Parameter: ENCODER_POLARITY_L_Gain
                                        * Referenced by: '<S5>/ENCODER_POLARITY_L'
                                        */
  int32_T ENCODER_POLARITY_R_Gain;     /* Computed Parameter: ENCODER_POLARITY_R_Gain
                                        * Referenced by: '<S5>/ENCODER_POLARITY_R'
                                        */
  boolean_T UnitDelay_InitialCondition;/* Computed Parameter: UnitDelay_InitialCondition
                                        * Referenced by: '<S2>/Unit Delay'
                                        */
  uint8_T DiscreteTimeIntegrator_IC_l; /* Computed Parameter: DiscreteTimeIntegrator_IC_l
                                        * Referenced by: '<S11>/Discrete-Time Integrator'
                                        */
  uint8_T StartCounter_IC;             /* Computed Parameter: StartCounter_IC
                                        * Referenced by: '<S13>/Start Counter'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_Mip_Balance_Demo_T {
  const char_T *errorStatus;
  RTWExtModeInfo *extModeInfo;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    time_T stepSize0;
    uint32_T clockTick1;
    struct {
      uint8_T TID[2];
    } TaskCounters;

    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block parameters (default storage) */
extern P_Mip_Balance_Demo_T Mip_Balance_Demo_P;

/* Block signals (default storage) */
extern B_Mip_Balance_Demo_T Mip_Balance_Demo_B;

/* Block states (default storage) */
extern DW_Mip_Balance_Demo_T Mip_Balance_Demo_DW;

/* Model entry point functions */
extern void Mip_Balance_Demo_initialize(void);
extern void Mip_Balance_Demo_step(void);
extern void Mip_Balance_Demo_terminate(void);

/* Real-time Model object */
extern RT_MODEL_Mip_Balance_Demo_T *const Mip_Balance_Demo_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'Mip_Balance_Demo'
 * '<S1>'   : 'Mip_Balance_Demo/Balance System'
 * '<S2>'   : 'Mip_Balance_Demo/Startup Logic'
 * '<S3>'   : 'Mip_Balance_Demo/Balance System/Control Saturation and Scaling'
 * '<S4>'   : 'Mip_Balance_Demo/Balance System/Controller'
 * '<S5>'   : 'Mip_Balance_Demo/Balance System/Plant'
 * '<S6>'   : 'Mip_Balance_Demo/Balance System/Control Saturation and Scaling/Compare To Constant'
 * '<S7>'   : 'Mip_Balance_Demo/Balance System/Control Saturation and Scaling/Compare To Zero'
 * '<S8>'   : 'Mip_Balance_Demo/Balance System/Plant/Complementary Filter1'
 * '<S9>'   : 'Mip_Balance_Demo/Balance System/Plant/Complementary Filter1/Complementary Filter'
 * '<S10>'  : 'Mip_Balance_Demo/Balance System/Plant/Complementary Filter1/Degrees to Radians1'
 * '<S11>'  : 'Mip_Balance_Demo/Startup Logic/Saturation Counter'
 * '<S12>'  : 'Mip_Balance_Demo/Startup Logic/Soft Start Counter '
 * '<S13>'  : 'Mip_Balance_Demo/Startup Logic/Start Condition'
 * '<S14>'  : 'Mip_Balance_Demo/Startup Logic/Wait to Start'
 */
#endif                                 /* RTW_HEADER_Mip_Balance_Demo_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
