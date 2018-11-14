procedure Swap (X, Y : in out Int_Ptr) is
   Tmp : Int_Ptr := X; --  ownership of X is moved to Tmp
		       --  X gets W
begin
   X := Y;   --  ownership of Y is moved to X
	     --  Y gets W
	     --  X gets RW
   Y := Tmp; --  ownership of Tmp is moved to Y
	     --  Tmp gets W
	     --  Y gets RW
   return;   --  When exiting Swap, X and Y should be RW
	     --  Tmp, being a local variable, is not 
	     --  required to have any permission.
end Swap;
