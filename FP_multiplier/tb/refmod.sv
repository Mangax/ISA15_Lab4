class refmod extends uvm_component;
    `uvm_component_utils(refmod)
    
    shortreal A_tmp;
	shortreal B_tmp;
	shortreal P_tmp;

    packet_in tr_in;
    packet_out tr_out;
    uvm_get_port #(packet_in) in;
    uvm_put_port #(packet_out) out;

	int count = 0;
	packet_in tr_in_zero;
	packet_out tr_out1;
	packet_out tr_out2;
	packet_out tr_out3;
	shortreal P_zero = 0.0;

    function new(string name = "refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr_out = packet_out::type_id::create("tr_out", this);
        tr_out1 = packet_out::type_id::create("tr_out1", this);
        tr_out2 = packet_out::type_id::create("tr_out2", this);
        tr_out3 = packet_out::type_id::create("tr_out3", this);
		tr_in_zero = packet_in::type_id::create("tr_in_zero", this);
 	endfunction: build_phase
    

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

		forever begin	
			if(count == 0) begin
				in.get(tr_in);

				A_tmp = $bitstoshortreal(tr_in.A);
				B_tmp = $bitstoshortreal(tr_in.B);
				P_tmp = A_tmp * B_tmp;

				tr_out.data = $shortrealtobits(P_zero);
				tr_out1.data = $shortrealtobits(P_tmp);
				
				count++;

				$display("Inputs A = %b (%0f), input B = %b (%0f)",tr_in_zero.A, A_tmp, tr_in_zero.B, B_tmp);
            	out.put(tr_out);
			end;
			if(count == 1) begin
				in.get(tr_in);

				A_tmp = $bitstoshortreal(tr_in.A);
				B_tmp = $bitstoshortreal(tr_in.B);
				P_tmp = A_tmp * B_tmp;

				tr_out.data = $shortrealtobits(P_zero);
				tr_out2.data = $shortrealtobits(P_tmp);

				count++;

				$display("Inputs A = %b (%0f), input B = %b (%0f)",tr_in_zero.A, A_tmp, tr_in_zero.B, B_tmp);
            	out.put(tr_out);
			end;
			if(count == 2) begin
				in.get(tr_in);

				A_tmp = $bitstoshortreal(tr_in.A);
				B_tmp = $bitstoshortreal(tr_in.B);
				P_tmp = A_tmp * B_tmp;

				tr_out.data = tr_out1.data;
				tr_out3.data = $shortrealtobits(P_tmp);


				count++;

				$display("Inputs A = %b (%0f), input B = %b (%0f)",tr_in.A, A_tmp, tr_in.B, B_tmp);
            	out.put(tr_out);
			end;
			if(count == 3) begin
				in.get(tr_in);

				A_tmp = $bitstoshortreal(tr_in.A);
				B_tmp = $bitstoshortreal(tr_in.B);
				P_tmp = A_tmp * B_tmp;

				tr_out.data = tr_out2.data;
				tr_out1.data = $shortrealtobits(P_tmp);

				count++;

				$display("Inputs A = %b (%0f), input B = %b (%0f)",tr_in.A, A_tmp, tr_in.B, B_tmp);
            	out.put(tr_out);
			end;
			if(count == 4) begin
				in.get(tr_in);

				A_tmp = $bitstoshortreal(tr_in.A);
				B_tmp = $bitstoshortreal(tr_in.B);
				P_tmp = A_tmp * B_tmp;

				tr_out.data = tr_out3.data;
				tr_out2.data = $shortrealtobits(P_tmp);
				
				count = 2;

				$display("Inputs A = %b (%0f), input B = %b (%0f)",tr_in.A, A_tmp, tr_in.B, B_tmp);
            	out.put(tr_out);
			end;
        end
    endtask: run_phase
endclass: refmod
