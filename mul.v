function [63:0] mul (input [31:0] M, Q);
integer i;
reg [31:0] positive;
reg [31:0] negative;
reg [63:0] curr;
begin
    if(Q[0] == 0) begin
        positive[0] = 0;
        negative[0] = 0;
    end
    else 
        negative[0] = 1;
    for(i = 1; i < 32; i=i+1) begin
        if(~Q[i]) begin
            if(~Q[i-1]) begin
                positive[i-1] = 0;
                negative[i-1] = 0; 
            end
            else begin
                if(Q[i-1]) begin
                    positive[i-1] = 1;
                end
            end
        end
        else begin
            if(~Q[i-1]) begin
                negative[i-1] = 1;
            end
            else begin
                positive[i-1] = 0;
                negative[i-1] = 0;
            end
        end

        for (i = 0; i < 32; i = i + 1) begin
            if(positive[i] == 0 && negative[i] == 0){
                curr = 64'h0000;
                curr<<i;
            }
            else if (positive[i]) begin
                curr = M<<i;
                curr[63:M+i] = {(63-M+1){0}};
            end
            else if (negative[i]) begin
                curr = ~M + 1'b1;
                curr<<i;
                curr[63:M+i] = {(63-M+1){1}};
            end
            mul = mul + curr;
        end
    end

end
end function 