//---------------------------------------------------------------------------
//   WARRANTY:
//   Use all material in this file at your own risk.  Mentor Graphics, Corp.
//   makes no claims about any material contained in this file.
//---------------------------------------------------------------------------

interface signal_monitor_bfm #(int unsigned SIGNAL_SIZE=4, int unsigned BUFFER_SIZE=1) (
input clock,
input [SIGNAL_SIZE-1:0] signals_in);
// pragma attribute signal_monitor_bfm partition_interface_xif

//---------------------------------------------------------------------------
// Declarations
//---------------------------------------------------------------------------

signal_monitor_pkg::signal_monitor_proxy #(SIGNAL_SIZE,BUFFER_SIZE) proxy; // pragma tbx oneway proxy.write

bit ctrl_monitor_en; // defaults to 0
bit monitor_en; // defaults to 0
bit monitor_en1; // defaults to 0
bit send_signals;
bit send_signals_next;
int unsigned ptr;
int unsigned timeout_cnt;
int unsigned timeout_pat;
int unsigned timeout_max;
bit load_buffer;

bit [SIGNAL_SIZE-1:0] signals_last;
bit [SIGNAL_SIZE-1:0] signals_buffer [BUFFER_SIZE];
bit [BUFFER_SIZE-1:0] signals_valid;
bit [BUFFER_SIZE-1:0] valid_next;

event new_pattern;
bit [SIGNAL_SIZE-1:0] signal_pattern;
bit [SIGNAL_SIZE-1:0] signals_reg;
bit [7:0] find_count;
bit [7:0] pattern_count;
bit pattern_valid;
bit wr_pattern;

// Local typedef for easy packing
typedef struct packed {
    bit valid;    // valid bit
    bit [SIGNAL_SIZE-1:0] data; } packed_signals_s;

   typedef bit[SIGNAL_SIZE : 0] packed_signals_t;

   typedef packed_signals_t[BUFFER_SIZE-1:0] packed_signals_buf_t;

//---------------------------------------------------------------------------
// Tasks to talk to the proxy
//---------------------------------------------------------------------------
// control monitoring enable and timeout
function void monitor_control(bit enable, int unsigned timeout); // pragma tbx xtf
  ctrl_monitor_en = enable;
  timeout_max = timeout;
endfunction

function void get_signal_pattern(bit [SIGNAL_SIZE-1:0] pattern_to_find, bit[7:0] count ); // pragma tbx xtf
  signal_pattern = pattern_to_find;
  find_count = count;
  -> new_pattern;
endfunction

task get_signals(output bit [SIGNAL_SIZE-1:0] signals_now); // pragma tbx xtf
// have wait on clock as first statement. 
  @(posedge clock);
  signals_now = signals_in;
endtask

//---------------------------------------------------------------------------
// Check incoming signals against pattern and send to proxy
//---------------------------------------------------------------------------
// Register incoming signals
always @(posedge clock) begin
  signals_reg <= signals_in;
end

initial begin
  forever begin
    @new_pattern;
    @(posedge clock);
    wr_pattern <= 1'b1;
    @(posedge clock);
    wr_pattern <= 1'b0;
  end
end

always @(posedge clock) begin
  if(wr_pattern) begin
    pattern_valid <= 1'b1;
    pattern_count <= 'b1; // sneaky way to avoid decrementer
  end else begin
    if(pattern_valid) begin
      if(signal_pattern == signals_reg) begin
        pattern_count <= pattern_count + 1;
        if(find_count == pattern_count) begin
          proxy.bfm_found_pattern(1'b1,signals_reg);
          pattern_valid <= 1'b0;
        end
      end else begin
        if(timeout_pat >= timeout_max) begin
          proxy.bfm_found_pattern(1'b0,'b0);
          pattern_valid <= 1'b0;
        end
      end
    end
  end
end

//---------------------------------------------------------------------------
// Capture and send transaction to monitor proxy on change
//---------------------------------------------------------------------------
// timeout counter for signal capture
always @(posedge clock) begin
  if(monitor_en) begin
    if(send_signals) begin
      timeout_cnt <= 'b0;
    end else begin
      timeout_cnt <= timeout_cnt + 1;
    end
  end else begin
    timeout_cnt <= 'b0;
  end
end

// timeout counter for signal pattern
always @(posedge clock) begin
  if(monitor_en) begin
    if(pattern_valid) begin
      timeout_pat <= timeout_cnt + 1;
    end else begin
      timeout_pat <= 'b0;
    end
  end else begin
    timeout_pat <= 'b0;
  end
end

// Buffer write pointer
always @(posedge clock) begin
  if(monitor_en) begin
    if(send_signals_next) begin
      ptr <= 'b0;
    end else if(load_buffer) begin
      ptr <= ptr + 1;
    end else begin
      ptr <= ptr;
    end
  end else begin
    ptr <= 'b0;
  end
end

// Calculate valid bits
always_comb begin
  if(send_signals) begin
    // simultaneous load
    if(monitor_en && (!monitor_en1 || (signals_last != signals_in))) begin
      valid_next = 1; // entry 0 will be loaded
    end else begin
      valid_next = 'b0;
    end
  end else begin
    if(monitor_en && (!monitor_en1 || (signals_last != signals_in))) begin
      valid_next = signals_valid | (1<<ptr);
    end else begin
     valid_next = signals_valid;
    end
  end
end

always_comb begin
  if(monitor_en && (!monitor_en1 || (signals_last != signals_in))) begin
    load_buffer = 1;
  end else begin
    load_buffer = 0;
  end
end

// Store incoming signals and register other signals
always @(posedge clock) begin
  monitor_en <= ctrl_monitor_en;
  monitor_en1 <= monitor_en;
  signals_valid <= valid_next;
  if(load_buffer) begin
    signals_buffer[ptr] <= signals_in;
    signals_last <= signals_in;
  end
end
// Calculate when to send signals to the proxy
always_comb begin
  if(monitor_en && (!monitor_en1 || (signals_last != signals_in) || (timeout_cnt >= timeout_max))) begin
    if((ptr == (BUFFER_SIZE-1)) || ((timeout_cnt >= timeout_max) && !send_signals)) begin
      send_signals_next <= 1;
    end else begin
      send_signals_next <= 0;
    end
  end else begin
    send_signals_next <= 0;
  end
end

// When buffer is full send the buffer to the proxy
always @(posedge clock) begin
  if(send_signals) begin
    buffer_to_proxy();
  end
  send_signals <= send_signals_next;
end

// send the entire buffer to the proxy
function void buffer_to_proxy ();

  int unsigned pkt_ptr;
  packed_signals_s signals_s;
  packed_signals_buf_t signals_packet;

  for(pkt_ptr=0;pkt_ptr<BUFFER_SIZE;pkt_ptr++) begin
    if(signals_valid[pkt_ptr]) begin
      signals_s.valid = 1'b1;
      signals_s.data = signals_buffer[pkt_ptr];
    end else begin
      signals_s.valid = 1'b0;
      signals_s.data = 'b0;
    end

    // Note implicit cast from packed struct to packed bit type
    signals_packet[pkt_ptr] = signals_s;
   end
   proxy.write(signals_packet);
  
endfunction

endinterface

