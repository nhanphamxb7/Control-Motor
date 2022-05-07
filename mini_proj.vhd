library ieee;
use ieee.std_logic_1164.all;

entity mini_proj is
	port
	(
			------------ CLOCK ------------
		CLOCK2_50       	:in    	std_logic;
		CLOCK3_50       	:in    	std_logic;
		CLOCK4_50       	:in    	std_logic;
		CLOCK_50        	:in    	std_logic;

		------------ LED ------------
		LEDR            	:out   	std_logic_vector(9 downto 0);

		------------ SDRAM ------------
		DRAM_ADDR       	:out   	std_logic_vector(12 downto 0);
		DRAM_BA         	:out   	std_logic_vector(1 downto 0);
		DRAM_CAS_N      	:out   	std_logic;
		DRAM_CKE        	:out   	std_logic;
		DRAM_CLK        	:out   	std_logic;
		DRAM_CS_N       	:out   	std_logic;
		DRAM_DQ         	:inout 	std_logic_vector(15 downto 0);
		DRAM_LDQM       	:out   	std_logic;
		DRAM_RAS_N      	:out   	std_logic;
		DRAM_UDQM       	:out   	std_logic;
		DRAM_WE_N       	:out   	std_logic
	);
end entity;

architecture rtl of mini_proj is

	component controller is
		port (
			clk_clk       : in    std_logic                     := 'X';             -- clk
			ledr_export   : out   std_logic_vector(9 downto 0);                     -- export
			reset_reset   : in    std_logic                     := 'X';             -- reset
			sdram_addr    : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_ba      : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_cas_n   : out   std_logic;                                        -- cas_n
			sdram_cke     : out   std_logic;                                        -- cke
			sdram_cs_n    : out   std_logic;                                        -- cs_n
			sdram_dq      : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_dqm     : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_ras_n   : out   std_logic;                                        -- ras_n
			sdram_we_n    : out   std_logic;                                        -- we_n
			sdram_clk_clk : out   std_logic                                         -- clk
		);
	end component controller;
	
	signal DQM: std_logic_vector(1 downto 0);

begin

	DRAM_UDQM <= DQM(1);
	DRAM_LDQM <= DQM(0);
	
	stage0: controller port map
	(
		clk_clk    		 	=> clock_50,
		ledr_export 		=> ledr,
		reset_reset  		=> '0',
		sdram_addr    		=> DRAM_ADDR,
		sdram_ba      		=> DRAM_BA,
		sdram_cas_n   		=> DRAM_CAS_N,
		sdram_cke     		=> DRAM_CKE,
		sdram_cs_n    		=> DRAM_CS_N,
		sdram_dq      		=> DRAM_DQ,
		sdram_dqm     		=> DQM,
		sdram_ras_n   		=> DRAM_RAS_N,
		sdram_we_n    		=> DRAM_WE_N,
		sdram_clk_clk 		=> DRAM_CLK
	);

end rtl;