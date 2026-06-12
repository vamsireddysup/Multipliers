

module xor_4(
input a,b,c,d,
output s
    );
    /*wire w,x;
    assign w=~(c^d);
    assign x=~(w^b);
    assign s=x^a;
    */
    assign s=a^b^c^d;
endmodule


