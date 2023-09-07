#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2023.1.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Thu Aug 31 10:05:00 -03 2023
# SW Build 3900603 on Fri Jun 16 19:30:25 MDT 2023
#
# IP Build 3900379 on Sat Jun 17 05:28:05 MDT 2023
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L secureip --snapshot hex_to_sseg_test_func_synth xil_defaultlib.hex_to_sseg_test xil_defaultlib.glbl -log elaborate.log"
xelab --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L secureip --snapshot hex_to_sseg_test_func_synth xil_defaultlib.hex_to_sseg_test xil_defaultlib.glbl -log elaborate.log

