# add3bits.xdc

# pour planchette Nexys 4 ddr

# LEDs
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { Cout }];
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports { Cout }];

# Commutateurs
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports { X }];
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports { Y }];
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports { Cin }];
