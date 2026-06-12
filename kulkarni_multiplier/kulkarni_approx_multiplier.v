module kulkarni_approx_multiplier(
input [1:0]a,b,
output [3:0]prod
    );
    
    assign prod[0] = a[0]&b[0];
    assign prod[1] = (a[0]&b[1])^(a[1]&b[0]);
    assign prod[2] = b[1]&a[1];
    assign prod[3]=0;
endmodule
