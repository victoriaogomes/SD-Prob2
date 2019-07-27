	component arqt is
		port (
			buttons_export                  : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			clk_clk                         : in  std_logic                    := 'X';             -- clk
			lcd_display_readdata            : out std_logic_vector(7 downto 0);                    -- readdata
			lcd_enable_writeresponsevalid_n : out std_logic;                                       -- writeresponsevalid_n
			lcd_rs_writeresponsevalid_n     : out std_logic;                                       -- writeresponsevalid_n
			lcd_rw_writeresponsevalid_n     : out std_logic;                                       -- writeresponsevalid_n
			leds_export                     : out std_logic_vector(3 downto 0);                    -- export
			reset_reset_n                   : in  std_logic                    := 'X';             -- reset_n
			rs232_0_external_interface_RXD  : in  std_logic                    := 'X';             -- RXD
			rs232_0_external_interface_TXD  : out std_logic                                        -- TXD
		);
	end component arqt;

	u0 : component arqt
		port map (
			buttons_export                  => CONNECTED_TO_buttons_export,                  --                    buttons.export
			clk_clk                         => CONNECTED_TO_clk_clk,                         --                        clk.clk
			lcd_display_readdata            => CONNECTED_TO_lcd_display_readdata,            --                lcd_display.readdata
			lcd_enable_writeresponsevalid_n => CONNECTED_TO_lcd_enable_writeresponsevalid_n, --                 lcd_enable.writeresponsevalid_n
			lcd_rs_writeresponsevalid_n     => CONNECTED_TO_lcd_rs_writeresponsevalid_n,     --                     lcd_rs.writeresponsevalid_n
			lcd_rw_writeresponsevalid_n     => CONNECTED_TO_lcd_rw_writeresponsevalid_n,     --                     lcd_rw.writeresponsevalid_n
			leds_export                     => CONNECTED_TO_leds_export,                     --                       leds.export
			reset_reset_n                   => CONNECTED_TO_reset_reset_n,                   --                      reset.reset_n
			rs232_0_external_interface_RXD  => CONNECTED_TO_rs232_0_external_interface_RXD,  -- rs232_0_external_interface.RXD
			rs232_0_external_interface_TXD  => CONNECTED_TO_rs232_0_external_interface_TXD   --                           .TXD
		);

