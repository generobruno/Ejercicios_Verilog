// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1.1 (lin64) Build 3900603 Fri Jun 16 19:30:25 MDT 2023
// Date        : Thu Aug 31 10:04:58 2023
// Host        : BrunoLaptop running 64-bit Ubuntu 22.04.2 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/bruno/Documents/Facultad/5to_anio/Arquitectura_de_Computadoras/Ejercicios_Verilog/Ej_7Seg/Ej_7Seg.sim/sim_1/synth/func/xsim/hex_to_sseg_test_func_synth.v
// Design      : disp_mux
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* N = "18" *) 
(* NotValidForBitStream *)
module disp_mux
   (clk,
    reset,
    in3,
    in2,
    in1,
    in0,
    an,
    sseg);
  input clk;
  input reset;
  input [7:0]in3;
  input [7:0]in2;
  input [7:0]in1;
  input [7:0]in0;
  output [3:0]an;
  output [7:0]sseg;

  wire [3:0]an;
  wire [3:0]an_OBUF;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [7:0]in0;
  wire [7:0]in0_IBUF;
  wire [7:0]in1;
  wire [7:0]in1_IBUF;
  wire [7:0]in2;
  wire [7:0]in2_IBUF;
  wire [7:0]in3;
  wire [7:0]in3_IBUF;
  wire [1:0]p_0_in;
  wire \q_reg[0]_i_2_n_0 ;
  wire \q_reg_reg[0]_i_1_n_0 ;
  wire \q_reg_reg[0]_i_1_n_1 ;
  wire \q_reg_reg[0]_i_1_n_2 ;
  wire \q_reg_reg[0]_i_1_n_3 ;
  wire \q_reg_reg[0]_i_1_n_4 ;
  wire \q_reg_reg[0]_i_1_n_5 ;
  wire \q_reg_reg[0]_i_1_n_6 ;
  wire \q_reg_reg[0]_i_1_n_7 ;
  wire \q_reg_reg[12]_i_1_n_0 ;
  wire \q_reg_reg[12]_i_1_n_1 ;
  wire \q_reg_reg[12]_i_1_n_2 ;
  wire \q_reg_reg[12]_i_1_n_3 ;
  wire \q_reg_reg[12]_i_1_n_4 ;
  wire \q_reg_reg[12]_i_1_n_5 ;
  wire \q_reg_reg[12]_i_1_n_6 ;
  wire \q_reg_reg[12]_i_1_n_7 ;
  wire \q_reg_reg[16]_i_1_n_3 ;
  wire \q_reg_reg[16]_i_1_n_6 ;
  wire \q_reg_reg[16]_i_1_n_7 ;
  wire \q_reg_reg[4]_i_1_n_0 ;
  wire \q_reg_reg[4]_i_1_n_1 ;
  wire \q_reg_reg[4]_i_1_n_2 ;
  wire \q_reg_reg[4]_i_1_n_3 ;
  wire \q_reg_reg[4]_i_1_n_4 ;
  wire \q_reg_reg[4]_i_1_n_5 ;
  wire \q_reg_reg[4]_i_1_n_6 ;
  wire \q_reg_reg[4]_i_1_n_7 ;
  wire \q_reg_reg[8]_i_1_n_0 ;
  wire \q_reg_reg[8]_i_1_n_1 ;
  wire \q_reg_reg[8]_i_1_n_2 ;
  wire \q_reg_reg[8]_i_1_n_3 ;
  wire \q_reg_reg[8]_i_1_n_4 ;
  wire \q_reg_reg[8]_i_1_n_5 ;
  wire \q_reg_reg[8]_i_1_n_6 ;
  wire \q_reg_reg[8]_i_1_n_7 ;
  wire \q_reg_reg_n_0_[0] ;
  wire \q_reg_reg_n_0_[10] ;
  wire \q_reg_reg_n_0_[11] ;
  wire \q_reg_reg_n_0_[12] ;
  wire \q_reg_reg_n_0_[13] ;
  wire \q_reg_reg_n_0_[14] ;
  wire \q_reg_reg_n_0_[15] ;
  wire \q_reg_reg_n_0_[1] ;
  wire \q_reg_reg_n_0_[2] ;
  wire \q_reg_reg_n_0_[3] ;
  wire \q_reg_reg_n_0_[4] ;
  wire \q_reg_reg_n_0_[5] ;
  wire \q_reg_reg_n_0_[6] ;
  wire \q_reg_reg_n_0_[7] ;
  wire \q_reg_reg_n_0_[8] ;
  wire \q_reg_reg_n_0_[9] ;
  wire reset;
  wire reset_IBUF;
  wire [7:0]sseg;
  wire [7:0]sseg_OBUF;
  wire [3:1]\NLW_q_reg_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_q_reg_reg[16]_i_1_O_UNCONNECTED ;

  OBUF \an_OBUF[0]_inst 
       (.I(an_OBUF[0]),
        .O(an[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \an_OBUF[0]_inst_i_1 
       (.I0(p_0_in[1]),
        .I1(p_0_in[0]),
        .O(an_OBUF[0]));
  OBUF \an_OBUF[1]_inst 
       (.I(an_OBUF[1]),
        .O(an[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \an_OBUF[1]_inst_i_1 
       (.I0(p_0_in[1]),
        .I1(p_0_in[0]),
        .O(an_OBUF[1]));
  OBUF \an_OBUF[2]_inst 
       (.I(an_OBUF[2]),
        .O(an[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \an_OBUF[2]_inst_i_1 
       (.I0(p_0_in[0]),
        .I1(p_0_in[1]),
        .O(an_OBUF[2]));
  OBUF \an_OBUF[3]_inst 
       (.I(an_OBUF[3]),
        .O(an[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \an_OBUF[3]_inst_i_1 
       (.I0(p_0_in[1]),
        .I1(p_0_in[0]),
        .O(an_OBUF[3]));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF \in0_IBUF[0]_inst 
       (.I(in0[0]),
        .O(in0_IBUF[0]));
  IBUF \in0_IBUF[1]_inst 
       (.I(in0[1]),
        .O(in0_IBUF[1]));
  IBUF \in0_IBUF[2]_inst 
       (.I(in0[2]),
        .O(in0_IBUF[2]));
  IBUF \in0_IBUF[3]_inst 
       (.I(in0[3]),
        .O(in0_IBUF[3]));
  IBUF \in0_IBUF[4]_inst 
       (.I(in0[4]),
        .O(in0_IBUF[4]));
  IBUF \in0_IBUF[5]_inst 
       (.I(in0[5]),
        .O(in0_IBUF[5]));
  IBUF \in0_IBUF[6]_inst 
       (.I(in0[6]),
        .O(in0_IBUF[6]));
  IBUF \in0_IBUF[7]_inst 
       (.I(in0[7]),
        .O(in0_IBUF[7]));
  IBUF \in1_IBUF[0]_inst 
       (.I(in1[0]),
        .O(in1_IBUF[0]));
  IBUF \in1_IBUF[1]_inst 
       (.I(in1[1]),
        .O(in1_IBUF[1]));
  IBUF \in1_IBUF[2]_inst 
       (.I(in1[2]),
        .O(in1_IBUF[2]));
  IBUF \in1_IBUF[3]_inst 
       (.I(in1[3]),
        .O(in1_IBUF[3]));
  IBUF \in1_IBUF[4]_inst 
       (.I(in1[4]),
        .O(in1_IBUF[4]));
  IBUF \in1_IBUF[5]_inst 
       (.I(in1[5]),
        .O(in1_IBUF[5]));
  IBUF \in1_IBUF[6]_inst 
       (.I(in1[6]),
        .O(in1_IBUF[6]));
  IBUF \in1_IBUF[7]_inst 
       (.I(in1[7]),
        .O(in1_IBUF[7]));
  IBUF \in2_IBUF[0]_inst 
       (.I(in2[0]),
        .O(in2_IBUF[0]));
  IBUF \in2_IBUF[1]_inst 
       (.I(in2[1]),
        .O(in2_IBUF[1]));
  IBUF \in2_IBUF[2]_inst 
       (.I(in2[2]),
        .O(in2_IBUF[2]));
  IBUF \in2_IBUF[3]_inst 
       (.I(in2[3]),
        .O(in2_IBUF[3]));
  IBUF \in2_IBUF[4]_inst 
       (.I(in2[4]),
        .O(in2_IBUF[4]));
  IBUF \in2_IBUF[5]_inst 
       (.I(in2[5]),
        .O(in2_IBUF[5]));
  IBUF \in2_IBUF[6]_inst 
       (.I(in2[6]),
        .O(in2_IBUF[6]));
  IBUF \in2_IBUF[7]_inst 
       (.I(in2[7]),
        .O(in2_IBUF[7]));
  IBUF \in3_IBUF[0]_inst 
       (.I(in3[0]),
        .O(in3_IBUF[0]));
  IBUF \in3_IBUF[1]_inst 
       (.I(in3[1]),
        .O(in3_IBUF[1]));
  IBUF \in3_IBUF[2]_inst 
       (.I(in3[2]),
        .O(in3_IBUF[2]));
  IBUF \in3_IBUF[3]_inst 
       (.I(in3[3]),
        .O(in3_IBUF[3]));
  IBUF \in3_IBUF[4]_inst 
       (.I(in3[4]),
        .O(in3_IBUF[4]));
  IBUF \in3_IBUF[5]_inst 
       (.I(in3[5]),
        .O(in3_IBUF[5]));
  IBUF \in3_IBUF[6]_inst 
       (.I(in3[6]),
        .O(in3_IBUF[6]));
  IBUF \in3_IBUF[7]_inst 
       (.I(in3[7]),
        .O(in3_IBUF[7]));
  LUT1 #(
    .INIT(2'h1)) 
    \q_reg[0]_i_2 
       (.I0(\q_reg_reg_n_0_[0] ),
        .O(\q_reg[0]_i_2_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[0]_i_1_n_7 ),
        .Q(\q_reg_reg_n_0_[0] ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \q_reg_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\q_reg_reg[0]_i_1_n_0 ,\q_reg_reg[0]_i_1_n_1 ,\q_reg_reg[0]_i_1_n_2 ,\q_reg_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\q_reg_reg[0]_i_1_n_4 ,\q_reg_reg[0]_i_1_n_5 ,\q_reg_reg[0]_i_1_n_6 ,\q_reg_reg[0]_i_1_n_7 }),
        .S({\q_reg_reg_n_0_[3] ,\q_reg_reg_n_0_[2] ,\q_reg_reg_n_0_[1] ,\q_reg[0]_i_2_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[8]_i_1_n_5 ),
        .Q(\q_reg_reg_n_0_[10] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[8]_i_1_n_4 ),
        .Q(\q_reg_reg_n_0_[11] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[12]_i_1_n_7 ),
        .Q(\q_reg_reg_n_0_[12] ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \q_reg_reg[12]_i_1 
       (.CI(\q_reg_reg[8]_i_1_n_0 ),
        .CO({\q_reg_reg[12]_i_1_n_0 ,\q_reg_reg[12]_i_1_n_1 ,\q_reg_reg[12]_i_1_n_2 ,\q_reg_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\q_reg_reg[12]_i_1_n_4 ,\q_reg_reg[12]_i_1_n_5 ,\q_reg_reg[12]_i_1_n_6 ,\q_reg_reg[12]_i_1_n_7 }),
        .S({\q_reg_reg_n_0_[15] ,\q_reg_reg_n_0_[14] ,\q_reg_reg_n_0_[13] ,\q_reg_reg_n_0_[12] }));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[12]_i_1_n_6 ),
        .Q(\q_reg_reg_n_0_[13] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[12]_i_1_n_5 ),
        .Q(\q_reg_reg_n_0_[14] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[12]_i_1_n_4 ),
        .Q(\q_reg_reg_n_0_[15] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[16]_i_1_n_7 ),
        .Q(p_0_in[0]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \q_reg_reg[16]_i_1 
       (.CI(\q_reg_reg[12]_i_1_n_0 ),
        .CO({\NLW_q_reg_reg[16]_i_1_CO_UNCONNECTED [3:1],\q_reg_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_q_reg_reg[16]_i_1_O_UNCONNECTED [3:2],\q_reg_reg[16]_i_1_n_6 ,\q_reg_reg[16]_i_1_n_7 }),
        .S({1'b0,1'b0,p_0_in}));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[16]_i_1_n_6 ),
        .Q(p_0_in[1]));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[0]_i_1_n_6 ),
        .Q(\q_reg_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[0]_i_1_n_5 ),
        .Q(\q_reg_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[0]_i_1_n_4 ),
        .Q(\q_reg_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[4]_i_1_n_7 ),
        .Q(\q_reg_reg_n_0_[4] ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \q_reg_reg[4]_i_1 
       (.CI(\q_reg_reg[0]_i_1_n_0 ),
        .CO({\q_reg_reg[4]_i_1_n_0 ,\q_reg_reg[4]_i_1_n_1 ,\q_reg_reg[4]_i_1_n_2 ,\q_reg_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\q_reg_reg[4]_i_1_n_4 ,\q_reg_reg[4]_i_1_n_5 ,\q_reg_reg[4]_i_1_n_6 ,\q_reg_reg[4]_i_1_n_7 }),
        .S({\q_reg_reg_n_0_[7] ,\q_reg_reg_n_0_[6] ,\q_reg_reg_n_0_[5] ,\q_reg_reg_n_0_[4] }));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[4]_i_1_n_6 ),
        .Q(\q_reg_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[4]_i_1_n_5 ),
        .Q(\q_reg_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[4]_i_1_n_4 ),
        .Q(\q_reg_reg_n_0_[7] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[8]_i_1_n_7 ),
        .Q(\q_reg_reg_n_0_[8] ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \q_reg_reg[8]_i_1 
       (.CI(\q_reg_reg[4]_i_1_n_0 ),
        .CO({\q_reg_reg[8]_i_1_n_0 ,\q_reg_reg[8]_i_1_n_1 ,\q_reg_reg[8]_i_1_n_2 ,\q_reg_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\q_reg_reg[8]_i_1_n_4 ,\q_reg_reg[8]_i_1_n_5 ,\q_reg_reg[8]_i_1_n_6 ,\q_reg_reg[8]_i_1_n_7 }),
        .S({\q_reg_reg_n_0_[11] ,\q_reg_reg_n_0_[10] ,\q_reg_reg_n_0_[9] ,\q_reg_reg_n_0_[8] }));
  FDCE #(
    .INIT(1'b0)) 
    \q_reg_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(\q_reg_reg[8]_i_1_n_6 ),
        .Q(\q_reg_reg_n_0_[9] ));
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
  OBUF \sseg_OBUF[0]_inst 
       (.I(sseg_OBUF[0]),
        .O(sseg[0]));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \sseg_OBUF[0]_inst_i_1 
       (.I0(in1_IBUF[0]),
        .I1(in0_IBUF[0]),
        .I2(in3_IBUF[0]),
        .I3(p_0_in[1]),
        .I4(p_0_in[0]),
        .I5(in2_IBUF[0]),
        .O(sseg_OBUF[0]));
  OBUF \sseg_OBUF[1]_inst 
       (.I(sseg_OBUF[1]),
        .O(sseg[1]));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \sseg_OBUF[1]_inst_i_1 
       (.I0(in1_IBUF[1]),
        .I1(in0_IBUF[1]),
        .I2(in3_IBUF[1]),
        .I3(p_0_in[1]),
        .I4(p_0_in[0]),
        .I5(in2_IBUF[1]),
        .O(sseg_OBUF[1]));
  OBUF \sseg_OBUF[2]_inst 
       (.I(sseg_OBUF[2]),
        .O(sseg[2]));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \sseg_OBUF[2]_inst_i_1 
       (.I0(in1_IBUF[2]),
        .I1(in0_IBUF[2]),
        .I2(in3_IBUF[2]),
        .I3(p_0_in[1]),
        .I4(p_0_in[0]),
        .I5(in2_IBUF[2]),
        .O(sseg_OBUF[2]));
  OBUF \sseg_OBUF[3]_inst 
       (.I(sseg_OBUF[3]),
        .O(sseg[3]));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \sseg_OBUF[3]_inst_i_1 
       (.I0(in1_IBUF[3]),
        .I1(in0_IBUF[3]),
        .I2(in3_IBUF[3]),
        .I3(p_0_in[1]),
        .I4(p_0_in[0]),
        .I5(in2_IBUF[3]),
        .O(sseg_OBUF[3]));
  OBUF \sseg_OBUF[4]_inst 
       (.I(sseg_OBUF[4]),
        .O(sseg[4]));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \sseg_OBUF[4]_inst_i_1 
       (.I0(in1_IBUF[4]),
        .I1(in0_IBUF[4]),
        .I2(in3_IBUF[4]),
        .I3(p_0_in[1]),
        .I4(p_0_in[0]),
        .I5(in2_IBUF[4]),
        .O(sseg_OBUF[4]));
  OBUF \sseg_OBUF[5]_inst 
       (.I(sseg_OBUF[5]),
        .O(sseg[5]));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \sseg_OBUF[5]_inst_i_1 
       (.I0(in1_IBUF[5]),
        .I1(in0_IBUF[5]),
        .I2(in3_IBUF[5]),
        .I3(p_0_in[1]),
        .I4(p_0_in[0]),
        .I5(in2_IBUF[5]),
        .O(sseg_OBUF[5]));
  OBUF \sseg_OBUF[6]_inst 
       (.I(sseg_OBUF[6]),
        .O(sseg[6]));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \sseg_OBUF[6]_inst_i_1 
       (.I0(in1_IBUF[6]),
        .I1(in0_IBUF[6]),
        .I2(in3_IBUF[6]),
        .I3(p_0_in[1]),
        .I4(p_0_in[0]),
        .I5(in2_IBUF[6]),
        .O(sseg_OBUF[6]));
  OBUF \sseg_OBUF[7]_inst 
       (.I(sseg_OBUF[7]),
        .O(sseg[7]));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \sseg_OBUF[7]_inst_i_1 
       (.I0(in1_IBUF[7]),
        .I1(in0_IBUF[7]),
        .I2(in3_IBUF[7]),
        .I3(p_0_in[1]),
        .I4(p_0_in[0]),
        .I5(in2_IBUF[7]),
        .O(sseg_OBUF[7]));
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
