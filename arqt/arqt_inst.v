	arqt u0 (
		.buttons_export                  (<connected-to-buttons_export>),                  //     buttons.export
		.clk_clk                         (<connected-to-clk_clk>),                         //         clk.clk
		.leds_export                     (<connected-to-leds_export>),                     //        leds.export
		.reset_reset_n                   (<connected-to-reset_reset_n>),                   //       reset.reset_n
		.lcd_rw_writeresponsevalid_n     (<connected-to-lcd_rw_writeresponsevalid_n>),     //      lcd_rw.writeresponsevalid_n
		.lcd_rs_writeresponsevalid_n     (<connected-to-lcd_rs_writeresponsevalid_n>),     //      lcd_rs.writeresponsevalid_n
		.lcd_enable_writeresponsevalid_n (<connected-to-lcd_enable_writeresponsevalid_n>), //  lcd_enable.writeresponsevalid_n
		.lcd_display_readdata            (<connected-to-lcd_display_readdata>)             // lcd_display.readdata
	);

