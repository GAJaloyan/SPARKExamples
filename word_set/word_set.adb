type Word_Array is array (Positive range <>) of Word;

type Word_Set (Max_Size : Natural) is record
Content : Word_Array (1 .. Max_Size);
Length  : Natural := 0;
end record
  with Predicate => Length in 0 .. Max_Size and then 
  (for all I in 1 .. Length => Content (I) /= null);

function Search (S : String; D : Word_Set) return Natural 
  with
  Post => (Search'Result = 0 and then
	     (for all I in 1 .. D.Length 
		=> D.Content (I).all /= S))
  or else (Search'Result in 1 .. D.Length and then 
	     D.Content (Search'Result).all = S) is
begin
   for I in 1 .. D.Length loop
      pragma Loop_Invariant
	(for all K in 1 .. I - 1 => D.Content (K).all /= S);
      if D.Content (I).all = S then
	 return I;
      end if;
   end loop;
   return 0;
end Search;

procedure Insert (D : in out Word_Set; S : String) with
  Pre  => D.Length < D.Max_Size,
  Post => Search (S, D) > 0 is
begin
   D.Content (D.Length + 1) := new String'(S);
   D.Length := D.Length + 1;
end Insert;
