package require -exact qsys 14.0

# module properties
set_module_property NAME {asmi_export}
set_module_property DISPLAY_NAME {asmi_export_display}

# default module properties
set_module_property VERSION {1.0}
set_module_property GROUP {default group}
set_module_property DESCRIPTION {default description}
set_module_property AUTHOR {author}

set_module_property COMPOSITION_CALLBACK compose
set_module_property opaque_address_map false

proc compose { } {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    add_instance asmi_parallel_0 altera_asmi_parallel 14.1
    set_instance_parameter_value asmi_parallel_0 {CBX_AUTO_BLACKBOX} {ALL}
    set_instance_parameter_value asmi_parallel_0 {EPCS_TYPE} {EPCQ256}
    set_instance_parameter_value asmi_parallel_0 {gui_read_sid} {0}
    set_instance_parameter_value asmi_parallel_0 {gui_read_rdid} {1}
    set_instance_parameter_value asmi_parallel_0 {gui_read_status} {1}
    set_instance_parameter_value asmi_parallel_0 {gui_read_address} {0}
    set_instance_parameter_value asmi_parallel_0 {gui_fast_read} {1}
    set_instance_parameter_value asmi_parallel_0 {DATA_WIDTH} {QUAD}
    set_instance_parameter_value asmi_parallel_0 {gui_read_dummyclk} {0}
    set_instance_parameter_value asmi_parallel_0 {gui_write} {1}
    set_instance_parameter_value asmi_parallel_0 {gui_wren} {1}
    set_instance_parameter_value asmi_parallel_0 {gui_single_write} {0}
    set_instance_parameter_value asmi_parallel_0 {gui_page_write} {1}
    set_instance_parameter_value asmi_parallel_0 {PAGE_SIZE} {256}
    set_instance_parameter_value asmi_parallel_0 {gui_use_eab} {0}
    set_instance_parameter_value asmi_parallel_0 {gui_bulk_erase} {1}
    set_instance_parameter_value asmi_parallel_0 {gui_die_erase} {0}
    set_instance_parameter_value asmi_parallel_0 {gui_sector_erase} {0}
    set_instance_parameter_value asmi_parallel_0 {gui_sector_protect} {0}
    set_instance_parameter_value asmi_parallel_0 {gui_ex4b_addr} {0}
    set_instance_parameter_value asmi_parallel_0 {gui_use_asmiblock} {0}
    set_instance_parameter_value asmi_parallel_0 {WRITE_DUMMY_CLK} {0}
    set_instance_parameter_value asmi_parallel_0 {ENABLE_SIM} {1}

    # connections and connection parameters
    # exported interfaces
    add_interface addr conduit end
    set_interface_property addr EXPORT_OF asmi_parallel_0.addr
    add_interface bulk_erase conduit end
    set_interface_property bulk_erase EXPORT_OF asmi_parallel_0.bulk_erase
    add_interface busy conduit end
    set_interface_property busy EXPORT_OF asmi_parallel_0.busy
    add_interface clkin clock sink
    set_interface_property clkin EXPORT_OF asmi_parallel_0.clkin
    add_interface data_valid conduit end
    set_interface_property data_valid EXPORT_OF asmi_parallel_0.data_valid
    add_interface datain conduit end
    set_interface_property datain EXPORT_OF asmi_parallel_0.datain
    add_interface dataout conduit end
    set_interface_property dataout EXPORT_OF asmi_parallel_0.dataout
    add_interface en4b_addr conduit end
    set_interface_property en4b_addr EXPORT_OF asmi_parallel_0.en4b_addr
    add_interface fast_read conduit end
    set_interface_property fast_read EXPORT_OF asmi_parallel_0.fast_read
    add_interface illegal_erase conduit end
    set_interface_property illegal_erase EXPORT_OF asmi_parallel_0.illegal_erase
    add_interface illegal_write conduit end
    set_interface_property illegal_write EXPORT_OF asmi_parallel_0.illegal_write
    add_interface rden conduit end
    set_interface_property rden EXPORT_OF asmi_parallel_0.rden
    add_interface rdid_out conduit end
    set_interface_property rdid_out EXPORT_OF asmi_parallel_0.rdid_out
    add_interface read_rdid conduit end
    set_interface_property read_rdid EXPORT_OF asmi_parallel_0.read_rdid
    add_interface read_status conduit end
    set_interface_property read_status EXPORT_OF asmi_parallel_0.read_status
    add_interface reset reset sink
    set_interface_property reset EXPORT_OF asmi_parallel_0.reset
    add_interface shift_bytes conduit end
    set_interface_property shift_bytes EXPORT_OF asmi_parallel_0.shift_bytes
    add_interface status_out conduit end
    set_interface_property status_out EXPORT_OF asmi_parallel_0.status_out
    add_interface wren conduit end
    set_interface_property wren EXPORT_OF asmi_parallel_0.wren
    add_interface write conduit end
    set_interface_property write EXPORT_OF asmi_parallel_0.write

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}
