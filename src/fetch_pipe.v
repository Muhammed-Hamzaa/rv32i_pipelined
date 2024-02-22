module fetch_pipe(
  input wire         clk,
  input wire         jal,
  input wire         jalr,
  input wire         branch_out,
  input wire         load,
  input wire  [31:0] instr_out,
  input wire  [31:0] pc_prev_address,

  output reg [31:0] prev_fpipe_address_out,
  output reg [31:0] instr_fpipe
);

//   reg [31:0] prev_fpipe_address_out, instr_fpipe;
  reg flush_pipeline;

  always @ (posedge clk) begin
    if (jal | jalr | branch_out) begin
      // If jal, jalr, or branch out is high, flush the pipeline for one cycle
      prev_fpipe_address_out <= 32'b0;
      instr_fpipe <= 32'b0;
      flush_pipeline <= 1; // Set flag to flush for one cycle
    end 
    else if (flush_pipeline) begin
      // Stall the pipeline for one additional cycle after flushing
      prev_fpipe_address_out <= 32'b0;
      instr_fpipe <= 32'b0;
      flush_pipeline <= 0; // Reset flag after one cycle stall
    end
    else if (load) begin
      //stall pipeline
      prev_fpipe_address_out <= prev_fpipe_address_out;
      instr_fpipe <= instr_fpipe;
    end
    else begin
      // For other instructions, proceed normally
      prev_fpipe_address_out <= pc_prev_address;
      instr_fpipe <= instr_out;
    end
  end

//   assign prev_fpipe_address_out_out = prev_fpipe_address_out;
//   assign instr_fpipetion = instr_fpipe;
endmodule