module sign_extend(In,ImmSrc,Imm_Ext);
    input [31:0] In;
    input [1:0] ImmSrc;
    output [31:0] Imm_Ext;


    //assign Imm_Ext = (In[31]) ? ({20(1'b1)},In[31:20]}) : 
                           //     {(20{1'b0)},In[31:20]}};

    assign Imm_Ext = (ImmSrc == 1'b1) ? {{20{In[31]}},In[31:25],In[11:7]} :
                                    {{20{In[31]}},In[31:20]}; 
  //  assign Imm_Ext = (In[31]) ? {{20{1'b1}}, In[31:20]} : 
   //                            {{20{1'b0}}, In[31:20]};

endmodule