
module arqt (
	buttons_export,
	clk_clk,
	leds_export,
	reset_reset_n,
	lcd_rw_writeresponsevalid_n,
	lcd_rs_writeresponsevalid_n,
	lcd_enable_writeresponsevalid_n,
	lcd_display_readdata);	

	input	[3:0]	buttons_export;
	input		clk_clk;
	output	[3:0]	leds_export;
	input		reset_reset_n;
	output		lcd_rw_writeresponsevalid_n;
	output		lcd_rs_writeresponsevalid_n;
	output		lcd_enable_writeresponsevalid_n;
	output	[7:0]	lcd_display_readdata;
endmodule
