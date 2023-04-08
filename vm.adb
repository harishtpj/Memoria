-- Memoria - a simple URISC based Virtual Machine
-- Implements SUBLEQ instruction 

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Integer_Text_IO;

procedure VM is
    -- Global Declarations
    package IntIO renames Ada.Integer_Text_IO;

    type Code_Arr is array (0..255) of Integer;

    Program     : File_Type;
    Num, Mindex : Integer := 0;
    Memory      : Code_Arr := (others => 0);

    procedure Memoria (code: in out Code_Arr) is
        IP, NextIP : Integer := 0;
        function Src return Integer is (code(IP));
        function Dest return Integer is (code(IP + 1));
        function Branch return Integer is (code(IP + 2));
    begin
        -- Main loop for Code Execution
        while IP >= 0 loop
            NextIP := NextIP + 3;

            -- Handling Input
            if Src = -1 then
                declare
                    Ch: Character;
                begin
                    Get(Ch);
                    code(Dest) := Character'Pos(Ch);
                end;
            
            -- Handling Output
            elsif Dest = -1 then
                Put(Character'Val(code(Src)));

            -- General Execution
            else
                code(Dest) := code(Dest) - code(Src);
                if code(Dest) <= 0 then
                    NextIP := Branch;
                end if;
            end if;
            IP := NextIP;
        end loop;
        exception
            when others => Put_Line("Memoria Program Execution Error");
    end Memoria;
begin
    -- Check For CMDline Arguments
    if Argument_Count < 1 then
        Put_Line("Memoria VM needs atleast one CMDline argument");
        Put_Line("Usage: ./memoria <fname>");
    else
        -- Main Program of Memoria VM
        Open(Program, In_File, Argument(1));

        while not End_Of_File(Program) loop
            IntIO.Get(Program, Num);
            Memory(Mindex) := Num;
            Mindex := Mindex + 1;
        end loop;

        Close(Program);

        -- Execute Code
        Memoria(Memory);
    end if;
end VM;