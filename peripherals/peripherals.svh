`ifndef PERIPHERALS_SVH
`define PERIPHERALS_SVH

`include "common.svh"
`include "ADC.svh"
`include "chip_ID.svh"
`include "Si3000.svh"
`include "debug_counter_led.svh"
`include "FASM_register.svh"
`include "interrupt.svh"
`include "SD_SPI.svh"
`include "M23XX1024.svh"
`include "timer.svh"
`include "Serial_8051.svh"
`include "I2C.svh"
`include "PWM.svh"


    
    parameter int     SRAM_SCK_RATE           = 16000000;
    parameter int     SRAM_CLK_SCK_RATIO      = ACTUAL_CLK_RATE / SRAM_SCK_RATE;
    
    parameter int     SD_SLOW_SCK_RATE        = 200000;
    parameter int     SD_FAST_SCK_RATE        = 8000000;
    
    parameter int     SD_CLK_SLOW_SCK_RATIO  = ACTUAL_CLK_RATE / SD_SLOW_SCK_RATE;
    parameter int     SD_CLK_FAST_SCK_RATIO  = ACTUAL_CLK_RATE / SD_FAST_SCK_RATE;
    
    parameter int     SD_BUFFER_SIZE_IN_BYTES = 1024;


extern module peripherals #(parameter FOR_SIM = 0) (
    //=======================================================================
    // clock / reset
    //=======================================================================
        
        input wire                  clk,                             // clock input
        input wire                  reset_n,                         // reset, active low
        
    //=======================================================================
    // Interrupt
    //=======================================================================
                
        input wire  unsigned [NUM_OF_INTx - 1 : 0]  INTx, // external interrupt 
        
        input wire                                  interrupt_return,
        output  logic unsigned [DATA_WIDTH - 1 : 0] int_addr,
        output  logic                               int_gen,
        
    //=======================================================================
    // Wishbone Interface (FASM synchronous RAM dual port model)
    //=======================================================================
        input  wire                                 WB_RD_STB_I,
        input  wire  unsigned [DATA_WIDTH - 1 : 0]  WB_RD_ADR_I,
        output logic unsigned [DATA_WIDTH - 1 : 0]  WB_RD_DAT_O,
        output wire                                 WB_RD_ACK_O,
                
        input  wire                                 WB_WR_STB_I,
        input  wire                                 WB_WR_WE_I,
        input  wire unsigned [DATA_WIDTH - 1 : 0]   WB_WR_ADR_I,
        input  wire unsigned [DATA_WIDTH - 1 : 0]   WB_WR_DAT_I,
        output wire                                 WB_WR_ACK_O,
        
        
    //=======================================================================
    // Timer 
    //=======================================================================
        input  wire                                 timer_event_pulse,
        output logic                                timer_pulse_out,
    //=======================================================================
    // UART
    //=======================================================================
        input wire                                  UART_RXD,
        output wire                                 UART_TXD,
    
        input wire                                  UART_AUX_RXD,
        output wire                                 UART_AUX_TXD,
        
    //=======================================================================
    // Debug LED
    //=======================================================================
        output wire                                 debug_led,
        output wire                                 debug_counter_pulse,
    
    //=======================================================================
    // M23XX1024
    //=======================================================================
        input   wire                                mem_so,
        output  wire                                mem_si,
        output  wire                                mem_hold_n,
        output  wire                                mem_cs_n, 
        output  wire                                mem_sck,
        
     //=======================================================================
    // Si3000
    //=======================================================================
        input   wire                                Si3000_SDO,
        output  wire                                Si3000_SDI,
        input   wire                                Si3000_SCLK,
        output  wire                                Si3000_MCLK,
        input   wire                                Si3000_FSYNC_N,
        output  wire                                Si3000_RESET_N,
        
    //=======================================================================
    // SD Card
    //=======================================================================
        
        output wire                                 sd_cs_n,
        output wire                                 sd_spi_clk,
        input  wire                                 sd_data_out,
        output wire                                 sd_data_in,         
        
    //=======================================================================
    // MAX10 ADC
    //=======================================================================
        input   wire                                adc_pll_clock_clk,                   
        input   wire                                adc_pll_locked_export,
        
    //=======================================================================
    // I2C
    //=======================================================================
        
        input wire                                   sda_in, 
        input wire                                   scl_in,
        
        output wire                                  sda_out,
        output wire                                  scl_out,
    
    //=======================================================================
    // PWM
    //=======================================================================
        output wire unsigned [NUM_OF_PWM - 1 : 0]    pwm_out
        
    );

`endif