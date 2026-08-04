TestSuite CoSim_Pcie
library    osvvm_TbPcie

ChangeWorkingDirectory ../tests
MkVproc    vc

ChangeWorkingDirectory ../testbench/TbPcie
RunTest Tb_Pcie_Phy.vhd [CoSim]
RunTest Tb_Pcie_Dll.vhd [CoSim]

TestName   CoSim_Pcie
simulate   Tb_PCIe [CoSim]

TestName   CoSim_PcieAutoEp
simulate   Tb_PCIeAutoEp [CoSim]

TestName   CoSim_PcieSerial
simulate   Tb_PCIeSerial [CoSim]

if {($::osvvm::ToolName eq "Questa") || ($::osvvm::ToolName eq "FPGA")} {

  # Pre-compiled libraries must match version they were built with
  if {($::osvvm::ToolVersion eq "2025.2")} {
    SetExtendedSimulateOptions +nowarnPCDPC
    SetExtendedOptimizeOptions [AlteraLibArgs]
    
    TestName CoSim_PcieAltera
    simulate Tb_PCIeAltera [CoSim]
  }

} elseif {($::osvvm::ToolName eq "RivieraPRO")} {

  # Extract major and minor version numbers of tool
  set split_ver [split $::osvvm::ToolVersion "." ]
  set split_maj [lindex $split_ver 0]
  set split_min [lindex $split_ver 1]

  # Pre-compiled libraries must match version they were built with
  if { ($split_maj eq "2026") && ($split_min eq "06") } {
    SetExtendedSimulateOptions [AlteraLibArgsAldec]
    
    TestName CoSim_PcieAltera
    simulate Tb_PCIeAltera [CoSim]
  }
}

