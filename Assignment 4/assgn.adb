with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
package body Assgn is 

   
   --Initialize first array
   procedure Init_Array (Arr: in out BINARY_ARRAY) is
      package Rand is new Ada.Numerics.Discrete_Random (BINARY_NUMBER);
      use Rand;
      G: Generator;
      
   begin
      Reset(G);
      for i in 1..15 loop
         Arr(i) := Random(G);
      end loop;
   end Init_Array;
     
   --Reverse array
   procedure Reverse_Bin_Arr (Arr: in out BINARY_ARRAY) is
      temp: BINARY_ARRAY;
      int : INTEGER;
      
   begin
      for i in 1..16 loop
         int := abs(i-17);
         temp(i) := Arr(int);
      end loop;
      for i in 1..16 loop
         Arr(i) := temp(i);
      end loop;
      
      end Reverse_Bin_Arr;
   
   --print array
   procedure Print_Bin_Arr(Arr : in BINARY_ARRAY) is
   begin
      for i in 1..16 loop
         Put(Integer'Image(Arr(i)));
      end loop;
      New_Line;
      end Print_Bin_Arr;
   
   --Integer to Binary
   function Int_To_Bin(Num: in INTEGER) return BINARY_ARRAY is
      Arr : BINARY_ARRAY := (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
      Quotient: Integer := Num;
      Remainder: Integer;
      
   begin
      for i in reverse 1..16 loop
         if Quotient = 0 then
            Remainder := 0;
         else
            Remainder := Quotient mod 2;
            Quotient := Quotient / 2;
         end if;
         Arr(i) := BINARY_NUMBER(Remainder);
      end loop;
      return Arr;
   end Int_To_Bin;
   
   --Binary to int
   function Bin_To_Int (Arr: in BINARY_ARRAY) return INTEGER is 
      Multiplier: Integer := 1;
      Result: Integer := 0;
      
   begin
      for i in 16..1 loop 
         Result := Result + Integer(Arr(i)) * Multiplier;
         Multiplier := Multiplier * 2;
      end loop;
      return Result;
   end Bin_To_Int;
   
   --Add two binary arrays
   function "+" (Left, Right : in BINARY_ARRAY) return BINARY_ARRAY is
      Temp: Integer := 0;
      Result : BINARY_ARRAY := (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
   begin
      for i in reverse 1..16 loop
         if Temp <= 0 then
            if Left(i) = 1 and Right(i) = 1 then
               Result(i) := BINARY_NUMBER(0);
               Temp := Temp + 1;
            elsif Left(i) = 0 and Right(i) = 0 then
               Result(i) := BINARY_NUMBER(0);
            else
               Result(i) := BINARY_NUMBER(1);
            end if;
            
         elsif Temp > 0 then
            if Left(i) = 1 and Right(i) = 1 then
               Result(i) := BINARY_NUMBER(1);
            elsif Left(i) = 0 and Right(i) = 0 then
               Result(i) := BINARY_NUMBER(1);
               Temp := Temp - 1;
            else
               Result(i) := BINARY_NUMBER(0);
            end if;
         end if;
      end loop;
      
      return Result;
      
   end "+";
   
   --Add Integer to Binary
   
   function"+" (Left : in INTEGER; Right : in BINARY_ARRAY) return BINARY_ARRAY is
      Left_Bin: BINARY_ARRAY := Int_To_Bin(Left);
   begin
      return Left_Bin + Right;
   end "+";
   
   -- Subtract binary arrays
   
   function "-" (Left, Right: in BINARY_ARRAY) return BINARY_ARRAY is
      SUB_RIGHT : BINARY_ARRAY := (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
      RESULT : BINARY_ARRAY;
      CURR : INTEGER := 0 ;
   begin
      for i in reverse Left'range loop
         SUB_RIGHT(i) := (1+Right(i)) rem 2;
         
      end loop;
      SUB_RIGHT := 1 + SUB_RIGHT;
      RESULT := LEFT + SUB_RIGHT;
      return RESULT;
      
   end "-";
   
   --Subtract binary from integer
   function "-" (Left : in Integer; Right : in BINARY_ARRAY) return BINARY_ARRAY is
      Left_Bin: BINARY_ARRAY := Int_To_Bin(Left);
   begin
      return Left_Bin - Right;
   end "-";
    
      
end Assgn;
