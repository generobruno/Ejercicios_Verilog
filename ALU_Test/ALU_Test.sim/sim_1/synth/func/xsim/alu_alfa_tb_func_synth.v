// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1.1 (lin64) Build 3900603 Fri Jun 16 19:30:25 MDT 2023
// Date        : Wed Sep 20 17:56:02 2023
// Host        : BrunoLaptop running 64-bit Ubuntu 22.04.3 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/bruno/Documents/Facultad/5to_anio/Arquitectura_de_Computadoras/Ejercicios_Verilog/ALU_Test/ALU_Test.sim/sim_1/synth/func/xsim/alu_alfa_tb_func_synth.v
// Design      : alu_top
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module alu
   (o_overflow_Flag_OBUF,
    o_zero_Flag_OBUF,
    \o_alu_Result_reg[1]_0 ,
    Q,
    SR,
    o_overflow_Flag_reg_0,
    o_overflow_Flag,
    i_clock_IBUF_BUFG,
    o_zero_Flag_reg_0,
    o_zero_Flag,
    o_zero_Flag_reg_1,
    D);
  output o_overflow_Flag_OBUF;
  output o_zero_Flag_OBUF;
  output \o_alu_Result_reg[1]_0 ;
  output [4:0]Q;
  input [0:0]SR;
  input o_overflow_Flag_reg_0;
  input o_overflow_Flag;
  input i_clock_IBUF_BUFG;
  input o_zero_Flag_reg_0;
  input o_zero_Flag;
  input [0:0]o_zero_Flag_reg_1;
  input [4:0]D;

  wire [4:0]D;
  wire [4:0]Q;
  wire [0:0]SR;
  wire i_clock_IBUF_BUFG;
  wire \o_alu_Result_reg[1]_0 ;
  wire o_overflow_Flag;
  wire o_overflow_Flag_OBUF;
  wire o_overflow_Flag_reg_0;
  wire o_zero_Flag;
  wire o_zero_Flag_OBUF;
  wire o_zero_Flag_reg_0;
  wire [0:0]o_zero_Flag_reg_1;

  FDRE #(
    .INIT(1'b0)) 
    \o_alu_Result_reg[0] 
       (.C(i_clock_IBUF_BUFG),
        .CE(1'b1),
        .D(D[0]),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_alu_Result_reg[1] 
       (.C(i_clock_IBUF_BUFG),
        .CE(1'b1),
        .D(D[1]),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_alu_Result_reg[2] 
       (.C(i_clock_IBUF_BUFG),
        .CE(1'b1),
        .D(D[2]),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_alu_Result_reg[3] 
       (.C(i_clock_IBUF_BUFG),
        .CE(1'b1),
        .D(D[3]),
        .Q(Q[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_alu_Result_reg[4] 
       (.C(i_clock_IBUF_BUFG),
        .CE(1'b1),
        .D(D[4]),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    o_overflow_Flag_reg
       (.C(i_clock_IBUF_BUFG),
        .CE(o_overflow_Flag_reg_0),
        .D(o_overflow_Flag),
        .Q(o_overflow_Flag_OBUF),
        .R(SR));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    o_zero_Flag_i_3
       (.I0(Q[1]),
        .I1(Q[2]),
        .I2(o_zero_Flag_reg_1),
        .I3(Q[0]),
        .I4(Q[4]),
        .I5(Q[3]),
        .O(\o_alu_Result_reg[1]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    o_zero_Flag_reg
       (.C(i_clock_IBUF_BUFG),
        .CE(o_zero_Flag_reg_0),
        .D(o_zero_Flag),
        .Q(o_zero_Flag_OBUF),
        .R(SR));
endmodule

module alu_input_ctrl
   (D,
    \stored_Op_reg[0]_0 ,
    \stored_Op_reg[2]_0 ,
    o_zero_Flag,
    o_overflow_Flag,
    \stored_Op_reg[4]_0 ,
    o_zero_Flag_reg,
    Q,
    i_reset_IBUF,
    i_button_A_IBUF,
    i_button_B_IBUF,
    i_button_Op_IBUF,
    i_switches_IBUF,
    i_clock_IBUF_BUFG);
  output [4:0]D;
  output [0:0]\stored_Op_reg[0]_0 ;
  output \stored_Op_reg[2]_0 ;
  output o_zero_Flag;
  output o_overflow_Flag;
  output \stored_Op_reg[4]_0 ;
  input o_zero_Flag_reg;
  input [0:0]Q;
  input i_reset_IBUF;
  input i_button_A_IBUF;
  input i_button_B_IBUF;
  input i_button_Op_IBUF;
  input [15:0]i_switches_IBUF;
  input i_clock_IBUF_BUFG;

  wire [4:0]D;
  wire [0:0]Q;
  wire [4:0]alu_A;
  wire [4:0]alu_B;
  wire [5:1]alu_Op;
  wire i_button_A_IBUF;
  wire i_button_B_IBUF;
  wire i_button_Op_IBUF;
  wire i_clock_IBUF_BUFG;
  wire i_reset_IBUF;
  wire [15:0]i_switches_IBUF;
  wire \o_alu_Result[0]_i_2_n_0 ;
  wire \o_alu_Result[0]_i_3_n_0 ;
  wire \o_alu_Result[0]_i_4_n_0 ;
  wire \o_alu_Result[1]_i_2_n_0 ;
  wire \o_alu_Result[1]_i_3_n_0 ;
  wire \o_alu_Result[1]_i_4_n_0 ;
  wire \o_alu_Result[1]_i_5_n_0 ;
  wire \o_alu_Result[1]_i_6_n_0 ;
  wire \o_alu_Result[2]_i_2_n_0 ;
  wire \o_alu_Result[2]_i_3_n_0 ;
  wire \o_alu_Result[2]_i_4_n_0 ;
  wire \o_alu_Result[3]_i_2_n_0 ;
  wire \o_alu_Result[3]_i_3_n_0 ;
  wire \o_alu_Result[3]_i_4_n_0 ;
  wire \o_alu_Result[4]_i_2_n_0 ;
  wire \o_alu_Result[4]_i_3_n_0 ;
  wire \o_alu_Result[4]_i_4_n_0 ;
  wire \o_alu_Result[4]_i_5_n_0 ;
  wire \o_alu_Result[4]_i_6_n_0 ;
  wire o_overflow_Flag;
  wire o_overflow_Flag_i_3_n_0;
  wire o_zero_Flag;
  wire o_zero_Flag_reg;
  wire \stored_A[4]_i_1_n_0 ;
  wire \stored_A[4]_i_2_n_0 ;
  wire \stored_B[4]_i_1_n_0 ;
  wire \stored_B[4]_i_2_n_0 ;
  wire \stored_Op[5]_i_1_n_0 ;
  wire \stored_Op[5]_i_2_n_0 ;
  wire [0:0]\stored_Op_reg[0]_0 ;
  wire \stored_Op_reg[2]_0 ;
  wire \stored_Op_reg[4]_0 ;

  LUT6 #(
    .INIT(64'h000000000000FFEA)) 
    \o_alu_Result[0]_i_1 
       (.I0(\o_alu_Result[0]_i_2_n_0 ),
        .I1(\o_alu_Result[0]_i_3_n_0 ),
        .I2(\o_alu_Result[1]_i_4_n_0 ),
        .I3(\o_alu_Result[0]_i_4_n_0 ),
        .I4(alu_Op[3]),
        .I5(alu_Op[4]),
        .O(D[0]));
  LUT6 #(
    .INIT(64'h5063638000000000)) 
    \o_alu_Result[0]_i_2 
       (.I0(alu_Op[1]),
        .I1(\stored_Op_reg[0]_0 ),
        .I2(alu_Op[2]),
        .I3(alu_B[0]),
        .I4(alu_A[0]),
        .I5(alu_Op[5]),
        .O(\o_alu_Result[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00AC)) 
    \o_alu_Result[0]_i_3 
       (.I0(alu_A[3]),
        .I1(alu_A[1]),
        .I2(alu_B[1]),
        .I3(alu_B[2]),
        .O(\o_alu_Result[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0A8A008A0A800080)) 
    \o_alu_Result[0]_i_4 
       (.I0(\o_alu_Result[4]_i_3_n_0 ),
        .I1(alu_A[4]),
        .I2(alu_B[2]),
        .I3(alu_B[1]),
        .I4(alu_A[2]),
        .I5(alu_A[0]),
        .O(\o_alu_Result[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFFF888)) 
    \o_alu_Result[1]_i_1 
       (.I0(\o_alu_Result[1]_i_2_n_0 ),
        .I1(alu_Op[5]),
        .I2(\o_alu_Result[1]_i_3_n_0 ),
        .I3(\o_alu_Result[1]_i_4_n_0 ),
        .I4(\o_alu_Result[1]_i_5_n_0 ),
        .I5(\o_alu_Result[4]_i_5_n_0 ),
        .O(D[1]));
  LUT6 #(
    .INIT(64'h03003C69FC00C096)) 
    \o_alu_Result[1]_i_2 
       (.I0(\o_alu_Result[1]_i_6_n_0 ),
        .I1(alu_A[1]),
        .I2(alu_B[1]),
        .I3(alu_Op[2]),
        .I4(\stored_Op_reg[0]_0 ),
        .I5(alu_Op[1]),
        .O(\o_alu_Result[1]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00AC)) 
    \o_alu_Result[1]_i_3 
       (.I0(alu_A[4]),
        .I1(alu_A[2]),
        .I2(alu_B[1]),
        .I3(alu_B[2]),
        .O(\o_alu_Result[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    \o_alu_Result[1]_i_4 
       (.I0(alu_Op[5]),
        .I1(alu_Op[2]),
        .I2(alu_Op[1]),
        .I3(alu_B[4]),
        .I4(alu_B[3]),
        .I5(alu_B[0]),
        .O(\o_alu_Result[1]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h22200200)) 
    \o_alu_Result[1]_i_5 
       (.I0(\o_alu_Result[4]_i_3_n_0 ),
        .I1(alu_B[2]),
        .I2(alu_B[1]),
        .I3(alu_A[1]),
        .I4(alu_A[3]),
        .O(\o_alu_Result[1]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \o_alu_Result[1]_i_6 
       (.I0(alu_A[0]),
        .I1(alu_Op[1]),
        .I2(alu_B[0]),
        .O(\o_alu_Result[1]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h000000F8)) 
    \o_alu_Result[2]_i_1 
       (.I0(\o_alu_Result[2]_i_2_n_0 ),
        .I1(alu_Op[5]),
        .I2(\o_alu_Result[2]_i_3_n_0 ),
        .I3(alu_Op[3]),
        .I4(alu_Op[4]),
        .O(D[2]));
  LUT6 #(
    .INIT(64'h03003C69FC00C096)) 
    \o_alu_Result[2]_i_2 
       (.I0(\o_alu_Result[2]_i_4_n_0 ),
        .I1(alu_A[2]),
        .I2(alu_B[2]),
        .I3(alu_Op[2]),
        .I4(\stored_Op_reg[0]_0 ),
        .I5(alu_Op[1]),
        .O(\o_alu_Result[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF100010001000)) 
    \o_alu_Result[2]_i_3 
       (.I0(alu_B[2]),
        .I1(alu_B[1]),
        .I2(alu_A[3]),
        .I3(\o_alu_Result[1]_i_4_n_0 ),
        .I4(\o_alu_Result[1]_i_3_n_0 ),
        .I5(\o_alu_Result[4]_i_3_n_0 ),
        .O(\o_alu_Result[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hD0F8FD80)) 
    \o_alu_Result[2]_i_4 
       (.I0(alu_B[0]),
        .I1(alu_A[0]),
        .I2(alu_A[1]),
        .I3(alu_Op[1]),
        .I4(alu_B[1]),
        .O(\o_alu_Result[2]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h000000F8)) 
    \o_alu_Result[3]_i_1 
       (.I0(\o_alu_Result[3]_i_2_n_0 ),
        .I1(alu_Op[5]),
        .I2(\o_alu_Result[3]_i_3_n_0 ),
        .I3(alu_Op[3]),
        .I4(alu_Op[4]),
        .O(D[3]));
  LUT6 #(
    .INIT(64'h03003C69FC00C096)) 
    \o_alu_Result[3]_i_2 
       (.I0(\o_alu_Result[3]_i_4_n_0 ),
        .I1(alu_A[3]),
        .I2(alu_B[3]),
        .I3(alu_Op[2]),
        .I4(\stored_Op_reg[0]_0 ),
        .I5(alu_Op[1]),
        .O(\o_alu_Result[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000F000800080008)) 
    \o_alu_Result[3]_i_3 
       (.I0(alu_A[4]),
        .I1(\o_alu_Result[1]_i_4_n_0 ),
        .I2(alu_B[2]),
        .I3(alu_B[1]),
        .I4(alu_A[3]),
        .I5(\o_alu_Result[4]_i_3_n_0 ),
        .O(\o_alu_Result[3]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h8EE8)) 
    \o_alu_Result[3]_i_4 
       (.I0(\o_alu_Result[2]_i_4_n_0 ),
        .I1(alu_A[2]),
        .I2(alu_Op[1]),
        .I3(alu_B[2]),
        .O(\o_alu_Result[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F8888888)) 
    \o_alu_Result[4]_i_1 
       (.I0(alu_Op[5]),
        .I1(\o_alu_Result[4]_i_2_n_0 ),
        .I2(\o_alu_Result[4]_i_3_n_0 ),
        .I3(alu_A[4]),
        .I4(\o_alu_Result[4]_i_4_n_0 ),
        .I5(\o_alu_Result[4]_i_5_n_0 ),
        .O(D[4]));
  LUT6 #(
    .INIT(64'h03003C69FC00C096)) 
    \o_alu_Result[4]_i_2 
       (.I0(\o_alu_Result[4]_i_6_n_0 ),
        .I1(alu_A[4]),
        .I2(alu_B[4]),
        .I3(alu_Op[2]),
        .I4(\stored_Op_reg[0]_0 ),
        .I5(alu_Op[1]),
        .O(\o_alu_Result[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000010)) 
    \o_alu_Result[4]_i_3 
       (.I0(alu_Op[5]),
        .I1(alu_Op[2]),
        .I2(alu_Op[1]),
        .I3(alu_B[4]),
        .I4(alu_B[3]),
        .I5(alu_B[0]),
        .O(\o_alu_Result[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \o_alu_Result[4]_i_4 
       (.I0(alu_B[1]),
        .I1(alu_B[2]),
        .O(\o_alu_Result[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \o_alu_Result[4]_i_5 
       (.I0(alu_Op[4]),
        .I1(alu_Op[3]),
        .O(\o_alu_Result[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hD400FFE8FFD4E800)) 
    \o_alu_Result[4]_i_6 
       (.I0(alu_B[2]),
        .I1(alu_A[2]),
        .I2(\o_alu_Result[2]_i_4_n_0 ),
        .I3(alu_A[3]),
        .I4(alu_Op[1]),
        .I5(alu_B[3]),
        .O(\o_alu_Result[4]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hEFFEEFFF)) 
    o_overflow_Flag_i_1
       (.I0(alu_Op[4]),
        .I1(alu_Op[3]),
        .I2(alu_Op[5]),
        .I3(alu_Op[2]),
        .I4(alu_Op[1]),
        .O(\stored_Op_reg[4]_0 ));
  LUT6 #(
    .INIT(64'h0100001000100100)) 
    o_overflow_Flag_i_2
       (.I0(\stored_Op_reg[0]_0 ),
        .I1(o_overflow_Flag_i_3_n_0),
        .I2(alu_A[4]),
        .I3(Q),
        .I4(alu_Op[1]),
        .I5(alu_B[4]),
        .O(o_overflow_Flag));
  LUT3 #(
    .INIT(8'hEF)) 
    o_overflow_Flag_i_3
       (.I0(alu_Op[3]),
        .I1(alu_Op[4]),
        .I2(alu_Op[5]),
        .O(o_overflow_Flag_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFF5FFF4FFFAFFFF)) 
    o_zero_Flag_i_1
       (.I0(alu_Op[2]),
        .I1(\stored_Op_reg[0]_0 ),
        .I2(alu_Op[4]),
        .I3(alu_Op[3]),
        .I4(alu_Op[1]),
        .I5(alu_Op[5]),
        .O(\stored_Op_reg[2]_0 ));
  LUT4 #(
    .INIT(16'h0008)) 
    o_zero_Flag_i_2
       (.I0(o_zero_Flag_reg),
        .I1(alu_Op[5]),
        .I2(alu_Op[4]),
        .I3(alu_Op[3]),
        .O(o_zero_Flag));
  LUT2 #(
    .INIT(4'h2)) 
    \stored_A[4]_i_1 
       (.I0(i_reset_IBUF),
        .I1(i_button_A_IBUF),
        .O(\stored_A[4]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \stored_A[4]_i_2 
       (.I0(i_button_A_IBUF),
        .I1(i_reset_IBUF),
        .O(\stored_A[4]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_A_reg[0] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_A[4]_i_2_n_0 ),
        .D(i_switches_IBUF[0]),
        .Q(alu_A[0]),
        .R(\stored_A[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_A_reg[1] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_A[4]_i_2_n_0 ),
        .D(i_switches_IBUF[1]),
        .Q(alu_A[1]),
        .R(\stored_A[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_A_reg[2] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_A[4]_i_2_n_0 ),
        .D(i_switches_IBUF[2]),
        .Q(alu_A[2]),
        .R(\stored_A[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_A_reg[3] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_A[4]_i_2_n_0 ),
        .D(i_switches_IBUF[3]),
        .Q(alu_A[3]),
        .R(\stored_A[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_A_reg[4] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_A[4]_i_2_n_0 ),
        .D(i_switches_IBUF[4]),
        .Q(alu_A[4]),
        .R(\stored_A[4]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \stored_B[4]_i_1 
       (.I0(i_reset_IBUF),
        .I1(i_button_B_IBUF),
        .O(\stored_B[4]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \stored_B[4]_i_2 
       (.I0(i_button_B_IBUF),
        .I1(i_reset_IBUF),
        .O(\stored_B[4]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_B_reg[0] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_B[4]_i_2_n_0 ),
        .D(i_switches_IBUF[5]),
        .Q(alu_B[0]),
        .R(\stored_B[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_B_reg[1] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_B[4]_i_2_n_0 ),
        .D(i_switches_IBUF[6]),
        .Q(alu_B[1]),
        .R(\stored_B[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_B_reg[2] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_B[4]_i_2_n_0 ),
        .D(i_switches_IBUF[7]),
        .Q(alu_B[2]),
        .R(\stored_B[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_B_reg[3] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_B[4]_i_2_n_0 ),
        .D(i_switches_IBUF[8]),
        .Q(alu_B[3]),
        .R(\stored_B[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_B_reg[4] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_B[4]_i_2_n_0 ),
        .D(i_switches_IBUF[9]),
        .Q(alu_B[4]),
        .R(\stored_B[4]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \stored_Op[5]_i_1 
       (.I0(i_reset_IBUF),
        .I1(i_button_Op_IBUF),
        .O(\stored_Op[5]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \stored_Op[5]_i_2 
       (.I0(i_button_Op_IBUF),
        .I1(i_reset_IBUF),
        .O(\stored_Op[5]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_Op_reg[0] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_Op[5]_i_2_n_0 ),
        .D(i_switches_IBUF[10]),
        .Q(\stored_Op_reg[0]_0 ),
        .R(\stored_Op[5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_Op_reg[1] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_Op[5]_i_2_n_0 ),
        .D(i_switches_IBUF[11]),
        .Q(alu_Op[1]),
        .R(\stored_Op[5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_Op_reg[2] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_Op[5]_i_2_n_0 ),
        .D(i_switches_IBUF[12]),
        .Q(alu_Op[2]),
        .R(\stored_Op[5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_Op_reg[3] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_Op[5]_i_2_n_0 ),
        .D(i_switches_IBUF[13]),
        .Q(alu_Op[3]),
        .R(\stored_Op[5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_Op_reg[4] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_Op[5]_i_2_n_0 ),
        .D(i_switches_IBUF[14]),
        .Q(alu_Op[4]),
        .R(\stored_Op[5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stored_Op_reg[5] 
       (.C(i_clock_IBUF_BUFG),
        .CE(\stored_Op[5]_i_2_n_0 ),
        .D(i_switches_IBUF[15]),
        .Q(alu_Op[5]),
        .R(\stored_Op[5]_i_1_n_0 ));
endmodule

(* N = "5" *) (* NSel = "6" *) (* N_SW = "16" *) 
(* NotValidForBitStream *)
module alu_top
   (i_clock,
    i_reset,
    i_switches,
    i_button_A,
    i_button_B,
    i_button_Op,
    o_LED_Result,
    o_overflow_Flag,
    o_zero_Flag);
  input i_clock;
  input i_reset;
  input [15:0]i_switches;
  input i_button_A;
  input i_button_B;
  input i_button_Op;
  output [4:0]o_LED_Result;
  output o_overflow_Flag;
  output o_zero_Flag;

  wire [0:0]alu_Op;
  wire i_button_A;
  wire i_button_A_IBUF;
  wire i_button_B;
  wire i_button_B_IBUF;
  wire i_button_Op;
  wire i_button_Op_IBUF;
  wire i_clock;
  wire i_clock_IBUF;
  wire i_clock_IBUF_BUFG;
  wire i_reset;
  wire i_reset_IBUF;
  wire [15:0]i_switches;
  wire [15:0]i_switches_IBUF;
  wire [4:0]o_LED_Result;
  wire [4:0]o_LED_Result_OBUF;
  wire [4:0]o_alu_Result;
  wire o_overflow_Flag;
  wire o_overflow_Flag_0;
  wire o_overflow_Flag_OBUF;
  wire o_zero_Flag;
  wire o_zero_Flag_1;
  wire o_zero_Flag_OBUF;
  wire u_ctrl_n_6;
  wire u_ctrl_n_9;
  wire uut_n_2;

  IBUF i_button_A_IBUF_inst
       (.I(i_button_A),
        .O(i_button_A_IBUF));
  IBUF i_button_B_IBUF_inst
       (.I(i_button_B),
        .O(i_button_B_IBUF));
  IBUF i_button_Op_IBUF_inst
       (.I(i_button_Op),
        .O(i_button_Op_IBUF));
  BUFG i_clock_IBUF_BUFG_inst
       (.I(i_clock_IBUF),
        .O(i_clock_IBUF_BUFG));
  IBUF i_clock_IBUF_inst
       (.I(i_clock),
        .O(i_clock_IBUF));
  IBUF i_reset_IBUF_inst
       (.I(i_reset),
        .O(i_reset_IBUF));
  IBUF \i_switches_IBUF[0]_inst 
       (.I(i_switches[0]),
        .O(i_switches_IBUF[0]));
  IBUF \i_switches_IBUF[10]_inst 
       (.I(i_switches[10]),
        .O(i_switches_IBUF[10]));
  IBUF \i_switches_IBUF[11]_inst 
       (.I(i_switches[11]),
        .O(i_switches_IBUF[11]));
  IBUF \i_switches_IBUF[12]_inst 
       (.I(i_switches[12]),
        .O(i_switches_IBUF[12]));
  IBUF \i_switches_IBUF[13]_inst 
       (.I(i_switches[13]),
        .O(i_switches_IBUF[13]));
  IBUF \i_switches_IBUF[14]_inst 
       (.I(i_switches[14]),
        .O(i_switches_IBUF[14]));
  IBUF \i_switches_IBUF[15]_inst 
       (.I(i_switches[15]),
        .O(i_switches_IBUF[15]));
  IBUF \i_switches_IBUF[1]_inst 
       (.I(i_switches[1]),
        .O(i_switches_IBUF[1]));
  IBUF \i_switches_IBUF[2]_inst 
       (.I(i_switches[2]),
        .O(i_switches_IBUF[2]));
  IBUF \i_switches_IBUF[3]_inst 
       (.I(i_switches[3]),
        .O(i_switches_IBUF[3]));
  IBUF \i_switches_IBUF[4]_inst 
       (.I(i_switches[4]),
        .O(i_switches_IBUF[4]));
  IBUF \i_switches_IBUF[5]_inst 
       (.I(i_switches[5]),
        .O(i_switches_IBUF[5]));
  IBUF \i_switches_IBUF[6]_inst 
       (.I(i_switches[6]),
        .O(i_switches_IBUF[6]));
  IBUF \i_switches_IBUF[7]_inst 
       (.I(i_switches[7]),
        .O(i_switches_IBUF[7]));
  IBUF \i_switches_IBUF[8]_inst 
       (.I(i_switches[8]),
        .O(i_switches_IBUF[8]));
  IBUF \i_switches_IBUF[9]_inst 
       (.I(i_switches[9]),
        .O(i_switches_IBUF[9]));
  OBUF \o_LED_Result_OBUF[0]_inst 
       (.I(o_LED_Result_OBUF[0]),
        .O(o_LED_Result[0]));
  OBUF \o_LED_Result_OBUF[1]_inst 
       (.I(o_LED_Result_OBUF[1]),
        .O(o_LED_Result[1]));
  OBUF \o_LED_Result_OBUF[2]_inst 
       (.I(o_LED_Result_OBUF[2]),
        .O(o_LED_Result[2]));
  OBUF \o_LED_Result_OBUF[3]_inst 
       (.I(o_LED_Result_OBUF[3]),
        .O(o_LED_Result[3]));
  OBUF \o_LED_Result_OBUF[4]_inst 
       (.I(o_LED_Result_OBUF[4]),
        .O(o_LED_Result[4]));
  OBUF o_overflow_Flag_OBUF_inst
       (.I(o_overflow_Flag_OBUF),
        .O(o_overflow_Flag));
  OBUF o_zero_Flag_OBUF_inst
       (.I(o_zero_Flag_OBUF),
        .O(o_zero_Flag));
  alu_input_ctrl u_ctrl
       (.D(o_alu_Result),
        .Q(o_LED_Result_OBUF[4]),
        .i_button_A_IBUF(i_button_A_IBUF),
        .i_button_B_IBUF(i_button_B_IBUF),
        .i_button_Op_IBUF(i_button_Op_IBUF),
        .i_clock_IBUF_BUFG(i_clock_IBUF_BUFG),
        .i_reset_IBUF(i_reset_IBUF),
        .i_switches_IBUF(i_switches_IBUF),
        .o_overflow_Flag(o_overflow_Flag_0),
        .o_zero_Flag(o_zero_Flag_1),
        .o_zero_Flag_reg(uut_n_2),
        .\stored_Op_reg[0]_0 (alu_Op),
        .\stored_Op_reg[2]_0 (u_ctrl_n_6),
        .\stored_Op_reg[4]_0 (u_ctrl_n_9));
  alu uut
       (.D(o_alu_Result),
        .Q(o_LED_Result_OBUF),
        .SR(i_reset_IBUF),
        .i_clock_IBUF_BUFG(i_clock_IBUF_BUFG),
        .\o_alu_Result_reg[1]_0 (uut_n_2),
        .o_overflow_Flag(o_overflow_Flag_0),
        .o_overflow_Flag_OBUF(o_overflow_Flag_OBUF),
        .o_overflow_Flag_reg_0(u_ctrl_n_9),
        .o_zero_Flag(o_zero_Flag_1),
        .o_zero_Flag_OBUF(o_zero_Flag_OBUF),
        .o_zero_Flag_reg_0(u_ctrl_n_6),
        .o_zero_Flag_reg_1(alu_Op));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
