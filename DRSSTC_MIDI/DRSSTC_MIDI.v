module DRSSTC_MIDI(CLOCK_50,ORG_BUTTON,SW,LEDG,ARD_D,OUT,ELCD_D,ELCD_ENA,ELCD_RS,ELCD_RW);

		input					CLOCK_50;
		input		[2:0]		ORG_BUTTON;
		input		[9:0]		SW;
		output	[9:0]		LEDG;
		input		[13:0]	ARD_D;
		output	[1:0]		OUT;
		output	[7:0]		ELCD_D;
		output				ELCD_ENA;
		output				ELCD_RS;
		output				ELCD_RW;

		reg		[9:0]		LEDG;
		
		reg 		[31:0]	ontime1;
		reg 		[31:0]	ontime2;
		reg 		[31:0]	offtime1;
		reg 		[31:0]	offtime2;
		
		reg 		[31:0]	ontimecount1;
		reg 		[31:0]	ontimecount2;
		reg 		[31:0]	offtimecount1;
		reg 		[31:0]	offtimecount2;
		
		reg		[31:0]	gen0cnt;
		reg		[31:0]	gen0lim;
		reg					gen0out;
		
		reg		[31:0]	gen1cnt;
		reg		[31:0]	gen1lim;
		reg					gen1out;
		
		reg		[31:0]	gen2cnt;
		reg		[31:0]	gen2lim;
		reg					gen2out;
		
		reg		[31:0]	gen3cnt;
		reg		[31:0]	gen3lim;
		reg					gen3out;

		
		reg		[31:0]	gen4cnt;
		reg		[31:0]	gen4lim;
		reg					gen4out;
		
		reg		[31:0]	gen5cnt;
		reg		[31:0]	gen5lim;
		reg					gen5out;
		
		reg		[31:0]	gen6cnt;
		reg		[31:0]	gen6lim;
		reg					gen6out;

		reg		[31:0]	gen7cnt;
		reg		[31:0]	gen7lim;
		reg					gen7out;
		
		reg		[4:0]		readcnt;
		
		wire 		[1:0]		OUT_OR;
		//wire		[1:0]		OUT_PR;
		reg		[1:0]		OUT_PR;
		
		reg		[31:0]	buff;
		reg		[31:0]	buff1;
		
//----------------------------------------//

	//assign LEDG[9:0] = LED[9:0];
	

//----------------------------------------//

	assign OUT_OR[0] = gen0out | gen1out | gen2out | gen3out;
	assign OUT_OR[1] = gen4out | gen5out | gen6out | gen7out;
	
	assign OUT[0] = OUT_PR[0];
	assign OUT[1] = OUT_PR[1];
	
	//always@ (posedge ARD_D[12]) begin
	
	//LEDG <= ARD_D[13];
	
	//end
	
	always@ (posedge ARD_D[10]) begin
	
	if (ARD_D[11]) begin
		readcnt = 0;
	end
	
	if({ARD_D[12],ARD_D[13]} == 2'b00) begin
		case (readcnt)
			5'b00000:	buff1[7:0] = ARD_D[9:2];
			5'b00001:	buff1[15:8] = ARD_D[9:2];
			5'b00010:	buff1[23:16] = ARD_D[9:2];
			5'b00011:	begin buff1[31:24] = ARD_D[9:2]; ontime1 = buff1; end
			5'b00100:	ontime2[7:0] = ARD_D[9:2];
			5'b00101:	ontime2[15:8] = ARD_D[9:2];
			5'b00110:	ontime2[23:16] = ARD_D[9:2];
			5'b00111:	ontime2[31:24] = ARD_D[9:2];
			5'b01000:	offtime1[7:0] = ARD_D[9:2];
			5'b01001:	offtime1[15:8] = ARD_D[9:2];
			5'b01010:	offtime1[23:16] = ARD_D[9:2];
			5'b01011:	offtime1[31:24] = ARD_D[9:2];
			5'b01100:	offtime2[7:0] = ARD_D[9:2];
			5'b01101:	offtime2[15:8] = ARD_D[9:2];
			5'b01110:	offtime2[23:16] = ARD_D[9:2];
			5'b01111:	offtime2[31:24] = ARD_D[9:2];
		endcase
	end
	else if({ARD_D[12],ARD_D[13]} == 2'b01) begin
		case (readcnt)
			5'b00000:	buff[7:0] = ARD_D[9:2];
			5'b00001:	buff[15:8] = ARD_D[9:2];
			5'b00010:	buff[23:16] = ARD_D[9:2];
			5'b00011:	begin buff[31:24] = ARD_D[9:2]; gen0lim = buff; end
			5'b00100:	gen1lim[7:0] = ARD_D[9:2];
			5'b00101:	gen1lim[15:8] = ARD_D[9:2];
			5'b00110:	gen1lim[23:16] = ARD_D[9:2];
			5'b00111:	gen1lim[31:24] = ARD_D[9:2];
			5'b01000:	gen2lim[7:0] = ARD_D[9:2];
			5'b01001:	gen2lim[15:8] = ARD_D[9:2];
			5'b01010:	gen2lim[23:16] = ARD_D[9:2];
			5'b01011:	gen2lim[31:24] = ARD_D[9:2];
			5'b01100:	gen3lim[7:0] = ARD_D[9:2];
			5'b01101:	gen3lim[15:8] = ARD_D[9:2];
			5'b01110:	gen3lim[23:16] = ARD_D[9:2];
			5'b01111:	gen3lim[31:24] = ARD_D[9:2];
			5'b10000:	gen4lim[7:0] = ARD_D[9:2];
			5'b10001:	gen4lim[15:8] = ARD_D[9:2];
			5'b10010:	gen4lim[23:16] = ARD_D[9:2];
			5'b10011:	gen4lim[31:24] = ARD_D[9:2];
			5'b10100:	gen5lim[7:0] = ARD_D[9:2];
			5'b10101:	gen5lim[15:8] = ARD_D[9:2];
			5'b10110:	gen5lim[23:16] = ARD_D[9:2];
			5'b10111:	gen5lim[31:24] = ARD_D[9:2];
			5'b11000:	gen6lim[7:0] = ARD_D[9:2];
			5'b11001:	gen6lim[15:8] = ARD_D[9:2];
			5'b11010:	gen6lim[23:16] = ARD_D[9:2];
			5'b11011:	gen6lim[31:24] = ARD_D[9:2];
			5'b11100:	gen7lim[7:0] = ARD_D[9:2];
			5'b11101:	gen7lim[15:8] = ARD_D[9:2];
			5'b11110:	gen7lim[23:16] = ARD_D[9:2];
			5'b11111:	gen7lim[31:24] = ARD_D[9:2];
			
		endcase
	end
	
	readcnt = readcnt + 1;
	
	end
	
	always@ (posedge CLOCK_50) begin
	
	// ========== ON OFF TIME PROTECT ========== //
	if (OUT_OR[0]) begin

 if (offtimecount1 == 0 && ontimecount1 <= ontime1) begin

 OUT_PR[0] <= 1'b1;
 ontimecount1 <= ontimecount1 + 1;
 offtimecount1 <= 1'b0;

 end
 else begin

 OUT_PR[0] <= 1'b0;
 if (offtimecount1 < offtime1) begin
 offtimecount1 <= offtimecount1 + 1;
 end
 else begin
 offtimecount1 <= 0;
 end
 end

 end
 else begin // OUT_OR[0] is LOW
 OUT_PR[0] <= 1'b0;
 ontimecount1 <= 1'b0;
 if (offtimecount1 < offtime1) begin
 offtimecount1 <= offtimecount1 + 1;
 end
 else begin
 offtimecount1 <= 0;
 end
 end
 
	// ========== ON OFF TIME PROTECT END ========== //


	// ========== ON OFF TIME PROTECT 2 ========== //
	if (OUT_OR[1]) begin

	if (offtimecount2 == 0 && ontimecount2 < ontime2) begin

		OUT_PR[1] <= 1'b1;
		ontimecount2 = ontimecount2 + 1;
		offtimecount2 = 1'b0;

	end
	else begin

		OUT_PR[1] <= 1'b0;
		offtimecount2 = offtimecount2 + 1;
	end

	end
	else begin // OUT_OR[1] is LOW

		OUT_PR[1] <= 1'b0;
		offtimecount2 = offtimecount2 + 1;
	end

	if (offtimecount2 >= offtime2) begin
		ontimecount2 = 1'b0;
		offtimecount2 = 1'b0;
	end


	// ========== ON OFF TIME PROTECT 2 END ========== //
	
	
	//ontime1 <= 12'b111111111111;
	//gen0lim <= 20'b11111111111111111111;
	//gen1lim <= 20'b11111111111111111111;
	
	// ========= GEN0 START ========== //
	if (gen0cnt >= gen0lim) begin
		gen0cnt <= 0;
		if (gen0lim > ontime1) begin
			gen0out <= 1'b1;
		end
		else begin
			gen0out <= 1'b0;
		end
   end
	else if (gen0cnt >= ontime1) begin
		gen0out <= 1'b0;
		gen0cnt <= gen0cnt + 1;
	end
   else begin
		gen0cnt <= gen0cnt + 1;
   end
	// ========= GEN0 END ========== //
	
	// ========= GEN1 START ========== //
	if (gen1cnt >= gen1lim) begin
		gen1cnt <= 0;
		if (gen1lim > ontime1) begin
			gen1out <= 1'b1;
		end
		else begin
			gen1out <= 1'b0;
		end
   end
	else if (gen1cnt >= ontime1) begin
		gen1out <= 1'b0;
		gen1cnt <= gen1cnt + 1;
	end
   else begin
		gen1cnt <= gen1cnt + 1;
   end
	// ========= GEN1 END ========== //
	
	// ========= GEN2 START ========== //
	if (gen2cnt >= gen2lim) begin
		gen2cnt <= 0;
		if (gen2lim > ontime1) begin
			gen2out <= 1'b1;
		end
		else begin
			gen2out <= 1'b0;
		end
   end
	else if (gen2cnt >= ontime1) begin
		gen2out <= 1'b0;
		gen2cnt <= gen2cnt + 1;
	end
   else begin
		gen2cnt <= gen2cnt + 1;
   end
	// ========= GEN2 END ========== //
	
	// ========= GEN3 START ========== //
	if (gen3cnt >= gen3lim) begin
		gen3cnt <= 0;
		if (gen3lim > ontime1) begin
			gen3out <= 1'b1;
		end
		else begin
			gen3out <= 1'b0;
		end
   end
	else if (gen3cnt >= ontime1) begin
		gen3out <= 1'b0;
		gen3cnt <= gen3cnt + 1;
	end
   else begin
		gen3cnt <= gen3cnt + 1;
   end
	// ========= GEN3 END ========== //
	

	
	// ========= GEN4 START ========== //
	if (gen4cnt >= gen4lim) begin
		gen4cnt <= 0;
		if (gen4lim > ontime2) begin
			gen4out <= 1'b1;
		end
		else begin
			gen4out <= 1'b0;
		end
   end
	else if (gen4cnt >= ontime2) begin
		gen4out <= 1'b0;
		gen4cnt <= gen4cnt + 1;
	end
   else begin
		gen4cnt <= gen4cnt + 1;
   end
	// ========= GEN4 END ========== //
	
	// ========= GEN5 START ========== //
	if (gen5cnt >= gen5lim) begin
		gen5cnt <= 0;
		if (gen5lim > ontime2) begin
			gen5out <= 1'b1;
		end
		else begin
			gen5out <= 1'b0;
		end
   end
	else if (gen5cnt >= ontime2) begin
		gen5out <= 1'b0;
		gen5cnt <= gen5cnt + 1;
	end
   else begin
		gen5cnt <= gen5cnt + 1;
   end
	// ========= GEN5 END ========== //
	
	// ========= GEN6 START ========== //
	if (gen6cnt >= gen6lim) begin
		gen6cnt <= 0;
		if (gen6lim > ontime2) begin
			gen6out <= 1'b1;
		end
		else begin
			gen6out <= 1'b0;
		end
   end
	else if (gen6cnt >= ontime2) begin
		gen6out <= 1'b0;
		gen6cnt <= gen6cnt + 1;
	end
   else begin
		gen6cnt <= gen6cnt + 1;
   end
	// ========= GEN6 END ========== //
	
	// ========= GEN7 START ========== //
	if (gen7cnt >= gen7lim) begin
		gen7cnt <= 0;
		if (gen7lim > ontime2) begin
			gen7out <= 1'b1;
		end
		else begin
			gen7out <= 1'b0;
		end
   end
	else if (gen7cnt >= ontime2) begin
		gen7out <= 1'b0;
		gen7cnt <= gen7cnt + 1;
	end
   else begin
		gen7cnt <= gen7cnt + 1;
   end
	// ========= GEN7 END ========== //
	
	end

endmodule
