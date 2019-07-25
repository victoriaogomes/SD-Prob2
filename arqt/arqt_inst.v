	arqt u0 (
		.buttons_export                  (<connected-to-buttons_export>),                  //                    buttons.export
		.clk_clk                         (<connected-to-clk_clk>),                         //                        clk.clk
		.lcd_display_readdata            (<connected-to-lcd_display_readdata>),            //                lcd_display.readdata
		.lcd_enable_writeresponsevalid_n (<connected-to-lcd_enable_writeresponsevalid_n>), //                 lcd_enable.writeresponsevalid_n
		.lcd_rs_writeresponsevalid_n     (<connected-to-lcd_rs_writeresponsevalid_n>),     //                     lcd_rs.writeresponsevalid_n
		.lcd_rw_writeresponsevalid_n     (<connected-to-lcd_rw_writeresponsevalid_n>),     //                     lcd_rw.writeresponsevalid_n
		.leds_export                     (<connected-to-leds_export>),                     //                       leds.export
		.reset_reset_n                   (<connected-to-reset_reset_n>),                   //                      reset.reset_n
		.uart_0_external_connection_rxd  (<connected-to-uart_0_external_connection_rxd>),  // uart_0_external_connection.rxd
		.uart_0_external_connection_txd  (<connected-to-uart_0_external_connection_txd>)   //                           .txd
	);

