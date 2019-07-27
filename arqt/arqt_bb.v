
module arqt (
	buttons_export,
	clk_clk,
	lcd_display_readdata,
	lcd_enable_writeresponsevalid_n,
	lcd_rs_writeresponsevalid_n,
	lcd_rw_writeresponsevalid_n,
	leds_export,
	reset_reset_n,
	rs232_0_external_interface_RXD,
	rs232_0_external_interface_TXD);	

	input	[3:0]	buttons_export;
	input		clk_clk;
	output	[7:0]	lcd_display_readdata;
	output		lcd_enable_writeresponsevalid_n;
	output		lcd_rs_writeresponsevalid_n;
	output		lcd_rw_writeresponsevalid_n;
	output	[3:0]	leds_export;
	input		reset_reset_n;
	input		rs232_0_external_interface_RXD;
	output		rs232_0_external_interface_TXD;
endmodule
