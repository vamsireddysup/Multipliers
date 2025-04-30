module tb_array_multiplier;
parameter N = 8;
logic clk;
initial clk = 0;
always #5 clk = ~clk;

logic rst_n;
logic [N-1:0] tb_a, tb_b;
logic [2*N-1:0] tb_prod;

// DUT instantiation
array_multiplier #(N) dut (
.a(tb_a),
.b(tb_b),
.prod(tb_prod)
);

// functional coverage
covergroup cg @(posedge clk);
 coverpoint tb_a {
  bins low   = {[0:31]};
  bins mid   = {[32:223]};
  bins high  = {[224:255]};
 }
 coverpoint tb_b;
 cross tb_a, tb_b;
endgroup

cg cover_inst;

// test stimulus
initial begin
 rst_n = 0;
 #20 rst_n = 1;
 cover_inst = new;
 repeat (1000_0) begin
  // randomize inputs each clock
  @(posedge clk);
  tb_a = $urandom;
  tb_b = $urandom;
  @(posedge clk);
  // self-checking assertion
  assert(tb_prod == tb_a * tb_b) else begin
   $error("Mismatch: a=0x%0h b=0x%0h got prod=0x%0h expected=0x%0h",
          tb_a, tb_b, tb_prod, tb_a*tb_b);
   $fatal;
  end
  cover_inst.sample();
 end
<<<<<<< HEAD
 $display("All %0d tests passed!", 100	);
 $display("Coverage: a low/mid/high each: %0t", $time);
=======
 $display("All %0d tests passed!", 1000_0);
 $display("Coverage End @: %0t", $time);
>>>>>>> c24c17437823e2b205f8eeb88234ffb59d3f412d
 $finish;
end

endmodule

