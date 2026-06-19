module topModule #(
    parameter N = 2,
    parameter K = 3,
    parameter pixel_bits = 8
)(
    input wire clk,
    input wire enable,
    input wire rst,
    input wire strobe_signal_pixel,
    input wire strobe_signal_kernel,
    input wire [pixel_bits-1:0] pixel,
    input wire [$clog2(K)-1:0] stride,
    input wire [$clog2(K)-1:0] kernel_width,
    input wire [pixel_bits-1:0] kernel_weight,
    input wire [$clog2(N*N)-1:0] pixel_number,
    //input wire [$clog2(N*K*N*K)-1:0] result_address,
    output wire ready,
    output wire done_total
);

    reg [pixel_bits*4-1:0] final_output;
    reg done;
    reg [1:0] state;

    genvar i;
    generate
        for(i = 0; i < 8; i = i + 1)begin
            deconv2D #(
                .N(N),
                .K(K),
                .pixel_bits(pixel_bits)
            ) uut (
                .clk(clk), 
                .enable(enable), 
                .rst(rst), 
                .strobe_signal_pixel(strobe_signal_pixel), 
                .strobe_signal_kernel(strobe_signal_kernel), 
                .pixel(pixel), 
                .stride(stride), 
                .kernel_width(kernel_width), 
                .kernel_weight(kernel_weight), 
                .pixel_number(pixel_number), 
                .result_address(result_address), 
                .final_output(final_output), 
                .ready(ready), 
                .done(done)
            );
        end
    endgenerate
    
endmodule