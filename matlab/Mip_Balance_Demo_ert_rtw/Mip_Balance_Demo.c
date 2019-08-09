/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Mip_Balance_Demo.c
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
#include "Mip_Balance_Demo_dt.h"

/* Block signals (default storage) */
B_Mip_Balance_Demo_T Mip_Balance_Demo_B;

/* Block states (default storage) */
DW_Mip_Balance_Demo_T Mip_Balance_Demo_DW;

/* Real-time model */
RT_MODEL_Mip_Balance_Demo_T Mip_Balance_Demo_M_;
RT_MODEL_Mip_Balance_Demo_T *const Mip_Balance_Demo_M = &Mip_Balance_Demo_M_;

/* Forward declaration for local functions */
static void Mip_Bala_SystemCore_release_l1y(const
  beagleboneblue_bbblueDCMotor__T *obj);
static void Mip_Balan_SystemCore_delete_l1y(const
  beagleboneblue_bbblueDCMotor__T *obj);
static void matlabCodegenHandle_matlabC_l1y(beagleboneblue_bbblueDCMotor__T *obj);
static void Mip_Balan_SystemCore_release_l1(const
  beagleboneblue_fccr_bbblueIMU_T *obj);
static void Mip_Balanc_SystemCore_delete_l1(const
  beagleboneblue_fccr_bbblueIMU_T *obj);
static void matlabCodegenHandle_matlabCo_l1(beagleboneblue_fccr_bbblueIMU_T *obj);
static void Mip_Balanc_SystemCore_release_l(const
  beagleboneblue_bbblueButton_M_T *obj);
static void Mip_Balance_SystemCore_delete_l(const
  beagleboneblue_bbblueButton_M_T *obj);
static void matlabCodegenHandle_matlabCod_l(beagleboneblue_bbblueButton_M_T *obj);
static void Mip_Balance__SystemCore_release(const
  beagleboneblue_bbblueLED_Mip__T *obj);
static void Mip_Balance_D_SystemCore_delete(const
  beagleboneblue_bbblueLED_Mip__T *obj);
static void matlabCodegenHandle_matlabCodeg(beagleboneblue_bbblueLED_Mip__T *obj);
static void rate_scheduler(void);
real_T sMultiWord2Double(const uint32_T u1[], int32_T n1, int32_T e1)
{
  real_T y;
  int32_T i;
  int32_T exp_0;
  uint32_T u1i;
  uint32_T cb;
  y = 0.0;
  exp_0 = e1;
  if ((u1[n1 - 1] & 2147483648U) != 0U) {
    cb = 1U;
    for (i = 0; i < n1; i++) {
      u1i = ~u1[i];
      cb += u1i;
      y -= ldexp(cb, exp_0);
      cb = (uint32_T)(cb < u1i);
      exp_0 += 32;
    }
  } else {
    for (i = 0; i < n1; i++) {
      y += ldexp(u1[i], exp_0);
      exp_0 += 32;
    }
  }

  return y;
}

void MultiWordAdd(const uint32_T u1[], const uint32_T u2[], uint32_T y[],
                  int32_T n)
{
  uint32_T yi;
  uint32_T u1i;
  uint32_T carry = 0U;
  int32_T i;
  for (i = 0; i < n; i++) {
    u1i = u1[i];
    yi = (u1i + u2[i]) + carry;
    y[i] = yi;
    carry = carry != 0U ? (uint32_T)(yi <= u1i) : (uint32_T)(yi < u1i);
  }
}

void sMultiWordShr(const uint32_T u1[], int32_T n1, uint32_T n2, uint32_T y[],
                   int32_T n)
{
  int32_T nb;
  int32_T i;
  uint32_T ys;
  uint32_T yi;
  uint32_T u1i;
  int32_T nc;
  uint32_T nr;
  uint32_T nl;
  int32_T i1;
  nb = (int32_T)(n2 >> 5);
  i = 0;
  ys = (u1[n1 - 1] & 2147483648U) != 0U ? MAX_uint32_T : 0U;
  if (nb < n1) {
    nc = n + nb;
    if (nc > n1) {
      nc = n1;
    }

    nr = n2 - ((uint32_T)nb << 5);
    if (nr > 0U) {
      nl = 32U - nr;
      u1i = u1[nb];
      for (i1 = nb + 1; i1 < nc; i1++) {
        yi = u1i >> nr;
        u1i = u1[i1];
        y[i] = u1i << nl | yi;
        i++;
      }

      yi = u1i >> nr;
      u1i = nc < n1 ? u1[nc] : ys;
      y[i] = u1i << nl | yi;
      i++;
    } else {
      for (i1 = nb; i1 < nc; i1++) {
        y[i] = u1[i1];
        i++;
      }
    }
  }

  while (i < n) {
    y[i] = ys;
    i++;
  }
}

void sMultiWordMul(const uint32_T u1[], int32_T n1, const uint32_T u2[], int32_T
                   n2, uint32_T y[], int32_T n)
{
  int32_T i;
  int32_T j;
  int32_T k;
  int32_T nj;
  uint32_T u1i;
  uint32_T yk;
  uint32_T a1;
  uint32_T a0;
  uint32_T b1;
  uint32_T w10;
  uint32_T w01;
  uint32_T cb;
  boolean_T isNegative1;
  boolean_T isNegative2;
  uint32_T cb1;
  uint32_T cb2;
  isNegative1 = ((u1[n1 - 1] & 2147483648U) != 0U);
  isNegative2 = ((u2[n2 - 1] & 2147483648U) != 0U);
  cb1 = 1U;

  /* Initialize output to zero */
  for (k = 0; k < n; k++) {
    y[k] = 0U;
  }

  for (i = 0; i < n1; i++) {
    cb = 0U;
    u1i = u1[i];
    if (isNegative1) {
      u1i = ~u1i + cb1;
      cb1 = (uint32_T)(u1i < cb1);
    }

    a1 = u1i >> 16U;
    a0 = u1i & 65535U;
    cb2 = 1U;
    k = n - i;
    nj = n2 <= k ? n2 : k;
    k = i;
    for (j = 0; j < nj; j++) {
      yk = y[k];
      u1i = u2[j];
      if (isNegative2) {
        u1i = ~u1i + cb2;
        cb2 = (uint32_T)(u1i < cb2);
      }

      b1 = u1i >> 16U;
      u1i &= 65535U;
      w10 = a1 * u1i;
      w01 = a0 * b1;
      yk += cb;
      cb = (uint32_T)(yk < cb);
      u1i *= a0;
      yk += u1i;
      cb += (yk < u1i);
      u1i = w10 << 16U;
      yk += u1i;
      cb += (yk < u1i);
      u1i = w01 << 16U;
      yk += u1i;
      cb += (yk < u1i);
      y[k] = yk;
      cb += w10 >> 16U;
      cb += w01 >> 16U;
      cb += a1 * b1;
      k++;
    }

    if (k < n) {
      y[k] = cb;
    }
  }

  /* Apply sign */
  if (isNegative1 != isNegative2) {
    cb = 1U;
    for (k = 0; k < n; k++) {
      yk = ~y[k] + cb;
      y[k] = yk;
      cb = (uint32_T)(yk < cb);
    }
  }
}

/*
 *   This function updates active task flag for each subrate.
 * The function is called at model base rate, hence the
 * generated code self-manages all its subrates.
 */
static void rate_scheduler(void)
{
  /* Compute which subrates run during the next base time step.  Subrates
   * are an integer multiple of the base rate counter.  Therefore, the subtask
   * counter is reset when it reaches its limit (zero means run).
   */
  (Mip_Balance_Demo_M->Timing.TaskCounters.TID[1])++;
  if ((Mip_Balance_Demo_M->Timing.TaskCounters.TID[1]) > 9) {/* Sample time: [0.1s, 0.0s] */
    Mip_Balance_Demo_M->Timing.TaskCounters.TID[1] = 0;
  }
}

real_T rt_atan2d_snf(real_T u0, real_T u1)
{
  real_T y;
  int32_T u0_0;
  int32_T u1_0;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = (rtNaN);
  } else if (rtIsInf(u0) && rtIsInf(u1)) {
    if (u0 > 0.0) {
      u0_0 = 1;
    } else {
      u0_0 = -1;
    }

    if (u1 > 0.0) {
      u1_0 = 1;
    } else {
      u1_0 = -1;
    }

    y = atan2(u0_0, u1_0);
  } else if (u1 == 0.0) {
    if (u0 > 0.0) {
      y = RT_PI / 2.0;
    } else if (u0 < 0.0) {
      y = -(RT_PI / 2.0);
    } else {
      y = 0.0;
    }
  } else {
    y = atan2(u0, u1);
  }

  return y;
}

static void Mip_Bala_SystemCore_release_l1y(const
  beagleboneblue_bbblueDCMotor__T *obj)
{
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    MW_terminate_motor(2);
  }
}

static void Mip_Balan_SystemCore_delete_l1y(const
  beagleboneblue_bbblueDCMotor__T *obj)
{
  Mip_Bala_SystemCore_release_l1y(obj);
}

static void matlabCodegenHandle_matlabC_l1y(beagleboneblue_bbblueDCMotor__T *obj)
{
  if (!obj->matlabCodegenIsDeleted) {
    obj->matlabCodegenIsDeleted = true;
    Mip_Balan_SystemCore_delete_l1y(obj);
  }
}

static void Mip_Balan_SystemCore_release_l1(const
  beagleboneblue_fccr_bbblueIMU_T *obj)
{
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    rc_mpu_power_off();
  }
}

static void Mip_Balanc_SystemCore_delete_l1(const
  beagleboneblue_fccr_bbblueIMU_T *obj)
{
  Mip_Balan_SystemCore_release_l1(obj);
}

static void matlabCodegenHandle_matlabCo_l1(beagleboneblue_fccr_bbblueIMU_T *obj)
{
  if (!obj->matlabCodegenIsDeleted) {
    obj->matlabCodegenIsDeleted = true;
    Mip_Balanc_SystemCore_delete_l1(obj);
  }
}

static void Mip_Balanc_SystemCore_release_l(const
  beagleboneblue_bbblueButton_M_T *obj)
{
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    rc_button_cleanup();
  }
}

static void Mip_Balance_SystemCore_delete_l(const
  beagleboneblue_bbblueButton_M_T *obj)
{
  Mip_Balanc_SystemCore_release_l(obj);
}

static void matlabCodegenHandle_matlabCod_l(beagleboneblue_bbblueButton_M_T *obj)
{
  if (!obj->matlabCodegenIsDeleted) {
    obj->matlabCodegenIsDeleted = true;
    Mip_Balance_SystemCore_delete_l(obj);
  }
}

static void Mip_Balance__SystemCore_release(const
  beagleboneblue_bbblueLED_Mip__T *obj)
{
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    rc_led_cleanup();
  }
}

static void Mip_Balance_D_SystemCore_delete(const
  beagleboneblue_bbblueLED_Mip__T *obj)
{
  Mip_Balance__SystemCore_release(obj);
}

static void matlabCodegenHandle_matlabCodeg(beagleboneblue_bbblueLED_Mip__T *obj)
{
  if (!obj->matlabCodegenIsDeleted) {
    obj->matlabCodegenIsDeleted = true;
    Mip_Balance_D_SystemCore_delete(obj);
  }
}

/* Model step function */
void Mip_Balance_Demo_step(void)
{
  uint8_T rtb_Button_0;
  int32_T rtb_ENCODER_CHANNEL_R_0;
  int32_T rtb_ENCODER_CHANNEL_L_0;
  boolean_T rtb_UnitDelay;
  boolean_T rtb_RelationalOperator1;
  boolean_T rtb_AND;
  real_T rtb_PulseGenerator;
  int64m_T tmp;
  int64m_T tmp_0;
  int64m_T tmp_1;
  uint32_T tmp_2;
  uint32_T tmp_3;
  int8_T rtb_MOTOR_POLARITY_R_0;
  boolean_T rtb_NOT_tmp;

  /* Reset subsysRan breadcrumbs */
  srClearBC(Mip_Balance_Demo_DW.Controller_SubsysRanBC);

  /* UnitDelay: '<S2>/Unit Delay' */
  rtb_UnitDelay = Mip_Balance_Demo_DW.UnitDelay_DSTATE;

  /* DiscreteIntegrator: '<S12>/Discrete-Time Integrator' incorporates:
   *  UnitDelay: '<S2>/Unit Delay'
   */
  if (Mip_Balance_Demo_DW.UnitDelay_DSTATE &&
      (Mip_Balance_Demo_DW.DiscreteTimeIntegrator_PrevRese <= 0)) {
    Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE =
      Mip_Balance_Demo_P.DiscreteTimeIntegrator_IC;
  }

  /* Product: '<S12>/Limits' incorporates:
   *  Constant: '<S12>/Soft Start Time1'
   *  DiscreteIntegrator: '<S12>/Discrete-Time Integrator'
   */
  Mip_Balance_Demo_B.WaitCounter =
    Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE /
    Mip_Balance_Demo_P.SoftStartTime1_Value;

  /* Saturate: '<S12>/Saturation' */
  if (Mip_Balance_Demo_B.WaitCounter > Mip_Balance_Demo_P.Saturation_UpperSat_g)
  {
    Mip_Balance_Demo_B.WaitCounter = Mip_Balance_Demo_P.Saturation_UpperSat_g;
  } else {
    if (Mip_Balance_Demo_B.WaitCounter <
        Mip_Balance_Demo_P.Saturation_LowerSat_e) {
      Mip_Balance_Demo_B.WaitCounter = Mip_Balance_Demo_P.Saturation_LowerSat_e;
    }
  }

  /* End of Saturate: '<S12>/Saturation' */

  /* Outputs for Atomic SubSystem: '<Root>/Balance System' */
  /* DiscreteTransferFcn: '<S9>/High Pass  ' incorporates:
   *  DiscreteIntegrator: '<S8>/Integrate Gyro'
   *  Gain: '<S8>/Gain2'
   */
  rtb_PulseGenerator = (Mip_Balance_Demo_P.Gain2_Gain *
                        Mip_Balance_Demo_DW.IntegrateGyro_DSTATE -
                        Mip_Balance_Demo_P.HighPass_DenCoef[1] *
                        Mip_Balance_Demo_DW.HighPass_states) /
    Mip_Balance_Demo_P.HighPass_DenCoef[0];

  /* Sum: '<S5>/Sum1' incorporates:
   *  Constant: '<S5>/Mount Angle'
   *  DiscreteTransferFcn: '<S9>/High Pass  '
   *  DiscreteTransferFcn: '<S9>/Low Pass '
   *  Sum: '<S9>/Sum'
   */
  Mip_Balance_Demo_B.Sum1 = ((Mip_Balance_Demo_P.HighPass_NumCoef[0] *
    rtb_PulseGenerator + Mip_Balance_Demo_P.HighPass_NumCoef[1] *
    Mip_Balance_Demo_DW.HighPass_states) + Mip_Balance_Demo_P.LowPass_NumCoef[1]
    * Mip_Balance_Demo_DW.LowPass_states) + Mip_Balance_Demo_P.MountAngle_Value;

  /* Logic: '<S5>/NOT' incorporates:
   *  DiscreteIntegrator: '<S14>/Wait Counter'
   *  UnitDelay: '<S2>/Unit Delay'
   */
  rtb_NOT_tmp = !Mip_Balance_Demo_DW.UnitDelay_DSTATE;

  /* MATLABSystem: '<S5>/ENCODER_CHANNEL_R' incorporates:
   *  Logic: '<S5>/NOT'
   */
  if (Mip_Balance_Demo_DW.obj_d.SampleTime !=
      Mip_Balance_Demo_P.ENCODER_CHANNEL_R_SampleTime) {
    Mip_Balance_Demo_DW.obj_d.SampleTime =
      Mip_Balance_Demo_P.ENCODER_CHANNEL_R_SampleTime;
  }

  rtb_ENCODER_CHANNEL_R_0 = getEncoderValue(2, 3, rtb_NOT_tmp);

  /* MATLABSystem: '<S5>/ENCODER_CHANNEL_L' incorporates:
   *  Logic: '<S5>/NOT'
   */
  if (Mip_Balance_Demo_DW.obj_a.SampleTime !=
      Mip_Balance_Demo_P.ENCODER_CHANNEL_L_SampleTime) {
    Mip_Balance_Demo_DW.obj_a.SampleTime =
      Mip_Balance_Demo_P.ENCODER_CHANNEL_L_SampleTime;
  }

  rtb_ENCODER_CHANNEL_L_0 = getEncoderValue(3, 3, rtb_NOT_tmp);

  /* Gain: '<S5>/ENCODER_POLARITY_R' incorporates:
   *  MATLABSystem: '<S5>/ENCODER_CHANNEL_R'
   */
  tmp_2 = (uint32_T)Mip_Balance_Demo_P.ENCODER_POLARITY_R_Gain;
  tmp_3 = (uint32_T)rtb_ENCODER_CHANNEL_R_0;
  sMultiWordMul(&tmp_2, 1, &tmp_3, 1, &tmp_1.chunks[0U], 2);

  /* Sum: '<S5>/Sum3' */
  sMultiWordShr(&tmp_1.chunks[0U], 2, 1U, &tmp_0.chunks[0U], 2);

  /* Gain: '<S5>/ENCODER_POLARITY_L' incorporates:
   *  MATLABSystem: '<S5>/ENCODER_CHANNEL_L'
   */
  tmp_2 = (uint32_T)Mip_Balance_Demo_P.ENCODER_POLARITY_L_Gain;
  tmp_3 = (uint32_T)rtb_ENCODER_CHANNEL_L_0;
  sMultiWordMul(&tmp_2, 1, &tmp_3, 1, &tmp_1.chunks[0U], 2);

  /* Sum: '<S5>/Sum3' */
  MultiWordAdd(&tmp_0.chunks[0U], &tmp_1.chunks[0U], &tmp.chunks[0U], 2);

  /* Gain: '<S5>/Gain3' */
  Mip_Balance_Demo_B.MOTOR_POLARITY_R = sMultiWord2Double
    (&Mip_Balance_Demo_P.Gain3_Gain.chunks[0U], 2, 0) * 1.0842021724855044E-19 *
    (sMultiWord2Double(&tmp.chunks[0U], 2, 0) * 9.3132257461547852E-10);

  /* Sum: '<S5>/Sum2' incorporates:
   *  Gain: '<S5>/Gain4'
   *  Gain: '<S5>/Gain5'
   *  Gain: '<S5>/Gain6'
   */
  Mip_Balance_Demo_B.phirad = Mip_Balance_Demo_P.Gain4_Gain *
    Mip_Balance_Demo_B.MOTOR_POLARITY_R * Mip_Balance_Demo_P.Gain5_Gain *
    Mip_Balance_Demo_P.Gain6_Gain + Mip_Balance_Demo_B.Sum1;

  /* Constant: '<S1>/Phi Ref' */
  Mip_Balance_Demo_B.PhiRef = Mip_Balance_Demo_P.PhiRef_Value;

  /* Outputs for Enabled SubSystem: '<S1>/Controller' incorporates:
   *  EnablePort: '<S4>/Enable'
   */
  /* UnitDelay: '<S2>/Unit Delay' */
  if (Mip_Balance_Demo_DW.UnitDelay_DSTATE) {
    if (!Mip_Balance_Demo_DW.Controller_MODE) {
      /* InitializeConditions for DiscreteIntegrator: '<S4>/Integrator for  position keeping' */
      Mip_Balance_Demo_DW.Integratorforpositionkeeping_DS =
        Mip_Balance_Demo_P.Integratorforpositionkeeping_IC;

      /* InitializeConditions for DiscreteTransferFcn: '<S4>/D2 100 hz Slow Loop Controller1' */
      Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[0] =
        Mip_Balance_Demo_P.D2100hzSlowLoopController1_Init;

      /* InitializeConditions for DiscreteTransferFcn: '<S4>/D1 100hz Fast Loop Controller' */
      Mip_Balance_Demo_DW.D1100hzFastLoopController_state[0] =
        Mip_Balance_Demo_P.D1100hzFastLoopController_Initi;

      /* InitializeConditions for DiscreteTransferFcn: '<S4>/D2 100 hz Slow Loop Controller1' */
      Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[1] =
        Mip_Balance_Demo_P.D2100hzSlowLoopController1_Init;

      /* InitializeConditions for DiscreteTransferFcn: '<S4>/D1 100hz Fast Loop Controller' */
      Mip_Balance_Demo_DW.D1100hzFastLoopController_state[1] =
        Mip_Balance_Demo_P.D1100hzFastLoopController_Initi;
      Mip_Balance_Demo_DW.Controller_MODE = true;
    }

    /* Sum: '<S4>/Sum1' */
    Mip_Balance_Demo_B.MOTOR_POLARITY_R = Mip_Balance_Demo_B.PhiRef -
      Mip_Balance_Demo_B.phirad;

    /* DiscreteTransferFcn: '<S4>/D2 100 hz Slow Loop Controller1' incorporates:
     *  Gain: '<S4>/D2_GAIN'
     */
    Mip_Balance_Demo_B.denAccum = ((Mip_Balance_Demo_P.D2_GAIN_Gain *
      Mip_Balance_Demo_B.MOTOR_POLARITY_R -
      Mip_Balance_Demo_P.D2100hzSlowLoopController1_DenC[1] *
      Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[0]) -
      Mip_Balance_Demo_P.D2100hzSlowLoopController1_DenC[2] *
      Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[1]) /
      Mip_Balance_Demo_P.D2100hzSlowLoopController1_DenC[0];

    /* Sum: '<S4>/Sum2' incorporates:
     *  DiscreteIntegrator: '<S4>/Integrator for  position keeping'
     *  DiscreteTransferFcn: '<S4>/D2 100 hz Slow Loop Controller1'
     */
    Mip_Balance_Demo_B.Sum2 =
      ((Mip_Balance_Demo_P.D2100hzSlowLoopController1_NumC[0] *
        Mip_Balance_Demo_B.denAccum +
        Mip_Balance_Demo_P.D2100hzSlowLoopController1_NumC[1] *
        Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[0]) +
       Mip_Balance_Demo_P.D2100hzSlowLoopController1_NumC[2] *
       Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[1]) +
      Mip_Balance_Demo_DW.Integratorforpositionkeeping_DS;

    /* DiscreteTransferFcn: '<S4>/D1 100hz Fast Loop Controller' incorporates:
     *  Gain: '<S4>/D1_GAIN'
     *  Sum: '<S4>/Sum'
     */
    Mip_Balance_Demo_B.denAccum_m = (((Mip_Balance_Demo_B.Sum2 -
      Mip_Balance_Demo_B.Sum1) * Mip_Balance_Demo_P.D1_GAIN_Gain -
      Mip_Balance_Demo_P.D1100hzFastLoopController_DenCo[1] *
      Mip_Balance_Demo_DW.D1100hzFastLoopController_state[0]) -
      Mip_Balance_Demo_P.D1100hzFastLoopController_DenCo[2] *
      Mip_Balance_Demo_DW.D1100hzFastLoopController_state[1]) /
      Mip_Balance_Demo_P.D1100hzFastLoopController_DenCo[0];
    Mip_Balance_Demo_B.D1100hzFastLoopController =
      (Mip_Balance_Demo_P.D1100hzFastLoopController_NumCo[0] *
       Mip_Balance_Demo_B.denAccum_m +
       Mip_Balance_Demo_P.D1100hzFastLoopController_NumCo[1] *
       Mip_Balance_Demo_DW.D1100hzFastLoopController_state[0]) +
      Mip_Balance_Demo_P.D1100hzFastLoopController_NumCo[2] *
      Mip_Balance_Demo_DW.D1100hzFastLoopController_state[1];

    /* Update for DiscreteTransferFcn: '<S4>/D2 100 hz Slow Loop Controller1' */
    Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[1] =
      Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[0];
    Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[0] =
      Mip_Balance_Demo_B.denAccum;

    /* Update for DiscreteIntegrator: '<S4>/Integrator for  position keeping' */
    Mip_Balance_Demo_DW.Integratorforpositionkeeping_DS +=
      Mip_Balance_Demo_P.Integratorforpositionkeeping_ga *
      Mip_Balance_Demo_B.MOTOR_POLARITY_R;

    /* Update for DiscreteTransferFcn: '<S4>/D1 100hz Fast Loop Controller' */
    Mip_Balance_Demo_DW.D1100hzFastLoopController_state[1] =
      Mip_Balance_Demo_DW.D1100hzFastLoopController_state[0];
    Mip_Balance_Demo_DW.D1100hzFastLoopController_state[0] =
      Mip_Balance_Demo_B.denAccum_m;
    srUpdateBC(Mip_Balance_Demo_DW.Controller_SubsysRanBC);
  } else {
    if (Mip_Balance_Demo_DW.Controller_MODE) {
      Mip_Balance_Demo_DW.Controller_MODE = false;
    }
  }

  /* End of Outputs for SubSystem: '<S1>/Controller' */

  /* Product: '<S1>/Multiply' incorporates:
   *  UnitDelay: '<S2>/Unit Delay'
   */
  Mip_Balance_Demo_B.Multiply = (real_T)Mip_Balance_Demo_DW.UnitDelay_DSTATE *
    Mip_Balance_Demo_B.D1100hzFastLoopController;

  /* Saturate: '<S3>/Saturation' */
  if (Mip_Balance_Demo_B.Multiply > Mip_Balance_Demo_P.Saturation_UpperSat) {
    Mip_Balance_Demo_B.Saturation = Mip_Balance_Demo_P.Saturation_UpperSat;
  } else if (Mip_Balance_Demo_B.Multiply <
             Mip_Balance_Demo_P.Saturation_LowerSat) {
    Mip_Balance_Demo_B.Saturation = Mip_Balance_Demo_P.Saturation_LowerSat;
  } else {
    Mip_Balance_Demo_B.Saturation = Mip_Balance_Demo_B.Multiply;
  }

  /* End of Saturate: '<S3>/Saturation' */

  /* Logic: '<S3>/AND' incorporates:
   *  Constant: '<S6>/Constant'
   *  Constant: '<S7>/Constant'
   *  RelationalOperator: '<S6>/Compare'
   *  RelationalOperator: '<S7>/Compare'
   *  Sum: '<S3>/Minus'
   */
  rtb_AND = ((Mip_Balance_Demo_B.Saturation - Mip_Balance_Demo_B.Multiply !=
              Mip_Balance_Demo_P.Constant_Value) &&
             (Mip_Balance_Demo_B.WaitCounter ==
              Mip_Balance_Demo_P.CompareToConstant_const));

  /* Product: '<S3>/Multiply' */
  Mip_Balance_Demo_B.Multiply_n = Mip_Balance_Demo_B.WaitCounter *
    Mip_Balance_Demo_B.Saturation;

  /* Gain: '<S5>/Gain' */
  Mip_Balance_Demo_B.MOTOR_POLARITY_R = Mip_Balance_Demo_P.Gain_Gain *
    Mip_Balance_Demo_B.Multiply_n;

  /* DataTypeConversion: '<S5>/Data Type Conversion1' incorporates:
   *  Gain: '<S5>/MOTOR_POLARITY_L'
   */
  Mip_Balance_Demo_B.WaitCounter = Mip_Balance_Demo_P.MOTOR_POLARITY_L_Gain *
    Mip_Balance_Demo_B.MOTOR_POLARITY_R;
  if (Mip_Balance_Demo_B.WaitCounter < 128.0) {
    if (Mip_Balance_Demo_B.WaitCounter >= -128.0) {
      rtb_MOTOR_POLARITY_R_0 = (int8_T)Mip_Balance_Demo_B.WaitCounter;
    } else {
      rtb_MOTOR_POLARITY_R_0 = MIN_int8_T;
    }
  } else {
    rtb_MOTOR_POLARITY_R_0 = MAX_int8_T;
  }

  /* End of DataTypeConversion: '<S5>/Data Type Conversion1' */

  /* MATLABSystem: '<S5>/MOTOR_CHANNEL_L' */
  MW_set_motor(3, rtb_MOTOR_POLARITY_R_0, 2);

  /* Gain: '<S5>/MOTOR_POLARITY_R' */
  Mip_Balance_Demo_B.MOTOR_POLARITY_R *=
    Mip_Balance_Demo_P.MOTOR_POLARITY_R_Gain;

  /* DataTypeConversion: '<S5>/Data Type Conversion' */
  if (Mip_Balance_Demo_B.MOTOR_POLARITY_R < 128.0) {
    if (Mip_Balance_Demo_B.MOTOR_POLARITY_R >= -128.0) {
      rtb_MOTOR_POLARITY_R_0 = (int8_T)Mip_Balance_Demo_B.MOTOR_POLARITY_R;
    } else {
      rtb_MOTOR_POLARITY_R_0 = MIN_int8_T;
    }
  } else {
    rtb_MOTOR_POLARITY_R_0 = MAX_int8_T;
  }

  /* End of DataTypeConversion: '<S5>/Data Type Conversion' */

  /* MATLABSystem: '<S5>/MOTOR_CHANNEL_R' */
  MW_set_motor(2, rtb_MOTOR_POLARITY_R_0, 2);

  /* MATLABSystem: '<S5>/MATLAB System1' */
  if (Mip_Balance_Demo_DW.obj_l.SampleTime !=
      Mip_Balance_Demo_P.MATLABSystem1_SampleTime) {
    Mip_Balance_Demo_DW.obj_l.SampleTime =
      Mip_Balance_Demo_P.MATLABSystem1_SampleTime;
  }

  fccr_read_accel_x();
  Mip_Balance_Demo_B.WaitCounter = fccr_read_accel_y();
  Mip_Balance_Demo_B.MOTOR_POLARITY_R = fccr_read_accel_z();
  Mip_Balance_Demo_B.denAccum = fccr_read_gyro_x();
  fccr_read_gyro_y();
  fccr_read_gyro_z();

  /* Update for DiscreteTransferFcn: '<S9>/Low Pass ' incorporates:
   *  Gain: '<S8>/Gain1'
   *  MATLABSystem: '<S5>/MATLAB System1'
   *  Trigonometry: '<S8>/Trigonometric Function1'
   */
  Mip_Balance_Demo_DW.LowPass_states = (Mip_Balance_Demo_P.Gain1_Gain_o *
    rt_atan2d_snf(Mip_Balance_Demo_B.MOTOR_POLARITY_R,
                  Mip_Balance_Demo_B.WaitCounter) -
    Mip_Balance_Demo_P.LowPass_DenCoef[1] * Mip_Balance_Demo_DW.LowPass_states) /
    Mip_Balance_Demo_P.LowPass_DenCoef[0];

  /* Update for DiscreteIntegrator: '<S8>/Integrate Gyro' incorporates:
   *  Gain: '<S10>/Gain1'
   *  MATLABSystem: '<S5>/MATLAB System1'
   */
  Mip_Balance_Demo_DW.IntegrateGyro_DSTATE += Mip_Balance_Demo_P.Gain1_Gain *
    Mip_Balance_Demo_B.denAccum * Mip_Balance_Demo_P.IntegrateGyro_gainval;

  /* Update for DiscreteTransferFcn: '<S9>/High Pass  ' */
  Mip_Balance_Demo_DW.HighPass_states = rtb_PulseGenerator;

  /* End of Outputs for SubSystem: '<Root>/Balance System' */

  /* DiscreteIntegrator: '<S11>/Discrete-Time Integrator' */
  if ((!rtb_AND) && (Mip_Balance_Demo_DW.DiscreteTimeIntegrator_PrevRe_e == 1))
  {
    Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE_n =
      Mip_Balance_Demo_P.DiscreteTimeIntegrator_IC_l;
  }

  /* RelationalOperator: '<S13>/Relational Operator1' incorporates:
   *  Abs: '<S13>/Abs'
   *  Constant: '<S13>/Start Angle'
   */
  rtb_RelationalOperator1 = (fabs(Mip_Balance_Demo_B.Sum1) <
    Mip_Balance_Demo_P.StartAngle_Value);

  /* DiscreteIntegrator: '<S13>/Start Counter' */
  if ((!rtb_RelationalOperator1) &&
      (Mip_Balance_Demo_DW.StartCounter_PrevResetState == 1)) {
    Mip_Balance_Demo_DW.StartCounter_DSTATE = Mip_Balance_Demo_P.StartCounter_IC;
  }

  /* DiscreteIntegrator: '<S14>/Wait Counter' */
  if (rtb_NOT_tmp && (Mip_Balance_Demo_DW.WaitCounter_PrevResetState == 1)) {
    Mip_Balance_Demo_DW.WaitCounter_DSTATE = Mip_Balance_Demo_P.WaitCounter_IC;
  }

  /* Logic: '<S2>/Logical Operator' incorporates:
   *  Constant: '<S11>/Sat Timeout'
   *  Constant: '<S13>/Start Timeout'
   *  Constant: '<S14>/Wait to Start'
   *  DiscreteIntegrator: '<S11>/Discrete-Time Integrator'
   *  DiscreteIntegrator: '<S13>/Start Counter'
   *  DiscreteIntegrator: '<S14>/Wait Counter'
   *  RelationalOperator: '<S11>/Relational Operator'
   *  RelationalOperator: '<S13>/Relational Operator'
   *  RelationalOperator: '<S14>/Relational Operator'
   *  UnitDelay: '<S2>/Unit Delay'
   */
  Mip_Balance_Demo_DW.UnitDelay_DSTATE = (((real_T)
    Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE_n * 0.01 <
    Mip_Balance_Demo_P.SatTimeout_Value) && ((real_T)
    Mip_Balance_Demo_DW.StartCounter_DSTATE * 0.01 >=
    Mip_Balance_Demo_P.StartTimeout_Value) &&
    (Mip_Balance_Demo_DW.WaitCounter_DSTATE >=
     Mip_Balance_Demo_P.WaittoStart_Value));
  if (Mip_Balance_Demo_M->Timing.TaskCounters.TID[1] == 0) {
    /* MATLABSystem: '<Root>/Button' */
    if (Mip_Balance_Demo_DW.obj_h.SampleTime !=
        Mip_Balance_Demo_P.Button_SampleTime) {
      Mip_Balance_Demo_DW.obj_h.SampleTime =
        Mip_Balance_Demo_P.Button_SampleTime;
    }

    rtb_Button_0 = rc_button_get_state(2.0, 5.0);

    /* Stop: '<Root>/Stop Simulation' incorporates:
     *  DataTypeConversion: '<Root>/Data Type Conversion'
     *  MATLABSystem: '<Root>/Button'
     */
    if (rtb_Button_0 != 0) {
      rtmSetStopRequested(Mip_Balance_Demo_M, 1);
    }

    /* End of Stop: '<Root>/Stop Simulation' */

    /* DiscretePulseGenerator: '<Root>/Pulse Generator' */
    rtb_PulseGenerator = (Mip_Balance_Demo_DW.clockTickCounter <
                          Mip_Balance_Demo_P.PulseGenerator_Duty) &&
      (Mip_Balance_Demo_DW.clockTickCounter >= 0) ?
      Mip_Balance_Demo_P.PulseGenerator_Amp : 0.0;
    if (Mip_Balance_Demo_DW.clockTickCounter >=
        Mip_Balance_Demo_P.PulseGenerator_Period - 1.0) {
      Mip_Balance_Demo_DW.clockTickCounter = 0;
    } else {
      Mip_Balance_Demo_DW.clockTickCounter++;
    }

    /* End of DiscretePulseGenerator: '<Root>/Pulse Generator' */

    /* DataTypeConversion: '<Root>/Convert to Logical' */
    Mip_Balance_Demo_B.WaitCounter = floor(rtb_PulseGenerator);
    if (rtIsNaN(Mip_Balance_Demo_B.WaitCounter) || rtIsInf
        (Mip_Balance_Demo_B.WaitCounter)) {
      Mip_Balance_Demo_B.WaitCounter = 0.0;
    } else {
      Mip_Balance_Demo_B.WaitCounter = fmod(Mip_Balance_Demo_B.WaitCounter,
        256.0);
    }

    /* MATLABSystem: '<Root>/LED' incorporates:
     *  DataTypeConversion: '<Root>/Convert to Logical'
     */
    rc_led_set(0, (uint8_T)(Mip_Balance_Demo_B.WaitCounter < 0.0 ? (int32_T)
                (uint8_T)-(int8_T)(uint8_T)-Mip_Balance_Demo_B.WaitCounter :
                (int32_T)(uint8_T)Mip_Balance_Demo_B.WaitCounter));
  }

  /* Update for DiscreteIntegrator: '<S12>/Discrete-Time Integrator' incorporates:
   *  DataTypeConversion: '<S12>/Data Type Conversion'
   */
  Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE +=
    Mip_Balance_Demo_P.DiscreteTimeIntegrator_gainval * (real_T)rtb_UnitDelay;
  Mip_Balance_Demo_DW.DiscreteTimeIntegrator_PrevRese = (int8_T)rtb_UnitDelay;

  /* Update for DiscreteIntegrator: '<S11>/Discrete-Time Integrator' */
  Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE_n = (uint8_T)((uint32_T)
    Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE_n + rtb_AND);
  Mip_Balance_Demo_DW.DiscreteTimeIntegrator_PrevRe_e = (int8_T)rtb_AND;

  /* Update for DiscreteIntegrator: '<S13>/Start Counter' */
  rtb_ENCODER_CHANNEL_R_0 = (int32_T)((uint32_T)
    Mip_Balance_Demo_DW.StartCounter_DSTATE + rtb_RelationalOperator1);
  if ((uint32_T)rtb_ENCODER_CHANNEL_R_0 > 255U) {
    rtb_ENCODER_CHANNEL_R_0 = 255;
  }

  Mip_Balance_Demo_DW.StartCounter_DSTATE = (uint8_T)rtb_ENCODER_CHANNEL_R_0;
  Mip_Balance_Demo_DW.StartCounter_PrevResetState = (int8_T)
    rtb_RelationalOperator1;

  /* End of Update for DiscreteIntegrator: '<S13>/Start Counter' */

  /* Update for DiscreteIntegrator: '<S14>/Wait Counter' incorporates:
   *  Constant: '<S14>/Constant'
   */
  Mip_Balance_Demo_DW.WaitCounter_DSTATE +=
    Mip_Balance_Demo_P.WaitCounter_gainval * Mip_Balance_Demo_P.Constant_Value_j;
  Mip_Balance_Demo_DW.WaitCounter_PrevResetState = (int8_T)rtb_UnitDelay;

  /* External mode */
  rtExtModeUploadCheckTrigger(2);

  {                                    /* Sample time: [0.01s, 0.0s] */
    rtExtModeUpload(0, (real_T)Mip_Balance_Demo_M->Timing.taskTime0);
  }

  if (Mip_Balance_Demo_M->Timing.TaskCounters.TID[1] == 0) {/* Sample time: [0.1s, 0.0s] */
    rtExtModeUpload(1, (real_T)((Mip_Balance_Demo_M->Timing.clockTick1) * 0.1));
  }

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.01s, 0.0s] */
    if ((rtmGetTFinal(Mip_Balance_Demo_M)!=-1) &&
        !((rtmGetTFinal(Mip_Balance_Demo_M)-Mip_Balance_Demo_M->Timing.taskTime0)
          > Mip_Balance_Demo_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(Mip_Balance_Demo_M, "Simulation finished");
    }

    if (rtmGetStopRequested(Mip_Balance_Demo_M)) {
      rtmSetErrorStatus(Mip_Balance_Demo_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   */
  Mip_Balance_Demo_M->Timing.taskTime0 =
    (++Mip_Balance_Demo_M->Timing.clockTick0) *
    Mip_Balance_Demo_M->Timing.stepSize0;
  if (Mip_Balance_Demo_M->Timing.TaskCounters.TID[1] == 0) {
    /* Update absolute timer for sample time: [0.1s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The resolution of this integer timer is 0.1, which is the step size
     * of the task. Size of "clockTick1" ensures timer will not overflow during the
     * application lifespan selected.
     */
    Mip_Balance_Demo_M->Timing.clockTick1++;
  }

  rate_scheduler();
}

/* Model initialize function */
void Mip_Balance_Demo_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)Mip_Balance_Demo_M, 0,
                sizeof(RT_MODEL_Mip_Balance_Demo_T));
  rtmSetTFinal(Mip_Balance_Demo_M, -1);
  Mip_Balance_Demo_M->Timing.stepSize0 = 0.01;

  /* External mode info */
  Mip_Balance_Demo_M->Sizes.checksums[0] = (2732354761U);
  Mip_Balance_Demo_M->Sizes.checksums[1] = (1980011944U);
  Mip_Balance_Demo_M->Sizes.checksums[2] = (425621873U);
  Mip_Balance_Demo_M->Sizes.checksums[3] = (3481865081U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[10];
    Mip_Balance_Demo_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    systemRan[3] = (sysRanDType *)&Mip_Balance_Demo_DW.Controller_SubsysRanBC;
    systemRan[4] = &rtAlwaysEnabled;
    systemRan[5] = &rtAlwaysEnabled;
    systemRan[6] = &rtAlwaysEnabled;
    systemRan[7] = &rtAlwaysEnabled;
    systemRan[8] = &rtAlwaysEnabled;
    systemRan[9] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(Mip_Balance_Demo_M->extModeInfo,
      &Mip_Balance_Demo_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(Mip_Balance_Demo_M->extModeInfo,
                        Mip_Balance_Demo_M->Sizes.checksums);
    rteiSetTPtr(Mip_Balance_Demo_M->extModeInfo, rtmGetTPtr(Mip_Balance_Demo_M));
  }

  /* block I/O */
  (void) memset(((void *) &Mip_Balance_Demo_B), 0,
                sizeof(B_Mip_Balance_Demo_T));

  /* states (dwork) */
  (void) memset((void *)&Mip_Balance_Demo_DW, 0,
                sizeof(DW_Mip_Balance_Demo_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    Mip_Balance_Demo_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 40;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Start for Atomic SubSystem: '<Root>/Balance System' */
  /* Start for MATLABSystem: '<S5>/ENCODER_CHANNEL_R' */
  Mip_Balance_Demo_DW.obj_d.isInitialized = 0;
  Mip_Balance_Demo_DW.obj_d.SampleTime =
    Mip_Balance_Demo_P.ENCODER_CHANNEL_R_SampleTime;
  Mip_Balance_Demo_DW.obj_d.isInitialized = 1;

  /* Start for MATLABSystem: '<S5>/ENCODER_CHANNEL_L' */
  Mip_Balance_Demo_DW.obj_a.isInitialized = 0;
  Mip_Balance_Demo_DW.obj_a.SampleTime =
    Mip_Balance_Demo_P.ENCODER_CHANNEL_L_SampleTime;
  Mip_Balance_Demo_DW.obj_a.isInitialized = 1;

  /* Start for MATLABSystem: '<S5>/MOTOR_CHANNEL_L' */
  Mip_Balance_Demo_DW.obj.matlabCodegenIsDeleted = true;
  Mip_Balance_Demo_DW.obj.isInitialized = 0;
  Mip_Balance_Demo_DW.obj.matlabCodegenIsDeleted = false;
  Mip_Balance_Demo_DW.obj.isSetupComplete = false;
  Mip_Balance_Demo_DW.obj.isInitialized = 1;
  Mip_Balance_Demo_DW.obj.isSetupComplete = true;

  /* Start for MATLABSystem: '<S5>/MOTOR_CHANNEL_R' */
  Mip_Balance_Demo_DW.obj_f.matlabCodegenIsDeleted = true;
  Mip_Balance_Demo_DW.obj_f.isInitialized = 0;
  Mip_Balance_Demo_DW.obj_f.matlabCodegenIsDeleted = false;
  Mip_Balance_Demo_DW.obj_f.isSetupComplete = false;
  Mip_Balance_Demo_DW.obj_f.isInitialized = 1;
  Mip_Balance_Demo_DW.obj_f.isSetupComplete = true;

  /* Start for MATLABSystem: '<S5>/MATLAB System1' */
  Mip_Balance_Demo_DW.obj_l.matlabCodegenIsDeleted = true;
  Mip_Balance_Demo_DW.obj_l.isInitialized = 0;
  Mip_Balance_Demo_DW.obj_l.matlabCodegenIsDeleted = false;
  Mip_Balance_Demo_DW.obj_l.SampleTime =
    Mip_Balance_Demo_P.MATLABSystem1_SampleTime;
  Mip_Balance_Demo_DW.obj_l.isSetupComplete = false;
  Mip_Balance_Demo_DW.obj_l.isInitialized = 1;
  fccr_initialize_imu();
  Mip_Balance_Demo_DW.obj_l.isSetupComplete = true;

  /* End of Start for SubSystem: '<Root>/Balance System' */

  /* Start for MATLABSystem: '<Root>/Button' */
  Mip_Balance_Demo_DW.obj_h.matlabCodegenIsDeleted = true;
  Mip_Balance_Demo_DW.obj_h.isInitialized = 0;
  Mip_Balance_Demo_DW.obj_h.matlabCodegenIsDeleted = false;
  Mip_Balance_Demo_DW.obj_h.SampleTime = Mip_Balance_Demo_P.Button_SampleTime;
  Mip_Balance_Demo_DW.obj_h.isSetupComplete = false;
  Mip_Balance_Demo_DW.obj_h.isInitialized = 1;
  rc_button_init(2.0, 5.0, 1.0, 2000.0);
  Mip_Balance_Demo_DW.obj_h.isSetupComplete = true;

  /* Start for MATLABSystem: '<Root>/LED' */
  Mip_Balance_Demo_DW.obj_lf.matlabCodegenIsDeleted = true;
  Mip_Balance_Demo_DW.obj_lf.isInitialized = 0;
  Mip_Balance_Demo_DW.obj_lf.matlabCodegenIsDeleted = false;
  Mip_Balance_Demo_DW.obj_lf.isSetupComplete = false;
  Mip_Balance_Demo_DW.obj_lf.isInitialized = 1;
  Mip_Balance_Demo_DW.obj_lf.isSetupComplete = true;

  /* InitializeConditions for UnitDelay: '<S2>/Unit Delay' */
  Mip_Balance_Demo_DW.UnitDelay_DSTATE =
    Mip_Balance_Demo_P.UnitDelay_InitialCondition;

  /* InitializeConditions for DiscreteIntegrator: '<S12>/Discrete-Time Integrator' */
  Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE =
    Mip_Balance_Demo_P.DiscreteTimeIntegrator_IC;
  Mip_Balance_Demo_DW.DiscreteTimeIntegrator_PrevRese = 2;

  /* InitializeConditions for DiscreteIntegrator: '<S11>/Discrete-Time Integrator' */
  Mip_Balance_Demo_DW.DiscreteTimeIntegrator_DSTATE_n =
    Mip_Balance_Demo_P.DiscreteTimeIntegrator_IC_l;
  Mip_Balance_Demo_DW.DiscreteTimeIntegrator_PrevRe_e = 2;

  /* InitializeConditions for DiscreteIntegrator: '<S13>/Start Counter' */
  Mip_Balance_Demo_DW.StartCounter_DSTATE = Mip_Balance_Demo_P.StartCounter_IC;
  Mip_Balance_Demo_DW.StartCounter_PrevResetState = 2;

  /* InitializeConditions for DiscreteIntegrator: '<S14>/Wait Counter' */
  Mip_Balance_Demo_DW.WaitCounter_DSTATE = Mip_Balance_Demo_P.WaitCounter_IC;
  Mip_Balance_Demo_DW.WaitCounter_PrevResetState = 2;

  /* InitializeConditions for DiscretePulseGenerator: '<Root>/Pulse Generator' */
  Mip_Balance_Demo_DW.clockTickCounter = 0;

  /* SystemInitialize for Atomic SubSystem: '<Root>/Balance System' */
  /* InitializeConditions for DiscreteTransferFcn: '<S9>/Low Pass ' */
  Mip_Balance_Demo_DW.LowPass_states = Mip_Balance_Demo_P.LowPass_InitialStates;

  /* InitializeConditions for DiscreteIntegrator: '<S8>/Integrate Gyro' */
  Mip_Balance_Demo_DW.IntegrateGyro_DSTATE = Mip_Balance_Demo_P.IntegrateGyro_IC;

  /* InitializeConditions for DiscreteTransferFcn: '<S9>/High Pass  ' */
  Mip_Balance_Demo_DW.HighPass_states =
    Mip_Balance_Demo_P.HighPass_InitialStates;

  /* SystemInitialize for Enabled SubSystem: '<S1>/Controller' */
  /* InitializeConditions for DiscreteIntegrator: '<S4>/Integrator for  position keeping' */
  Mip_Balance_Demo_DW.Integratorforpositionkeeping_DS =
    Mip_Balance_Demo_P.Integratorforpositionkeeping_IC;

  /* InitializeConditions for DiscreteTransferFcn: '<S4>/D2 100 hz Slow Loop Controller1' */
  Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[0] =
    Mip_Balance_Demo_P.D2100hzSlowLoopController1_Init;

  /* InitializeConditions for DiscreteTransferFcn: '<S4>/D1 100hz Fast Loop Controller' */
  Mip_Balance_Demo_DW.D1100hzFastLoopController_state[0] =
    Mip_Balance_Demo_P.D1100hzFastLoopController_Initi;

  /* InitializeConditions for DiscreteTransferFcn: '<S4>/D2 100 hz Slow Loop Controller1' */
  Mip_Balance_Demo_DW.D2100hzSlowLoopController1_stat[1] =
    Mip_Balance_Demo_P.D2100hzSlowLoopController1_Init;

  /* InitializeConditions for DiscreteTransferFcn: '<S4>/D1 100hz Fast Loop Controller' */
  Mip_Balance_Demo_DW.D1100hzFastLoopController_state[1] =
    Mip_Balance_Demo_P.D1100hzFastLoopController_Initi;

  /* SystemInitialize for Outport: '<S4>/U' */
  Mip_Balance_Demo_B.D1100hzFastLoopController = Mip_Balance_Demo_P.U_Y0;

  /* End of SystemInitialize for SubSystem: '<S1>/Controller' */
  /* End of SystemInitialize for SubSystem: '<Root>/Balance System' */
}

/* Model terminate function */
void Mip_Balance_Demo_terminate(void)
{
  /* Terminate for Atomic SubSystem: '<Root>/Balance System' */
  /* Terminate for MATLABSystem: '<S5>/MOTOR_CHANNEL_L' */
  matlabCodegenHandle_matlabC_l1y(&Mip_Balance_Demo_DW.obj);

  /* Terminate for MATLABSystem: '<S5>/MOTOR_CHANNEL_R' */
  matlabCodegenHandle_matlabC_l1y(&Mip_Balance_Demo_DW.obj_f);

  /* Terminate for MATLABSystem: '<S5>/MATLAB System1' */
  matlabCodegenHandle_matlabCo_l1(&Mip_Balance_Demo_DW.obj_l);

  /* End of Terminate for SubSystem: '<Root>/Balance System' */

  /* Terminate for MATLABSystem: '<Root>/Button' */
  matlabCodegenHandle_matlabCod_l(&Mip_Balance_Demo_DW.obj_h);

  /* Terminate for MATLABSystem: '<Root>/LED' */
  matlabCodegenHandle_matlabCodeg(&Mip_Balance_Demo_DW.obj_lf);
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
